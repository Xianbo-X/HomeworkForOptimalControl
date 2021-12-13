function [costM,path]=costToDestinationletter(ctrpoints,links,costupdown,indDestination)
%%
%     We can calculate the reverse path departured from indDestination
%     instead of arrived at inddestination to make the program easier to
%     get all cost form arbitrary point.
%% params:
%  indDestination: index of ctrpoints.
%  ctrpoints: shape(2,m) , m ctrpoints. each column is a ctrpoint.
%%
    global costM;
    costM=ones(size(ctrpoints,2),1).*10000; % costM(i) minimal cost from i to indDesination
    % reference with last result
    global path;
    path={};
    cur_path={};
%     MAXSTEP=size(ctrpoints,2)*2;
%     MAXSTEP=size(ctrpoints,2)+6;
    MAXSTEP=size(links,2)*2+1;
    arm_status=1; % 0 means up,1 means down
    
    cur_path{1}={[indDestination],zeros(1,size(links,2))};
    visited_times_ctrpoints=zeros(size(ctrpoints,2),1); % store the visited times of each nodes
    visited_times_ctrpoints(indDestination)=visited_times_ctrpoints(indDestination)+1;
%     visited_times_ctrpoints(:,1)=[1:1:size(ctrpoints,2)];
    global best_cost;
    global best_path;
    best_cost=ones(size(ctrpoints,2),1).*500; % costM(i) minimal cost from i to indDesination
    best_path={}
%     dfs(1,cur_path{1}{2},0,indDestination,cur_path,indDestination,ctrpoints,links,costupdown,MAXSTEP,arm_status,path,costM)   
    dfs2(1,visited_times_ctrpoints,cur_path{1}{2},0,indDestination,cur_path,indDestination,ctrpoints,links,costupdown,MAXSTEP,arm_status)
%     global cut_tree_num
    
%     for source=1:1:size(ctrpoints,2)
%         cut_tree_num=0
%         cur_path={}
%         cur_path{1}={[source],zeros(1,size(links,2))};
%         visited_times_ctrpoints=zeros(size(ctrpoints,2),1); % store the visited times of each nodes
%         visited_times_ctrpoints(source)=visited_times_ctrpoints(source)+1;
%         dfs3_single_source(1,visited_times_ctrpoints,0,source,cur_path,source,indDestination,ctrpoints,links,costupdown,MAXSTEP,arm_status)
%     end
end
