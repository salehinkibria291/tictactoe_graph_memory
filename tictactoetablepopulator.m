clc;clearvars;
x_win=0;
o_win=0;
draw=0;
load('tictactoedatabase.mat');
[total_games,total_squares]=size(game_matrix);
tic;
for i=1:total_games
    board=tictactoeboard(nan(3,3));
    game_seq=game_matrix(i,:);
    board=play_game(board,game_seq);
    switch(board.who_won)
        case true
            x_win=x_win+1;
            eval_score(i)=true;
        case false
            o_win=o_win+1;
            eval_score(i)=false;
        otherwise
            draw=draw+1;
    end
    
    if(~mod(i,20000)) disp(i/total_games); end
end
toc;
x_win
o_win
draw
save('tictactoedatabase.mat','game_matrix','eval_score')
