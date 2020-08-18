clearvars;
%idlist_generator();

load('tttgraph.mat','G');

board=tictactoeboard(nan(3,3));



root_node=G.game_graph.Nodes.Node_obj(1);

mc_rep=1;
%ai_names={'1.o_best' '2.x_best' '3.random' '4.brute_force 5.ai 6.graph'};
player1=0;
player2=0;
score_x=0;
score_o=0;
score_draw=0;
hist_score_x=nan(mc_rep,1);
hist_score_o=nan(mc_rep,1);
hist_score_draw=nan(mc_rep,1);
is_human=~(player1&&player2);
tic
for repcount=1:mc_rep
    parent_node=root_node;
    board=board.reset;
    
    for i=1:9
        a=tictactoeengine(parent_node);
        if(mod(i,2))
            next_move=generateMove(a,player1);
        else
            next_move=generateMove(a,player2);
        end
        a.game_seq=[a.game_seq next_move];
        %board=play_game(board,a.game_seq);
        
        board=play_move(board,next_move);
        [G,parent_node]=G.update_graph(parent_node,board);
        if(is_human)
            show_board(board);
        end
        
         if(board.is_won)
             %a.train_ai(board.who_won);
             break; 
         end
        
    end
    %disp(repcount)
    
        
    switch(board.who_won)
        case true
            score_x=score_x+1;
        case false
            score_o=score_o+1;
        otherwise
            score_draw=score_draw+1;
            
    end
    hist_score_draw(repcount)=score_draw;
    hist_score_o(repcount)=score_o;
    hist_score_x(repcount)=score_x;
    board=board.clearboard;
    if(~mod(repcount,100)&&~is_human)
        figure(1);
        subplot(2,1,1);
        plot([hist_score_x hist_score_o hist_score_draw]);
        legend({'x','o','draw'},'Location','northwest');
        subplot(2,1,2);
        load('tictactoeaidatabase.mat');
        plot(ai_eval_score);
    end
    plot_handle=plot(G.game_graph,'Layout','layered');
    drawnow;
        
end
toc
all_nodes=G.game_graph.Nodes.Node_obj;
highlight(plot_handle,[all_nodes.node_id],'NodeColor','k');
x_winning=G.game_graph.Nodes.Node_obj.findobj('node_val',127);
highlight(plot_handle,[x_winning.node_id],'MarkerSize',2,'NodeColor','r');
o_winning=G.game_graph.Nodes.Node_obj.findobj('node_val',-127);
highlight(plot_handle,[o_winning.node_id],'MarkerSize',2,'NodeColor','b');
x_won=G.game_graph.Nodes.Node_obj.findobj('who_won',1);
highlight(plot_handle,[x_won.node_id],'MarkerSize',3,'NodeColor','r');
o_won=G.game_graph.Nodes.Node_obj.findobj('who_won',0);
highlight(plot_handle,[o_won.node_id],'MarkerSize',3,'NodeColor','b');


G=G.tttminmax(parent_node);
    
%G.update_graph_val;
save('tttgraph.mat','G');
