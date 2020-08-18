classdef tictactoeboard < handle
    properties
        position;
        is_won logical = false;
        who_won = nan;
    end
    
    methods
        function obj=tictactoeboard(position)
            if nargin>0
                obj.position=position;
                obj.is_won=false;
                obj.who_won=nan;
            end
        end
        
        function obj=reset(obj)
            if nargin>0
                obj.position=nan(3,3);
                obj.is_won=false;
                obj.who_won=nan;
            end
        end
                
        function result=isequal(obj,obj_array)
            array_size=numel(obj_array);
            result=false(1,array_size);
            for i=1:array_size
                obj_element=obj_array(i);
                result(i)=isequaln(obj_element.position,obj.position);
            end
        end
        
        function obj=clearboard(obj)
            obj.position=nan(3,3);
            obj.is_won=false;
            obj.who_won=nan;
        end
        
        
        function obj=add_x(obj,x_index,y_index)
            if nargin>0
                obj.position(x_index,y_index)=true;
                %disp('x')
            end
        end
        
        function obj=add_o(obj,x_index,y_index)
            if nargin>0
                obj.position(x_index,y_index)=false;
                %disp('o')
            end
        end
        
        
        
        function obj=play_game(obj,game_seq)
            
            x_index=mod(game_seq-1,3)+1;
            y_index=ceil(game_seq/3);
            %obj.show_board
            for move_no=1:numel(game_seq)
                if (mod(move_no,2)==0)
                    obj=obj.add_o(x_index(move_no),y_index(move_no));
                    obj=obj.check_win;
                    if(obj.is_won)
                        %disp('o wins');
                        obj.who_won=false;
                        obj.is_won=true;
                        return;
                    end
                else
                    obj=obj.add_x(x_index(move_no),y_index(move_no));
                    obj=obj.check_win;
                    if(obj.is_won)
                        %disp('x wins');
                        obj.who_won=true;
                        obj.is_won=true;
                        return;
                    end
                end
                %obj.show_board
            end
            
            
            
        end
        
        function obj=play_move(obj,move_played)
            if(~obj.is_won)
                is_x_move=mod(sum(sum(isnan(obj.position))),2);
                
                x_index=mod(move_played-1,3)+1;
                y_index=ceil(double(move_played)/3);
                if (is_x_move)
                    obj=obj.add_x(x_index,y_index);
                else
                    obj=obj.add_o(x_index,y_index);
                end
                obj=obj.check_win;
                if(obj.is_won)
                    obj.is_won=true;
                    obj.who_won=is_x_move==1;
                    
                end
                obj.show_board
                
                
            end
            
        end
        
        function obj=undo_move(obj,move_played)
            obj.is_won=false;
            obj.who_won=nan;
            x_index=mod(move_played-1,3)+1;
            y_index=ceil(double(move_played)/3);
            obj.position(x_index,y_index)=nan;
            
        end

        
        function obj=check_win(obj)
            pos=obj.position;
            pos(pos==2)=nan;
            %check rows
            if(pos(1)==pos(2)&&pos(2)==pos(3)) 
                obj.is_won=true;
                obj.who_won=pos(1);
                return;
            end
            if(pos(4)==pos(5)&&pos(5)==pos(6)) 
                obj.is_won=true; 
                obj.who_won=pos(4);
                return;
            end
            if(pos(7)==pos(8)&&pos(8)==pos(9)) 
                obj.is_won=true; 
                obj.who_won=pos(7);
                return;
            end
            %check columns
            if(pos(1)==pos(4)&&pos(4)==pos(7)) 
                obj.is_won=true;
                obj.who_won=pos(1);
                return;
            end
            if(pos(2)==pos(5)&&pos(5)==pos(8)) 
                obj.is_won=true; 
                obj.who_won=pos(2);
                return;
            end
            if(pos(3)==pos(6)&&pos(6)==pos(9)) 
                obj.is_won=true;
                obj.who_won=pos(3);
                return;
            end
            
            %check diagonals
            if(pos(1)==pos(5)&&pos(5)==pos(9)) 
                obj.is_won=true; 
                obj.who_won=pos(1);
                return;
            end
            if(pos(3)==pos(5)&&pos(5)==pos(7)) 
                obj.is_won=true; 
                obj.who_won=pos(3);
                return;
            end
            
            
        end
        
        
        
        
        function show_board(obj)
            posi=obj.position;
            posi=posi(:);
            pos=1:9;
            pos=int2str(pos(:));
            posi(isnan(posi))=pos(isnan(posi));
            posi(posi==true)='x';
            posi(posi==false)='o';
            %clc;
            disp('');
            disp([posi(1) ' | ' posi(2) ' | ' posi(3)]);
            disp('---------');
            disp([posi(4) ' | ' posi(5) ' | ' posi(6)]);
            disp('---------');
            disp([posi(7) ' | ' posi(8) ' | ' posi(9)]);
            disp('');
            
        end
    end
    
    
    
    
end
