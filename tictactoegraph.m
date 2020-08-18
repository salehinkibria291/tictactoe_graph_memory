classdef tictactoegraph < handle
    properties
        game_graph;
    end
    
    methods
        function obj=tictactoegraph(position)
            
            position(isnan(position))=2;
            root_node=tictactoetreenode(position);
            obj.game_graph=digraph(0,{int2str(root_node.node_id)});
            obj.game_graph.Nodes.Node_obj(1)=root_node;
        end
        
        function [node_of_position]=tttfindposition(obj,parent_node,move_played)
            node_of_position=findposition(parent_node,move_played);
            if(isempty(node_of_position))
                disp('********New move********')
                new_pos=parent_node.position;
                
                if(mod(parent_node.moves_played,2))
                    new_pos(move_played)=0;
                else
                    new_pos(move_played)=1;
                end
                    
                node_of_position=obj.game_graph.Nodes.Node_obj.findobj('position',new_pos);
                if(~isempty(node_of_position))
                    parent_node=parent_node.addChild(node_of_position);
                    node_of_position=node_of_position.addParent(parent_node);
                    obj.game_graph=obj.game_graph.addedge({int2str(parent_node.node_id)},{int2str(node_of_position.node_id)},int8(move_played));
                end
            end
                
        end
        
        function obj=tttminmax(obj,end_nodes)
            for j=1:numel(end_nodes)
                end_node=end_nodes(j);
            switch(end_node.who_won)
                case true
                    end_node.node_val=127;
                case false
                    end_node.node_val=-127;
                otherwise
                    end_node.node_val=0;
            end
            
            while true
            
                end_node=[end_node.parent_nodes];
                
                num_nodes=numel(end_node);
                
                for i=1:num_nodes
                    
                    child_vals=[end_node(i).child_nodes.node_val];
                    who_move=mod(end_node(i).moves_played,2);
                
                switch(who_move)
                    case 0 %x move
                        end_node(i).node_val=max(child_vals);
                    case 1 %o move
                        end_node(i).node_val=min(child_vals);
                end
                
                end
                
                
                
                %end_node.update_complete_node
                if(~num_nodes)
                    break;
                end
                
            end
            end    
        end
        
        function obj=update_graph_val(obj)
            
            for current_level=9:-1:1
                curr_level_nodes=obj.game_graph.Nodes.Node_obj.findobj('moves_played',current_level);
                curr_level_nodes=curr_level_nodes.update_complete_node;
            end
        end
        
        function [obj,new_node]=tttaddnode(obj,parent_node,position)
            position(isnan(position))=2;
            move_played=find((parent_node.position~=position));
            new_node=obj.tttfindposition(parent_node,move_played);
            if(isempty(new_node))
                
                
                new_node=tictactoetreenode(position);
                warning('off','MATLAB:table:RowsAddedExistingVars');
                obj.game_graph=obj.game_graph.addnode({int2str(new_node.node_id)});
                warning('on','MATLAB:table:RowsAddedExistingVars');
                obj.game_graph.Nodes.Node_obj(end)=new_node;
                parent_node=parent_node.addChild(new_node);
                new_node=new_node.addParent(parent_node);
                is_x_move=mod(parent_node.moves_played,2)==0;
                is_child_higher=parent_node.node_val<new_node.node_val;
                if(~xor(is_x_move,is_child_higher))
                    parent_node.node_val=new_node.node_val;
                end
                obj.game_graph=obj.game_graph.addedge({int2str(parent_node.node_id)},{int2str(new_node.node_id)},int8(move_played));
                
            end
            
        end
        
       
        
        
        
        
        function [G,child_node]=update_graph(G,parent_node,board_obj)
            [G,child_node]=G.tttaddnode(parent_node,board_obj.position);
            save('tttgraph.mat','G');
        
        end
        
        
        
    end
end