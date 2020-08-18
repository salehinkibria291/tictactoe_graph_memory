function varargout = tictactoe_gui(varargin)
% TICTACTOE_GUI MATLAB code for tictactoe_gui.fig
%      TICTACTOE_GUI, by itself, creates a new TICTACTOE_GUI or raises the existing
%      singleton*.
%
%      H = TICTACTOE_GUI returns the handle to a new TICTACTOE_GUI or the handle to
%      the existing singleton*.
%
%      TICTACTOE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TICTACTOE_GUI.M with the given input arguments.
%
%      TICTACTOE_GUI('Property','Value',...) creates a new TICTACTOE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tictactoe_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tictactoe_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tictactoe_gui

% Last Modified by GUIDE v2.5 15-Aug-2020 17:52:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @tictactoe_gui_OpeningFcn, ...
    'gui_OutputFcn',  @tictactoe_gui_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before tictactoe_gui is made visible.
function tictactoe_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tictactoe_gui (see VARARGIN)

% Choose default command line output for tictactoe_gui
handles.output = hObject;
load('tttgraph.mat','G');
handles.G=G;
board=tictactoeboard(nan(3,3));
handles.board=board;
handles.current_node=G.game_graph.Nodes.Node_obj(1);
handles.player_x=0;
handles.player_o=6;
update_axes(handles);
handles.button_pressed=0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tictactoe_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
function update_axes(handles)
handles.axes1=plot(handles.G.game_graph,'Layout','layered');
all_nodes=handles.G.game_graph.Nodes.Node_obj;
highlight(handles.axes1,[all_nodes.node_id],'NodeColor','k');
x_winning=handles.G.game_graph.Nodes.Node_obj.findobj('node_val',127);
highlight(handles.axes1,[x_winning.node_id],'MarkerSize',2,'NodeColor','r');
o_winning=handles.G.game_graph.Nodes.Node_obj.findobj('node_val',-127);
highlight(handles.axes1,[o_winning.node_id],'MarkerSize',2,'NodeColor','b');
x_won=handles.G.game_graph.Nodes.Node_obj.findobj('who_won',1);
highlight(handles.axes1,[x_won.node_id],'MarkerSize',3,'NodeColor','r');
o_won=handles.G.game_graph.Nodes.Node_obj.findobj('who_won',0);
highlight(handles.axes1,[o_won.node_id],'MarkerSize',3,'NodeColor','b');
highlight(handles.axes1,[handles.current_node.node_id],'MarkerSize',5,'NodeColor','g');


% --- Outputs from this function are returned to the command line.
function varargout = tictactoe_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_newgame.
function pushbutton_newgame_Callback(hObject, eventdata, handles)
handles.output = hObject;
set(handles.pushbutton1,'Enable','on');
set(handles.pushbutton2,'Enable','on');
set(handles.pushbutton3,'Enable','on');
set(handles.pushbutton4,'Enable','on');
set(handles.pushbutton5,'Enable','on');
set(handles.pushbutton6,'Enable','on');
set(handles.pushbutton7,'Enable','on');
set(handles.pushbutton8,'Enable','on');
set(handles.pushbutton9,'Enable','on');
set(handles.pushbutton1,'String','');
set(handles.pushbutton2,'String','');
set(handles.pushbutton3,'String','');
set(handles.pushbutton4,'String','');
set(handles.pushbutton5,'String','');
set(handles.pushbutton6,'String','');
set(handles.pushbutton7,'String','');
set(handles.pushbutton8,'String','');
set(handles.pushbutton9,'String','');
handles.text1.String='';
handles.board.reset;
handles.current_node=handles.G.game_graph.Nodes.Node_obj(1);
handles.player_x=handles.uibuttongroup_x.SelectedObject.UserData;
handles.player_o=handles.uibuttongroup_o.SelectedObject.UserData;
handles.button_pressed=0;
guidata(hObject,handles);

handles=play_game(hObject,handles);
guidata(hObject,handles);


function handles=play_game(hObject,handles)
a=tictactoeengine(handles.current_node);
a.game_seq=[];
a.moves_remaining=9;
for i=1:9
    if(mod(i,2))
        if(handles.player_x)
            next_move=generateMove(a,handles.player_x);
        else
            uiwait;
            old_handles=handles;
            handles = guidata(hObject);
            disp(handles);
            next_move=handles.button_pressed;
            handles=old_handles;
            
            
        end
    else
        if(handles.player_o)
            next_move=generateMove(a,handles.player_o);
        else
            uiwait;
            old_handles=handles;
            handles = guidata(hObject);
            disp(handles);
            next_move=handles.button_pressed;
            handles=old_handles;
            
            
        end
        
    end
    a.game_seq=[a.game_seq next_move];
    a.moves_remaining=a.moves_remaining-1;
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
    set(current_button,'Enable','off');
    handles.board=play_move(handles.board,next_move);
    [handles.G,handles.current_node]=update_graph(handles.G,handles.current_node,handles.board);
    G=handles.G;
    a.current_node=handles.current_node;
    save('tttgraph.mat','G');
    %     cb=get(current_button,'Callback');
    %     cb(current_button,[])
    disp(handles.current_node)
    if(mod(handles.current_node.moves_played,2))
        set(current_button,'String','x');
    else
        set(current_button,'String','o');
    end
    is_board_won(handles);
    
    
    
    if(handles.board.is_won)
        %a.train_ai(board.who_won);
        break;
    end
    
    guidata(hObject,handles);
end



%x=play_game(3,3)
% hObject    handle to pushbutton_newgame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.button_pressed=1;
guidata(hObject,handles);
uiresume;





% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.button_pressed=2;
guidata(hObject,handles);
uiresume;

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.button_pressed=3;
guidata(hObject,handles);
uiresume;



% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.button_pressed=4;
guidata(hObject,handles);
uiresume;

% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.button_pressed=5;
guidata(hObject,handles);
uiresume;

% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.button_pressed=6;
guidata(hObject,handles);
uiresume;

% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.button_pressed=7;
guidata(hObject,handles);
uiresume;

% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.button_pressed=8;
guidata(hObject,handles);
uiresume;

% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
handles.button_pressed=9;
guidata(hObject,handles);
uiresume;

% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function is_board_won(handles)
update_axes(handles);
if(handles.board.is_won||handles.current_node.moves_played==9)
    set(handles.pushbutton1,'Enable','off');
    set(handles.pushbutton2,'Enable','off');
    set(handles.pushbutton3,'Enable','off');
    set(handles.pushbutton4,'Enable','off');
    set(handles.pushbutton5,'Enable','off');
    set(handles.pushbutton6,'Enable','off');
    set(handles.pushbutton7,'Enable','off');
    set(handles.pushbutton8,'Enable','off');
    set(handles.pushbutton9,'Enable','off');
    handles.G=handles.G.tttminmax(handles.current_node);
    switch(handles.board.who_won)
        case 1
            handles.text1.String='X WINS!';
        case 0
            handles.text1.String='O WINS!';
        otherwise
            handles.text1.String='DRAW';
    end
    
    
end


% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
