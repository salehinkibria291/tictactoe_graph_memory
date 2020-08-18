function handles=play_game(handles)
for i=1:9
    a=tictactoeengine(handles.current_node);
    if(mod(i,2))
        next_move=generateMove(a,handles.player_x);
    else
        next_move=generateMove(a,handles.player_o);
    end
    a.game_seq=[a.game_seq next_move];
    switch(next_move)
        case 1
            current_button=handles.pushbutton1;
        case 2
            current_button=handles.pushbutton2;
        case 3
            current_button=handles.pushbutton3;
        case 4
            current_button=handles.pushbutton4;
        case 5
            current_button=handles.pushbutton5;
        case 6
            current_button=handles.pushbutton6;
        case 7
            current_button=handles.pushbutton7;
        case 8
            current_button=handles.pushbutton8;
        case 9
            current_button=handles.pushbutton9;
    end
            
    cb=get(current_button,'Callback');
    cb(current_button,[])
    
    
    if(board.is_won)
        %a.train_ai(board.who_won);
        break;
    end
    
end


end
