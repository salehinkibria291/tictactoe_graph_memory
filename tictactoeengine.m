classdef tictactoeengine
    properties
        p_x_win;
        p_o_win;
        p_draw;
        game_vector;
        moves_remaining;
        game_seq;
        current_node;
        
    end
    
    methods
        function obj=tictactoeengine(current_node)
            obj.current_node=current_node;
            board=current_node.position;
            obj.moves_remaining=sum(sum(isnan(board)));
            obj.game_seq=position2game_seq(obj,board);
            [obj.p_x_win,obj.p_o_win,obj.p_draw,obj.game_vector]=find_games(obj);
            
            
        end
        
        function next_move=generateMove(obj,mode)
            switch(mode)
                case 6
                    %disp('graph')
                    next_move=obj.tictactoe_graph_ai;
                case 5
                    %disp('ai');
                    next_move=obj.tictactoeai;
                case 4
                    %disp('brute force');
                    next_move=obj.brute_force;
                case 3
                    %disp('random move');
                    next_move=obj.random_move;
                case 2
                    %disp('x best');
                    next_move=obj.best_x_play;
                case 1
                    %disp('o best');
                    next_move=obj.best_o_play;
                case 0
                    %disp('human input');
                    next_move=obj.human_move;
                    
            end
        end
        
        function next_move=human_move(obj)
            legal_moves=setxor(obj.game_seq,1:9);
            valid_input=false;
            while(~valid_input)
                disp(legal_moves);
                next_move=input('Pick next move: ');
                valid_input=ismember(next_move,legal_moves);
            end
        end
        
        
        function next_move=tictactoe_graph_ai(obj)
            legal_moves=setxor(obj.game_seq,1:9);
            
            num_child=numel(obj.current_node.child_nodes);
            missing_moves=setxor(obj.current_node.move_to_child(1:num_child),legal_moves);
            
            if(num_child)
                
                next_level_val=[obj.current_node.child_nodes.node_val];
                
                
                
                
                if(mod(numel(obj.game_seq),2))
                    [best_val,next_move_index]=min(next_level_val);
                    next_move=obj.current_node.move_to_child(next_move_index);
                    if((best_val>0)&&(numel(missing_moves)~=0))
                        next_move=missing_moves(randi(numel(missing_moves),1));
                        disp('new move');
                        
                    end
                    
                    
                else
                    [best_val,next_move_index]=max(next_level_val);
                    next_move=obj.current_node.move_to_child(next_move_index);
                    if((best_val<0)&&(numel(missing_moves)~=0))
                        next_move=missing_moves(randi(numel(missing_moves),1));
                        disp('new move');
                        
                    end
                    
                end
            else
                next_move=missing_moves(randi(numel(missing_moves),1));
            end
            
        end
        
        function next_move=random_move(obj)
            legal_moves=setxor(obj.game_seq,1:9);
            next_move=legal_moves(randi(numel(legal_moves),1));
        end
        
        
        function next_move=brute_force(obj)
            [next_move_list,p_x_win_list,p_o_win_list,~]=obj.find_p_list;
            p_diff=p_x_win_list-p_o_win_list;
            [~,p_index]=sort(p_diff);
            next_move_list=next_move_list(p_index);
            best_x_move=next_move_list(end);
            best_o_move=next_move_list(1);
            if(mod(numel(obj.game_seq),2))
                next_move=best_x_move;
            else
                next_move=best_o_move;
            end
        end
        
        function next_move=tictactoeai(obj)
            [next_move_list,p_eval_list]=obj.ai_find_p_list;
            [~,p_index]=sort(p_eval_list);
            next_move_list=next_move_list(p_index);
            best_x_move=next_move_list(end);
            best_o_move=next_move_list(1);
            if(~mod(numel(obj.game_seq),2))
                next_move=best_x_move;
            else
                next_move=best_o_move;
            end
            
        end
        
        function next_move=best_x_play(obj)
            [next_move_list,~,p_o_win_list,~]=obj.find_p_list;
            [~,p_index]=sort(p_o_win_list);
            next_move_list=next_move_list(p_index);
            next_move=next_move_list(1);
        end
        
        function next_move=best_o_play(obj)
            [next_move_list,p_x_win_list,~,~]=obj.find_p_list;
            [~,p_index]=sort(p_x_win_list);
            next_move_list=next_move_list(p_index);
            next_move=next_move_list(1);
        end
        
        function [next_move_list,p_eval_list]=ai_find_p_list(obj)
            next_move_list=find_legal_moves(obj);
            num_next_moves=numel(next_move_list);
            game_seq_original=obj.game_seq;
            p_eval_list=zeros(num_next_moves,1);
            for i=1:num_next_moves
                obj.game_seq=[obj.game_seq next_move_list(i)];
                [p_eval_list(i),obj]=ai_find_games(obj);
                obj.game_seq=game_seq_original;
            end
            
            
        end
        
        
        function [next_move_list,p_x_win_list,p_o_win_list,p_draw_list]=find_p_list(obj)
            next_move_list=find_legal_moves(obj);
            num_next_moves=numel(next_move_list);
            game_seq_original=obj.game_seq;
            p_x_win_list=zeros(num_next_moves,1);
            p_o_win_list=zeros(num_next_moves,1);
            p_draw_list=zeros(num_next_moves,1);
            for i=1:num_next_moves
                obj.game_seq=[obj.game_seq next_move_list(i)];
                [p_x_win_list(i),p_o_win_list(i),p_draw_list(i),~]=find_games(obj);
                obj.game_seq=game_seq_original;
            end
            
            
        end
        
        function next_move_list=find_legal_moves(obj)
            next_move_list=setxor(obj.game_seq,1:9);
        end
        
        function train_ai(obj,who_won)
            %load('tictactoedatabase.mat','game_matrix');
            load('tictactoeaidatabase.mat','ai_eval_score');
            w=0.9;
            if(who_won)
                ai_eval_score(obj.game_vector)=w+(1-w)*ai_eval_score(obj.game_vector);
            else
                ai_eval_score(obj.game_vector)=(1-w)*ai_eval_score(obj.game_vector);
            end
            save('tictactoeaidatabase.mat','ai_eval_score');
        end
        
        
        
        function [p_eval,obj]=ai_find_games(obj)
            load('tictactoedatabase.mat','game_matrix');
            load('tictactoeaidatabase.mat','ai_eval_score');
            num_moves_played=numel(obj.game_seq);
            if num_moves_played<5
                for i=1:num_moves_played
                    game_matrix=game_matrix(:,1:num_moves_played);
                    game_matrix(game_matrix==obj.game_seq(i))=0;
                end
                %game_vector=true(size(ai_eval_score));
                
            else
                legal_moves=setxor(obj.game_seq,1:9);
                for i=1:(9-num_moves_played)
                    game_matrix=game_matrix(:,num_moves_played+1:end);
                    game_matrix(game_matrix==legal_moves(i))=0;
                end
            end
            game_vector=sum(game_matrix~=0,2)==0;
            obj.game_vector=game_vector;
            p_eval=mean(ai_eval_score(game_vector));
            
        end
        
        
        
        function [p_x_win,p_o_win,p_draw,game_vector]=find_games(obj)
            load('tictactoedatabase.mat','game_matrix','eval_score');
            if numel(obj.game_seq)==0
                
                game_vector=true(size(eval_score));
                
            else
                game_vector=game_matrix(:,1)==obj.game_seq(1);
                for i=2:numel(obj.game_seq)
                    game_vector=game_vector&(game_matrix(:,i)==obj.game_seq(i));
                    
                    
                end
            end
            p_x_win=mean(eval_score(game_vector)==true);
            p_o_win=mean(eval_score(game_vector)==false);
            p_draw=1-p_o_win-p_x_win;
            
            
        end
        
        
        function game_seq=position2game_seq(obj,board)
            
            
            x_locations=find(board==true)';
            o_locations=find(board==false)';
            is_x_move=numel(x_locations)==numel(o_locations);
            
            if ~is_x_move
                o_locations=[o_locations nan];
            end
            
            game_seq=[x_locations;o_locations];
            game_seq=game_seq(:)';
            
            if ~is_x_move
                game_seq=game_seq(1:end-1);
            end
        end
        
        function position=game_seq2position(obj)
            x_moves=obj.game_seq(1:2:end);
            o_moves=obj.game_seq(2:2:end);
            position=2*ones(3,3);
            position(x_moves)=1;
            position(o_moves)=0;
        end
        
        
        
        
        
        
    end
    
end