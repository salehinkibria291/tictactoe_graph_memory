function plot_handle=plot_game_graph(G)
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
draw_now;
end