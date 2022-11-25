function dfs3_single_source(step,visited_times_ctrpoints,cur_cost,cur_node,cur_path,source,indDestination,ctrpoints,links,costupdown,MAXSTEP,arm_status)
    if step>=MAXSTEP
        return;
    end
    global best_cost
    global best_path
    global cut_tree_num
    if (cur_node==indDestination && all(cur_path{step}{2}==1))
        if (cur_cost<best_cost(source))
            % Search for minimal cost
            best_cost(source)=cur_cost; % Replace the minimal cost with the current cost.
            best_path{source}=cur_path; % Replace the best path with the current path.
        end
    end
    
    if cur_cost+EuclidenDistance(cur_node,indDestination,ctrpoints)>best_cost(source) % cut-tree
        cut_tree_num=cut_tree_num+1;
        if (mod(cut_tree_num,10000)==0)
            disp(cut_tree_num)
            disp(best_cost(source))
        end
        return
    end
    if (all(cur_path{step}{2}==1)) % when all traverse,always first try direct road
        visited_times_ctrpoints(indDestination)=0;
    end
    [~,sorted_index]=sort(visited_times_ctrpoints); % sort by the usage times
    for next_point_index=1:1:size(sorted_index,1)
        next_point=sorted_index(next_point_index);
        if (next_point==cur_node)
            continue % skip the current node itself
        end
        cur_link1=[cur_node,next_point]; % undirected graph
        cur_link2=[next_point,cur_node]; % undirected graph
        link_index=-1; % -1 means not in the links
        if ismember(cur_link1,links',"rows") % assumption, there is no duplicated links
            [~,link_index]=ismember(cur_link1,links',"rows"); % query the index of link
        end
        if ismember(cur_link2,links',"rows")
            [~,link_index]=ismember(cur_link2,links',"rows");
        end
         if (link_index~=-1) % We can lower or not lower arm here
            for status=1:-1:0
                % set arm status to next_possible_status(status_index)
                % move to next_point with status_index
                % store current stage
                link_status=cur_path{step}{2}; % get current status
                if status==1
                    link_status(link_index)=1; % Set next status
                end
                extra_cost=0;
                if status~=arm_status
                    extra_cost=costupdown;
                end
                visited_times_ctrpoints(next_point)=visited_times_ctrpoints(next_point)+1;
                extra_cost=extra_cost+norm(ctrpoints(:,cur_node)-ctrpoints(:,next_point),2); % Two norm as distance.
                cur_path{step+1} = {[next_point],link_status};
                dfs3_single_source(step+1,visited_times_ctrpoints,cur_cost+extra_cost,next_point,cur_path,source,indDestination,ctrpoints,links,costupdown,MAXSTEP,status)
                cur_path(end)=[]; % delete last cell.                
                visited_times_ctrpoints(next_point)=visited_times_ctrpoints(next_point)-1;
            end
        else
            status=0;
            extra_cost=0;
            link_status=cur_path{step}{2}; % get current status
            if status~=arm_status
                extra_cost=costupdown;
            end
            visited_times_ctrpoints(next_point)=visited_times_ctrpoints(next_point)+1;
            extra_cost=extra_cost+norm(ctrpoints(:,cur_node)-ctrpoints(:,next_point),2); % Two norm as distance.
            cur_path{step+1} = {[cur_node],link_status};
            dfs3_single_source(step+1,visited_times_ctrpoints,cur_cost+extra_cost,next_point,cur_path,source,indDestination,ctrpoints,links,costupdown,MAXSTEP,status)
            cur_path(end)=[]; % delete last cell.                
            visited_times_ctrpoints(next_point)=visited_times_ctrpoints(next_point)-1;
        end        
    end
end
