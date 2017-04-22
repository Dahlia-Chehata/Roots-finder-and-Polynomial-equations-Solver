function varargout = P1Roots(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @P1Roots_OpeningFcn, ...
                   'gui_OutputFcn',  @P1Roots_OutputFcn, ...
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


% --- Executes just before P1Roots is made visible.
function P1Roots_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to P1Roots (see VARARGIN)

% Choose default command line output for P1Roots
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes P1Roots wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = P1Roots_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function mxItBox_Callback(hObject, eventdata, handles)
    text = get(hObject, 'string');
    number = str2num(text);
    if isempty(str2num(text))
        set(hObject,'string','0');
        warndlg('Input must be an integer');
    end

% --- Executes during object creation, after setting all properties.
function mxItBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mxItBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function percBox_Callback(hObject, eventdata, handles)
	text = get(hObject, 'string');
    if isempty(str2num(text))
        set(hObject,'string','0');
        warndlg('Input must be numerical');
    end

% --- Executes during object creation, after setting all properties.
function percBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to percBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in setDefaultValueBtn.
function setDefaultValueBtn_Callback(hObject, eventdata, handles)
set(handles.itLabel, 'string', 50);
set(handles.percLabel, 'string', 0.00001);

% --- Executes on button press in setValueBtn.
function setValueBtn_Callback(hObject, eventdata, handles)
set(handles.itLabel, 'string', get(handles.mxItBox, 'string'));
set(handles.percLabel, 'string', get(handles.percBox, 'string'));


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
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


% --- Executes on button press in stepButton.
function stepButton_Callback(hObject, eventdata, handles)
% hObject    handle to stepButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in solveButton.
function solveButton_Callback(hObject, eventdata, handles)
selectedIndex = get(handles.popupmenu1, 'value');
f = get(handles.funcBox, 'string');
a = str2num(get(handles.startBox, 'string'));
b = str2num(get(handles.endBox, 'string'));
maxIterations = str2num(get(handles.itLabel, 'string'));
eps = get(handles.percLabel, 'string');
solveMainAlgorithm(selectedIndex, f, a, b, maxIterations, eps);
solveOptionalAlgorithm(selectedIndex, f, a, b, maxIterations, eps, handles);

function solveOptionalAlgorithm(selectedIndex, f, a, b, maxIterations, eps, handles)
try
    if selectedIndex == 1
        [root,iterations,IterTable,precision,bound,time] = bisection(f, a, b, maxIterations,eps);
    elseif selectedIndex == 2
        
    elseif selectedIndex == 3
        
    elseif selectedIndex == 4
        
    elseif selectedIndex == 5
        
    elseif selectedIndex == 6

    end
    set(handles.optRootLabel, 'string', root);
    set(handles.optIterationsLabel, 'string', iterations);
    set(handles.optPrecisionLabel, 'string', precision);
    set(handles.optTimeLabel, 'string', time);
catch ME
    errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
		ME.stack(1).name, ME.stack(1).line, ME.message);
	fprintf(1, '%s\n', errorMessage);
	uiwait(warndlg(errorMessage));
end
    
    
function solveMainAlgorithm(selectedIndex, f, a, b, maxIterations, eps)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
try
    % Get value of popup
    selectedIndex = get(handles.popupmenu1, 'value');
    % Take action based upon selection
    if selectedIndex  == 1 || selectedIndex == 2 || selectedIndex == 5
        set(handles.endBox, 'enable', 'on');
    elseif selectedIndex == 3 || selectedIndex == 4 || selectedIndex == 6
        set(handles.endBox, 'enable', 'off');
    end
catch ME
	errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
		ME.stack(1).name, ME.stack(1).line, ME.message);
	fprintf(1, '%s\n', errorMessage);
	uiwait(warndlg(errorMessage));
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
try
    inputFile = fopen('input.txt');
    selectedIndex = get(handles.popupmenu1, 'value');
    if selectedIndex  == 1 || selectedIndex == 2 || selectedIndex == 5
        C = textscan(inputFile,'%s %s %s');
        set(handles.funcBox, 'string', C{1}{1});
        set(handles.startBox, 'string', C{2}{1});
        set(handles.endBox, 'string', C{3}{1});
    elseif selectedIndex == 3 || selectedIndex == 4 || selectedIndex == 6
        C = textscan(inputFile,'%s %s');
        set(handles.funcBox, 'string', C{1}{1});
        set(handles.startBox, 'string', C{2}{1});

    end
catch ME
	errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
		ME.stack(1).name, ME.stack(1).line, ME.message);
	fprintf(1, '%s\n', errorMessage);
	uiwait(warndlg(errorMessage));
end
fclose(fileID);


function funcBox_Callback(hObject, eventdata, handles)
% hObject    handle to funcBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of funcBox as text
%        str2double(get(hObject,'String')) returns contents of funcBox as a double


% --- Executes during object creation, after setting all properties.
function funcBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to funcBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function startBox_Callback(hObject, eventdata, handles)
    text = get(hObject, 'string');
    number = str2num(text);
    if isempty(str2num(text))
        set(hObject,'string','0');
        warndlg('Input must be an numerical');
    end

% --- Executes during object creation, after setting all properties.
function startBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endBox_Callback(hObject, eventdata, handles)
    text = get(hObject, 'string');
    number = str2num(text);
    if isempty(str2num(text))
        set(hObject,'string','0');
        warndlg('Input must be an numerical');
    end

% --- Executes during object creation, after setting all properties.
function endBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
