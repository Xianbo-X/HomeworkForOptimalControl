function [j] = coord2action(jx,jy,jtheta,My,Mtheta)
j = (jx-1)*My*Mtheta + (jy-1)*Mtheta + jtheta;
end