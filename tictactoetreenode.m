classdef tictactoetreenode < tictactoeboard 
    properties
        node_id uint16;
        parent_id (1,9) uint16 = zeros(1,9);
        node_val int8 = 0;
        child_id (1,9) uint16 = zeros(1,9);
        move_from_parent (1,9) uint8 = zeros(1,9);
        move_to_child (1,9) uint16 = zeros(1,9);
        moves_played int8;
        is_complete_node logical =false;
        all_child_complete logical =false;
%     end
%     
%     properties (Access = private)
        parent_nodes =tictactoetreenode.empty;
        child_nodes =tictactoetreenode.empty;        
    end
    
    methods
        function obj=tictactoetreenode(position)
            if nargin>0
                obj.node_id=obj.generateUniqueID();
                position(isnan(position))=2;
                obj.position=position;
                obj.moves_played=sum(sum(position~=2));
                if(obj.moves_played>4)
                    obj=obj.check_win;
                    if(obj.is_won)
                        obj.all_child_complete=true;
                        obj.is_complete_node=true;
                    end 
                end
            end
        end
        
        function child_val_array=get_all_child_val(obj)
            if nargin>0
                num_children=numel(obj.child_nodes);
                child_val_array=zeros(1,num_children);
                for i=1:num_children
%                     i
%                     obj.child_nodes.node_val
%                     obj.child_nodes.node_val(i)
%                     child_val_array(i)
                    child_val_array(i)=obj.child_nodes(i).node_val;
                end
            end
        end
        
%         function obj_array=update_complete_node(obj_array)
%             if nargin>0
%                 for i=1:numel(obj_array)
%                     obj=obj_array(i);
%                     
%                     
%                     if ~obj.is_won
%                         obj.is_complete_node=obj.moves_played+numel(obj.child_nodes)==9;
%                         
%                         if(obj.is_complete_node)
%                             
%                             if(~obj.all_child_complete)
%                                 obj=obj.update_all_child_complete();
%                                 child_val_array=get_all_child_val(obj);
%                                 
%                                 if(mod(obj.moves_played,2)==0)
%                                     obj.node_val=max(child_val_array);
%                                     
%                                 else
%                                     obj.node_val=min(child_val_array);
%                                     
%                                 end
%                             end
%                         end
%                     end
%                 end
%                 
%                 
%             end
%             
%         end
        
        function obj=update_all_child_complete(obj)
            obj.all_child_complete=true;
            for i=1:numel(obj.child_nodes)
                obj.all_child_complete=obj.all_child_complete||obj.child_nodes.all_child_complete(i);
                if(~obj.all_child_complete)
                    break;
                end
            end
        end
                    
        
        
        
        function node_of_position=findposition(parent_node,move_played)
            node_of_position =tictactoetreenode.empty;
            is_old_move=ismember(parent_node.move_to_child,move_played);
            if(any(is_old_move))
                node_of_position=parent_node.child_nodes(is_old_move);
            end
        end
        
        function obj=update_node_val(obj)
            switch(obj.who_won)
                case true
                    obj.node_val=127;
                    obj.all_child_complete=true;
                    obj.is_complete_node=true;
                case false
                    obj.node_val=-127;
                    obj.all_child_complete=true;
                    obj.is_complete_node=true;
                    
                otherwise
                    
                    
            end
        end
        
        function obj=update_node_complete(obj)
            for i=1:numel(obj)
                obj(i).is_complete_node=obj(i).is_won|(obj(i).moves_played+numel(obj(i).child_nodes)==9);
            end
        end
        
        
        function obj=addChild(obj,child_obj)
            if(isValidChild(obj,child_obj)&&~isChild(obj,child_obj))
                empty_child_slot=find(obj.child_id==0);
                obj.child_id(empty_child_slot(1))=child_obj.node_id;
                obj.move_to_child(empty_child_slot(1))=find(xor(obj.position==2,child_obj.position==2));
                obj.child_nodes=[obj.child_nodes child_obj];
            end
        end
        
        function obj=addParent(obj,parent_obj)
            if(isValidParent(obj,parent_obj)&&~isParent(obj,parent_obj))
                empty_parent_slot=find(obj.parent_id==0);
                obj.parent_id(empty_parent_slot(1))=parent_obj.node_id;
                obj.move_from_parent(empty_parent_slot(1))=find(xor(obj.position==2,parent_obj.position==2));
                obj.parent_nodes=[obj.parent_nodes parent_obj];
            end
        end
        
        
        function result=isChild(obj,child_obj)
            result=ismember(child_obj.node_id,obj.child_id);
        end
        
        function result=isParent(obj,parent_obj)
            result=ismember(parent_obj.node_id,obj.parent_id);
        end
        
        function result=isUniqueID(node_ID)
            result=false;
            load('tictactoeidlist.mat','id_list');
            if(~ismember(node_ID,id_list))
                result=true;
            end
        end
        
        function result=isValidLevel(moves_played)
            result=(moves_played<10) && (moves_played>-1);
        end
        
        function result=isValidParent(obj,parent_obj)
            p1=obj.position;
            p2=parent_obj.position;
            p1(isnan(p1))=2;
            p2(isnan(p2))=2;
            
            result=((obj.moves_played-parent_obj.moves_played)==1)&&(sum(sum(p1~=p2))==1);
        end
        
        function result=isValidChild(obj,child_obj)
            result=isValidParent(child_obj,obj);
        end
        
        
    end
    
    methods (Static)
        
        function next_node_id=generateUniqueID()
            load('tictactoeidlist.mat','id_list','next_id');
            next_node_id=next_id;
            id_list=[id_list;next_id];
            next_id=next_id+1;
            save('tictactoeidlist.mat','id_list','next_id','-append');
        end
    end
    
    
    
end
