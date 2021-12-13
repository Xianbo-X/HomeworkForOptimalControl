function [mu,J] = buzzwiredp(Nx,Ny,Ntheta,Mx,My,Mtheta,wirefunction,flag)
if nargin == 7
    flag = 0;
end

n = Nx*Ny*Ntheta;
m = Mx*My*Mtheta;

D  = zeros(n,m);
C  = zeros(n,m);
Jh = inf*ones(n,1);
for i = 1:n
    [ix,iy,itheta] = state2coord(i,Ny,Ntheta);
    % terminal cost
    if ix == Nx
        if ~metaltoucheswire(ix,iy,itheta,Nx,Ntheta,wirefunction)
            Jh(i) = 0;
            C(i,:) = 0;
            D(i,:) = i;
        else
            Jh(i) = inf;
            C(i,:) = inf;
            D(i,:) = i;
        end
    else
        if metaltoucheswire(ix,iy,itheta,Nx,Ntheta,wirefunction)
            C(i,:) = inf;
            D(i,:) = i;
        else
            for j = 1:m
                C(i,j)    = 1;
                D(i,j)    = nextstate(i,j,Nx,Ny,Ntheta,Mx,My,Mtheta);
            end
        end
    end
end
[mu_,J_] = dpsp( D, C, Jh);

J  = zeros(Nx,Ny,Ntheta);

for i = 1:n
    [ix,iy,itheta]    = state2coord(i,Ny,Ntheta);
    J(ix,iy,itheta)   = J_(i);
    if flag == 0
        [jx,jy,jtheta]     = action2coord(mu_{i}(1),My,Mtheta);
        mu{ix}{iy}{itheta} = [jx-1,jy-(My-1)/2-1,jtheta-(Mtheta-1)/2-1];
    else
        for j = 1:length(mu_{i})
            [jx,jy,jtheta]       = action2coord(mu_{i}(j),My,Mtheta);
            mu{ix}{iy}{itheta}(j,1:3) = [jx-1,jy-(My-1)/2-1,jtheta-(Mtheta-1)/2-1];
        end
    end
end

end
