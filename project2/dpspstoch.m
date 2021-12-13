function [u_,J_] = dpspstoch(M, C, p, Jh)

[n,m,~]  = size(M);
np     = length(p);
J      = Jh;
J_     = zeros(n,1);

while(1)
    for i = 1:n
        if any(C(i,:) ~=inf)
            caux = zeros(1,m);
            for j=1:m
                caux(j) = 0;
                for l=1:np
                    caux(j) = caux(j) + p(l)*(C(i,j) + J(M(i,j,l)));
                end
            end
            [J_(i)] = min( caux );
        else
            J_(i) = inf;
        end
    end
    if J == J_;
        for i = 1:n
            if any(C(i,:) ~=inf)
                caux = zeros(1,m);
                for j=1:m
                    caux(j) = 0;
                    for l=1:np
                        caux(j) = caux(j) + p(l)*(C(i,j) + J(M(i,j,l)));
                    end
                end
                u_{i}       = find(J_(i) == caux );
            else
                u_{i} = 1;
            end
        end
        break
    else
        J = J_;
    end
end
end
