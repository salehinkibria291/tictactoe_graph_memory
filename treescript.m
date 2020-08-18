clc;clearvars;

pos=nan(3);

G=tictactoegraph(pos);

a=G.tttfindposition(pos);

pos(1,2)=1;

G=G.tttaddnode(pos);

b=G.tttfindposition(pos);

pos(1,1)=0;

G=G.tttaddnode(pos);

c=G.tttfindposition(pos);

pos(1,1)=nan;
pos(1,3)=0;

G=G.tttaddnode(pos);

d=G.tttfindposition(pos);

G=G.tttaddedge(a,b);


G=G.tttaddedge(b,c);


G=G.tttaddedge(b,d);

plot(G.game_graph)

% 
% a=addChild(a,b)
