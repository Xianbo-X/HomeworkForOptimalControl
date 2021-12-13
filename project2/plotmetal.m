function plotmetal(pmetal,tmetal,Ntheta)
itheta     = pmetal(3);
deltatheta = pi/(Ntheta+1);
theta      = itheta*deltatheta-pi/2;
R          = [cos(theta) -sin(theta) 0;sin(theta) cos(theta) 0; 0 0 1];
P          = [pmetal(1) pmetal(2) 0]';
Tmetal     = [ R  P; zeros(1,3) 1];
set(tmetal,'Matrix',Tmetal)
end