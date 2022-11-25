function dfs2(step,visited_times_ctrpoints,visited_link,cur_cost,cur_node,cur_path,indDestination,ctrpoints,links,costupdown,MAXSTEP,arm_status)
% visited_link, indDestination can be deleted
% visited_times_ctrpoints % use this to generate the sequence of next points
    if step>=MAXSTEP
        return; % cut tree, restricted the maximal depth
    end
    global best_cost
    global best_path
    global cut_tree_num
    % End condition
    if (all(cur_path{step}{2}==1))
        % all links are drawed
        if (arm_status==0)
            cur_cost=cur_cost+costupdown;
        end
        if (cur_cost<best_cost(cur_node))
            % Search for minimal cost
            best_cost(cur_node)=cur_cost; % Replace the minimal cost with the current cost.
            best_path{cur_node}=cur_path; % Replace the best path with the current path.
        end 
%         return % We shouldn't return here since we need to find minimal
%         cost of other poins.
    end
    
    if cur_cost>max(best_cost,[],"all") % cut-tree
        cut_tree_num=cut_tree_num+1;
        if cut_tree_num>100000
            return
        end
        if (mod(cut_tree_num,10000)==0)
            disp(cut_tree_num)
            disp(best_cost)
        end
        return
    end
    
%     for next_point=1:1:size(ctrpoints,2) % iter all possible ways
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
                dfs2(step+1,visited_times_ctrpoints,visited_link,cur_cost+extra_cost,next_point,cur_path,indDestination,ctrpoints,links,costupdown,MAXSTEP,status)
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
            cur_path{step+1} = {[next_point],link_status};
            dfs2(step+1,visited_times_ctrpoints,visited_link,cur_cost+extra_cost,next_point,cur_path,indDestination,ctrpoints,links,costupdown,MAXSTEP,status)
            cur_path(end)=[]; % delete last cell.                
            visited_times_ctrpoints(next_point)=visited_times_ctrpoints(next_point)-1;
        end         
    end
end