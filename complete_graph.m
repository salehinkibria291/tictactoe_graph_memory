function current_node=complete_graph(current_node,G)

%clearvars;
%idlist_generator();

%load('tttgraph.mat','G');
%update_node_complete(G.game_graph.Nodes.Node_obj);
%incomplete_nodes=G.game_graph.Nodes.Node_obj.findobj('is_complete_node',0);

%current_node=incomplete_nodes(1);
unplayed_moves=find(current_node.position==2);
moves_previously_played=current_node.move_to_child(find(current_node.move_to_child));
moves_never_played=setxor(unplayed_moves,moves_previously_played);
position=current_node.position;
position(position==2)=nan;
board=tictactoeboard(position);
disp('Position is')
disp(board.position)
figure(1)
plot_handle=plot(G.game_graph,'Layout','layered');
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

incomplete_nodes=G.game_graph.Nodes.Node_obj.findobj('is_complete_node',0);
highlight(plot_handle,[incomplete_nodes.node_id],'MarkerSize',5,'NodeColor','g');
highlight(plot_handle,current_node.node_id,'MarkerSize',7,'NodeColor','y');
save('tttgraph.mat','G');
drawnow;

for i=1:numel(moves_never_played)
    
    disp('New move is')
    disp(moves_never_played(i))
    board=play_move(board,moves_never_played(i));
    
    [G,new_node]=G.update_graph(current_node,board);
    update_node_complete(new_node);
    if(new_node.is_complete_node==0)
        new_node=complete_graph(new_node,G);
    else
        G=G.tttminmax(new_node);
        save('tttgraph.mat','G');
    end
    board=undo_move(board,moves_never_played(i));
    
end

