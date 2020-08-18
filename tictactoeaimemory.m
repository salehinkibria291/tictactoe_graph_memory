clc;clearvars;
total_squares=3*3;
total_games=factorial(total_squares);
ai_eval_score=0.5*ones(total_games,1);

save('tictactoeaidatabase.mat','ai_eval_score');
