function dist=EuclidenDistance(point1,point2,pointList)
    dist=norm(pointList(:,point1)-pointList(:,point2),2);
end