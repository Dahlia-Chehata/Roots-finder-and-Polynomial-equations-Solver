function varargout = P1Roots(varargin)
% P1ROOTS M-file for P1Roots.fig
%      P1ROOTS, by itself, creates a new P1ROOTS or raises the existing
%      singleton*.
%
%      H = P1ROOTS returns the handle to a new P1ROOTS or the handle to
%      the existing singleton*.
%
%      P1ROOTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in P1ROOTS.M with the given input arguments.
%
%      P1ROOTS('Property','Value',...) creates a new P1ROOTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before P1Roots_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to P1Roots_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help P1Roots

% Last Modified by GUIDE v2.5 22-Apr-2017 01:04:42

% Begin initialization code - DO NOT EDIT
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
% hObject    handle to mxItBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mxItBox as text
%        str2double(get(hObject,'String')) returns contents of mxItBox as a double


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
% hObject    handle to percBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of percBox as text
%        str2double(get(hObject,'String')) returns contents of percBox as a double


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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
% hObject    handle to startBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startBox as text
%        str2double(get(hObject,'String')) returns contents of startBox as a double


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
% hObject    handle to endBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endBox as text
%        str2double(get(hObject,'String')) returns contents of endBox as a double


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
