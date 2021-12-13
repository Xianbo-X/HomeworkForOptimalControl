function tmetal = plotenvironment(Nx,Ny,Ntheta,wirefunction)
deltawire  = (Nx-1)/(length(wirefunction)-1);
spacingfingers = 4.1;
d  = spacingfingers/2;
plot( [0 0],[0 Ny+1],"LineWidth",2,"Color",[0 0 0])
hold on
plot( [Nx+1 Nx+1],[0 Ny+1],"LineWidth",2,"Color",[0 0 0])
for ix = 1:Nx
    plot( [ix ix],[0 Ny+1],"LineWidth",1,"Color",[0 0 0])
end
for iy = 1:Ny
    plot([0 Nx+1],[iy iy],"LineWidth",1,"Color",[0 0 0])
end
plot([0 Nx+1],[0 0],"LineWidth",2,"Color",[0 0 0])
plot([0 Nx+1],[Ny+1 Ny+1],"LineWidth",2,"Color",[0 0 0])
axis equal
axis([0 Nx+1 0 Ny+1])
x_ = 1:deltawire:Nx; plot(x_,wirefunction,"LineWidth",2,"Color",[1 0 0])
tfinger1 = line([-d d],[d d],"LineWidth",2,"Color",[0 0 1]);
tfinger2 = line([-d d],[-d -d],"LineWidth",2,"Color",[0 0 1]);
tcircle  = plot(0,0,'o',"LineWidth",2,"Color",[0 0 1]);
tmetal = hgtransform('Parent',gca);
set(tfinger1,'parent',tmetal);
set(tfinger2,'parent',tmetal);
set(tcircle,'parent',tmetal);
xlabel('x')
ylabel('y')
plotmetal([5 15 15],tmetal,Ntheta);
end