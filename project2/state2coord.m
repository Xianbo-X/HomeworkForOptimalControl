function [ix,iy,itheta] = state2coord(i,Ny,Ntheta)
ix     = floor( (i-1)/(Ny*Ntheta))+1;
iy     = floor((i-1-(ix-1)*(Ny*Ntheta))/Ntheta)+1;
itheta = i-(ix-1)*(Ny*Ntheta)-(iy-1)*Ntheta;
end