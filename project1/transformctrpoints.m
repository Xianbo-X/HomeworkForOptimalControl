function [ctrpointsglobalframe,doublemessage] = transformctrpoints(message_,Allcontrolpoints,orderedletters,letters,Ibox,spacing)

% remove spaces
ell = 1;
auxvec = 1:length(letters);
for i = 1:length(message_)
    if message_(i) == ' '
        specialspacing(ell-1) = 1;
    else
        message(ell) = message_(i);
        d = double(message(ell));
        if d <= 57
            doublemessage(ell) = d-48 + 26 + 1;
        else
            doublemessage(ell) = d-65+1;
        end
        specialspacing(ell) = 0;
        indvector(ell) = auxvec(message(ell) == letters);
        ell = ell+1;
    end
end

%
for j = 1:length(message)
    i = orderedletters(indvector(j));
    Boundbox(:,j) = Ibox(:,i);
end


% compute dimensions of final image: sum of witdhs of bounding boxes + spacing
currentcollum = 0;
for j = 1:length(message)
    if specialspacing(j) == 0
        spacing_ = spacing;
    else
        spacing_ = 3*spacing;
    end
    ctrpoints = Allcontrolpoints{doublemessage(j)};
    for n = 1:size(ctrpoints,2)
        ctrpointsglobalframe{j}(1,n) = currentcollum + ctrpoints(1,n);
        ctrpointsglobalframe{j}(2,n) = ctrpoints(2,n);
    end
    currentcollum = currentcollum+Boundbox(3,j)+spacing_;
end
end