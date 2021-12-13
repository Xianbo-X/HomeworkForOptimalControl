function [jx,jy,jtheta] = action2coord(j,My,Mtheta)
jx     = floor( (j-1)/(My*Mtheta))+1;
jy     = floor((j-1-(jx-1)*(My*Mtheta))/Mtheta)+1;
jtheta = j-(jx-1)*(My*Mtheta)-(jy-1)*Mtheta;
end