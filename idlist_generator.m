function idlist_generator()
id_list=[];
next_id=1;
save('tictactoeidlist.mat','id_list','next_id');
G=tictactoegraph(nan(3,3));
save('tttgraph.mat','G');
end

