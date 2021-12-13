function dfs(step,visited_link,cur_cost,cur_node,cur_path,indDestination,ctrpoints,links,costupdown,MAXSTEP,arm_status,best_path,best_cost)
% visited_link, indDestination can be deleted
    if step>=MAXSTEP
        return; % cut tree, restricted the maximal depth
    end
    % End condition
    if (all(cur_path{step}{2}==1))
        % all links are drawed
        if (cur_cost<best_cost(cur_node))
            % Search for minimal cost
            best_cost(cur_node)=cur_cost; % Replace the minimal cost with the current cost.
            best_path{cur_node}=cur_path; % Replace the best path with the current path.
        end 
        return
    end
    
    for next_point=1:1:size(ctrpoints,1) % iter all possible ways
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
            for status=0:1
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
                
                extra_cost=extra_cost+norm(ctrpoints(:,cur_node)-ctrpoints(:,next_point),2); % Two norm as distance.
                cur_path{step+1} = {[cur_node],link_status};
                dfs(step+1,visited_link,cur_cost+extra_cost,next_point,cur_path,indDestination,ctrpoints,links,costupdown,MAXSTEP,status,best_path,best_cost)
                cur_path(end)=[]; % delete last cell.                
            end
        else
            status=0;
            extra_cost=0;
            link_status=cur_path{step}{2}; % get current status
            if status~=arm_status
                extra_cost=costupdown;
            end
            extra_cost=extra_cost+norm(ctrpoints(:,cur_node)-ctrpoints(:,next_point),2); % Two norm as distance.
            cur_path{step+1} = {[cur_node],link_status};
            dfs(step+1,visited_link,cur_cost+extra_cost,next_point,cur_path,indDestination,ctrpoints,links,costupdown,MAXSTEP,status,best_path,best_cost)
            cur_path(end)=[]; % delete last cell.                
        end         
    end
end