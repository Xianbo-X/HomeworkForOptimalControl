function [mu,J] = buzzwiredpstoch(Nx,Ny,Ntheta,Mx,My,Mtheta,wirefunction,CW,p,flag)
if nargin == 9
    flag = 0;
end

np = length(p);
pcases = [-1 1;
    0 1;
    1 1;
    -1 0;
    0 0;
    1 0;
    -1 -1;
    0 -1;
    1 -1];
n = Nx*Ny*Ntheta;
m = Mx*My*Mtheta;
D  = zeros(n+1,m,np);
C  = zeros(n+1,m);
Jh      = inf*ones(n+1,1);
Jh(n+1) = 0;

for i = 1:n
    [ix,iy,itheta] = state2coord(i,Ny,Ntheta);
    % terminal cost
    if ix == Nx
        if ~metaltoucheswire(ix,iy,itheta,Nx,Ntheta,wirefunction)
            Jh(i) = 0;
            C(i,:) = 0;
            D(i,:,:) = n+1;
        else
            Jh(i) = inf;
            C(i,:) = inf;
            D(i,:,:) = n+1;
        end
    else
        if metaltoucheswire(ix,iy,itheta,Nx,Ntheta,wirefunction)
            C(i,:)   = CW;
            D(i,:,:) = n+1;
        else
            for j = 1:m
                C(i,j)    = 1;
                for ell = 1:np
                    [ix,iy,itheta] = state2coord(i,Ny,Ntheta);
                    [jx,jy,jtheta] = action2coord(j,My,Mtheta);
                    ix_1       = min(max(ix+(jx-1)+pcases(ell,1),1),Nx);
                    iy_1       = min(max(iy+jy-(My-1)/2-1+pcases(ell,2),1),Ny);
                    itheta_1   = min(max(itheta+jtheta-(Mtheta-1)/2-1,1),Ntheta);
                    D(i,j,ell) = coord2state(ix_1,iy_1,itheta_1,Ny,Ntheta);
                end
            end
        end
    end
end
D(n+1,:) = n+1;
C(n+1,:) = 0;

[mu_,J_] = dpspstoch( D, C, p, Jh);

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