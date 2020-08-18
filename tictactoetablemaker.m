clc;clearvars;
total_squares=3*3;
total_games=factorial(total_squares);
game_matrix=perms(1:total_squares);
eval_score=nan(total_games,1);

save('tictactoedatabase.mat','game_matrix','eval_score');
