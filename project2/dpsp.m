function [u_,J_] = dpsp( M, C, Jh)

[n,~] = size(M);
J = Jh;

J_ = zeros(n,1);
while(1)
    for i = 1:n
        if any(C(i,:) ~=inf)
            [J_(i)]  = min( C(i,:)' + J(M(i,:)) );
        else
            J_(i) = inf;
        end
    end
    if J == J_;
        for i = 1:n
            if any(C(i,:) ~=inf)
                u_{i}       = find(J_(i) == C(i,:)' + J(M(i,:)) );
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