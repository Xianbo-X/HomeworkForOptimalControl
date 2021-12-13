function [boolean] = metaltoucheswire(ix,iy,itheta,Nx,Ntheta,wirefunction)
spacingfingers = 4.1;
deltatheta  = pi/(Ntheta+1);
theta       = itheta*deltatheta-pi/2;
deltawire   = (Nx-1)/(length(wirefunction)-1);
xwire       = ix;
ywire       = wirefunction(round((xwire-1)/deltawire)+1);
if abs(ywire-iy)>spacingfingers
    boolean = 1;
else
    % four corners
    R  = [cos(theta) -sin(theta); sin(theta) cos(theta)];
    d  = spacingfingers/2;
    pu1 = [ix; iy] + R*[-d d]';
    pu2 = [ix; iy] + R*[d d]';
    pl1 = [ix; iy] + R*[-d -d]';
    pl2 = [ix; iy] + R*[d -d]';
    if pu2(1) < 1 || pu1(1) > Nx % if the full metal arm is outside of the environemnt possibly the wire is such that it does not touch
        cu = 1;
    else
        indleftlimu  = round(1+(max(min(pu1(1),Nx),1)-1)/deltawire);
        indrightlimu = round(1+(max(min(pu2(1),Nx),1)-1)/deltawire);
        indtestu     = indleftlimu:indrightlimu;
        for i = 1:length(indtestu)
            xwireu(i)   = 1+(indtestu(i)-1)*deltawire;
            ywireu(i)   = wirefunction(indtestu(i));
            ymetalu(i)   = pu1(2)+ (pu2(2)-pu1(2))/(pu2(1)-pu1(1))*(xwireu(i)-pu1(1));
            cu(i)       = ymetalu(i)-ywireu(i) > 0;
        end
    end
    
    if pl2(1) < 1 || pl1(1) > Nx
        cl = 1;
    else
        indleftliml  = round(1+(max(min(pl1(1),Nx),1)-1)/deltawire);
        indrightliml = round(1+(max(min(pl2(1),Nx),1)-1)/deltawire);
        indtestl     = indleftliml:indrightliml;
        for i = 1:length(indtestl)
            xwirel(i)   = 1+(indtestl(i)-1)*deltawire;
            ywirel(i)   = wirefunction(indtestl(i));
            ymetall(i)   = pl1(2)+ (pl2(2)-pl1(2))/(pl2(1)-pl1(1))*(xwirel(i)-pl1(1));
            cl(i)       = ymetall(i)-ywirel(i) < 0;
        end
    end
    
    if all(cu == 1) & all(cl == 1)
        boolean = 0;
    else
        boolean = 1;
    end
    
end

end