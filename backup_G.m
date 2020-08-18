function backup_G()

load('tttgraph.mat','G');
save(['tttgraph_' num2str(posixtime(datetime('now')) * 1e3) '.mat'],'G');

end
