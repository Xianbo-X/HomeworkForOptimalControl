function [optconfpath,optstateindex,decT] = buzzwiredijkstra(Nx,Ny,Ntheta,Mx,My,Mtheta,wirefunction,x0)

inode    = coord2state(x0(1),x0(2),x0(3),Ny,Ntheta);
nmax     = Nx*Ny*Ntheta;          % max number of nodes
m        = Mx*My*Mtheta;
openT    = [zeros(nmax,1) inf*ones(nmax,1) zeros(nmax,1)]; % prealocate memory
decT     = zeros(1,nmax);           % simply to keep track of optimal decisions, not necesary for the algorithm
nopenT   = 1;                     % number of nodes in openT

openT(1,:) = [inode 0 -1];        %(node,cost-to-come to inode,prev. node)
closedT    = [zeros(nmax,1) inf*ones(nmax,1) zeros(nmax,1)]; % prealocate memory
nclosed    = 0;                         % number of nodes in closedT


while(1)
    % shortest distance -(cur)node, add to closed, stop if terminal
    [~,curnodeind]     = min(openT(:,2));
    curnode            = openT(curnodeind,1);
    curnodecost        = openT(curnodeind,2);
    nclosed            = nclosed + 1;
    closedT(nclosed,:) = openT(curnodeind,:);
    [ix_,~,~] = state2coord(curnode,Ny,Ntheta);
    if ix_ == Nx
        fnode = curnode;
        break;
    end
    
    % remove curnode from open, move last to its position
    if nopenT > 1
        openT(curnodeind,:) = openT(nopenT,:);
    end
    openT(nopenT,:) = [0 inf 0];
    nopenT = nopenT-1;
    
    % update neighboors of curnode
    % Obtain all valid neighboors that do not touch the wire
    for j = 1:m
        xneigh = nextstate(curnode,j,Nx,Ny,Ntheta,Mx,My,Mtheta);
        if(~any([closedT(:,1) == xneigh])) % if it in closed, skip it
            [ix_2,iy_2,itheta_2] = state2coord(xneigh,Ny,Ntheta);
            if metaltoucheswire(ix_2,iy_2,itheta_2,Nx,Ntheta,wirefunction)
                % in neigh touches the wire put it in the closed list
                nclosed = nclosed+1;
                closedT(nclosed,:) = openT(xneigh,:);
            else
                % if neigh does not touches the wire put it in open list if
                % it is not there already, or otherwise update it
                auxvec = [openT(:,1) == xneigh];
                if( any( auxvec )) % if it is in the open list update
                    indneighopen = find(auxvec);
                    if  curnodecost + 1 < openT(indneighopen,2)
                        openT(indneighopen,2) = curnodecost + 1;
                        openT(indneighopen,3) = curnode;
                        decT(curnode) = j;
                    end
                else % if not, add it to open
                    nopenT = nopenT + 1;
                    openT(nopenT,1) = xneigh;
                    openT(nopenT,2) = curnodecost + 1;
                    openT(nopenT,3) = curnode;
                    decT(curnode) = j;
                end
            end
            
        end
    end
end

[optconfpathx,optconfpathy,optconfpaththeta] = state2coord(fnode,Ny,Ntheta);
optconfpath   = [optconfpathx optconfpathy optconfpaththeta];
optstateindex = fnode;
node = fnode;
while( node ~= inode )
    indnode = find( closedT(:,1) == node);
    node = closedT(indnode,3);
    [optconfpathx,optconfpathy,optconfpaththeta] = state2coord(node,Ny,Ntheta);
    optconfpath   = [[optconfpathx optconfpathy optconfpaththeta];optconfpath];
    optstateindex = [node,optstateindex];
end

end