function [i_1] = nextstate(i,j,Nx,Ny,Ntheta,Mx,My,Mtheta)
[ix,iy,itheta] = state2coord(i,Ny,Ntheta);
[jx,jy,jtheta] = action2coord(j,My,Mtheta);
ix_1     = min(ix+(jx-1),Nx);
iy_1     = min(max(iy+jy-(My-1)/2-1,1),Ny);
itheta_1 = min(max(itheta+jtheta-(Mtheta-1)/2-1,1),Ntheta);
i_1 = coord2state(ix_1,iy_1,itheta_1,Ny,Ntheta);
end