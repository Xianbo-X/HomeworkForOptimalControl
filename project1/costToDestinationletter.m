function [costM,path]=costToDestinationletter(ctrpoints,links,costupdown,indDestination)
%%
%     We can calculate the reverse path departured from indDestination
%     instead of arrived at inddestination to make the program easier to
%     get all cost form arbitrary point.
%% params:
%  indDestination: index of ctrpoints.
%  ctrpoints: shape(2,m) , m ctrpoints. each column is a ctrpoint.
%%
    costM=ones(size(ctrpoins,2),1) % costM(i) minimal cost from i to indDesination
    path={};
    MAXSTEP=size(links,2)*2;
    arm_status=0; % 0 means up,1 means down
    dfs(indDestination,ctrpoints,links,costupdown,path,MAXSTEP,arm_status,costM)

end