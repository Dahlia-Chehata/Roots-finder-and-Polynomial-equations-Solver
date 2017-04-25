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
    errordlg('Input must be an integer');
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
    errordlg('Input must be numerical');
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
global changedData;
changedData = true;
set(handles.itLabel, 'string', 50);
set(handles.percLabel, 'string', 0.00001);

% --- Executes on button press in setValueBtn.
function setValueBtn_Callback(hObject, eventdata, handles)
global changedData;
changedData = true;
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
global changedData;
global mRoot mIterations mHeader mIterTable mPrecision mTime;
global oRoot oIterations oHeader oIterTable oPrecision oTime
global ind1 ind2;
if(changedData == true)
    getGlobalData(handles);
end
setGlobalData(handles);


function getGlobalData(handles)
global ind1 ind2;
global changedData;
global mRoot mIterations mHeader mIterTable mPrecision mTime;
global oRoot oIterations oHeader oIterTable oPrecision oTime;
global selectedIndex;
selectedIndex = get(handles.popupmenu1, 'Value');
f = get(handles.funcBox, 'string');
g = get(handles.extraFuncBox, 'string');
a = str2num(get(handles.startBox, 'string'));
a1 = str2num(get(handles.mainStartBox, 'string'));
b = str2num(get(handles.endBox, 'string'));
maxIterations = str2num(get(handles.itLabel, 'string'));
eps = str2num(get(handles.percLabel, 'string'));
setConstPlotData(selectedIndex, f, a, b, g)
[mRoot,mIterations,mHeader,mIterTable,mPrecision,mTime] = solveMainAlgorithm(f, a1, maxIterations, eps, handles);
[oRoot,oIterations,oHeader,oIterTable,oPrecision,oTime] = solveOptionalAlgorithm(selectedIndex, f, a, b, g, maxIterations, eps, handles);
changedData = false;
ind1 = 0;
ind2 = 0;

function setGlobalData(handles)
global ind1 ind2;
global changedData;
global mRoot mIterations mHeader mIterTable mPrecision mTime;
global oRoot oIterations oHeader oIterTable oPrecision oTime;
global selectedIndex;
if(changedData == false)
    ind1 = ind1 + 1;
    ind2 = ind2 + 1;
    h1 = length(mHeader);
    h2 = length(oHeader);
    mMaxSize = min(ind1, size(mIterTable,1));
    oMaxSize = min(ind2, size(oIterTable,1));
    setIterPlotData(oIterTable(oMaxSize:oMaxSize, 1:h2));
    setMainData(mRoot,mIterations,mHeader,mIterTable(1:mMaxSize, 1 : h1),mPrecision,mTime, handles);
    setOptData(oRoot,oIterations,oHeader,oIterTable(1:oMaxSize, 1:h2),oPrecision,oTime, handles);
end

function setConstPlotData(selectedIndex, f, a, b, g)
global pIndex pF pA pB pG pMaxIterations pEps;
pIndex = selectedIndex;
pF = f;
pA = a;
pB = b;
pG = g;

function setIterPlotData(iterTable)
global pIter;
pIter = iterTable;

% --- Executes on button press in solveButton.
function solveButton_Callback(hObject, eventdata, handles)
global changedData selectedIndex;
changedData = true;
warning('off','all')
selectedIndex = get(handles.popupmenu1, 'Value');
f = get(handles.funcBox, 'string');
g = get(handles.extraFuncBox, 'string');
a = str2num(get(handles.startBox, 'string'));
a1 = str2num(get(handles.mainStartBox, 'string'));
b = str2num(get(handles.endBox, 'string'));
maxIterations = str2num(get(handles.itLabel, 'string'));
eps = str2num(get(handles.percLabel, 'string'));
setConstPlotData(selectedIndex, f, a, b, g)
[mRoot,mIterations,mHeader,mIterTable,mPrecision,mTime] = solveMainAlgorithm(f, a1, maxIterations, eps, handles);
[oRoot,oIterations,oHeader,oIterTable,oPrecision,oTime] = solveOptionalAlgorithm(selectedIndex, f, a, b, g, maxIterations, eps, handles);
setMainData(mRoot,mIterations,mHeader,mIterTable,mPrecision,mTime, handles);
setOptData(oRoot,oIterations,oHeader,oIterTable,oPrecision,oTime, handles);


function [root,iterations,header,IterTable,precision,time] = solveOptionalAlgorithm(selectedIndex, f, a, b, g, maxIterations, eps, handles)
try
    switch selectedIndex
        case 1
            [root,iterations,header,IterTable,precision,time] = bisection(f, a, b, maxIterations,eps);
        case 2
            [root,iterations,header,IterTable,precision,time] = regulafalsi(f,a,b, maxIterations,eps);
        case 3
            [ root,iterations,header,IterTable,precision,time ] = fixed_point( f,a,g, maxIterations, eps );
        case 4
            [root,iterations,header,IterTable,precision,time] = NewtonRaphson(f,a,maxIterations,eps,eps);
        case 5
            [root,iterations,header,IterTable,precision,time] = Secant(f,a, b,maxIterations,eps,eps);
        case 6
            [root,iterations,header,IterTable,precision,time] = birgeVieta(f,a,eps,maxIterations);
        otherwise
            errordlg('Wrong method!');
            return;
    end
    setIterPlotData(IterTable(1:length(header)));
catch ME
    errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
        ME.stack(1).name, ME.stack(1).line, ME.message);
    fprintf(1, '%s\n', errorMessage);
    uiwait(errordlg(errorMessage));
end

function setOptData(root,iterations,header,IterTable,precision,time, handles)
set(handles.optRootLabel, 'string', root);
set(handles.optIterationsLabel, 'string', iterations);
set(handles.optPrecisionLabel, 'string', precision);
set(handles.optTimeLabel, 'string', time);
buildTable(handles.optTable,header, IterTable)

function [root,iterations,header,IterTable,precision,time] = solveMainAlgorithm(f, a1, maxIterations, eps, handles)
try
    [root,iterations,header,IterTable,precision,time] = NewtonRaphson(f,a1,maxIterations,eps,eps);
catch ME
    errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
        ME.stack(1).name, ME.stack(1).line, ME.message);
    fprintf(1, '%s\n', errorMessage);
    uiwait(errordlg(errorMessage));
end

function setMainData(root,iterations,header,IterTable,precision,time, handles)
set(handles.mainRootLabel, 'string', root);
set(handles.mainIterationsLabel, 'string', iterations);
set(handles.mainPrecisionLabel, 'string', precision);
set(handles.mainTimeLabel, 'string', time);
buildTable(handles.mainTable,header, IterTable)

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
try
    global changedData;
    changedData = true;
    % Get value of popup
    selectedIndex = get(handles.popupmenu1, 'Value');
    % Take action based upon selection
    if selectedIndex  == 1 || selectedIndex == 2 || selectedIndex == 5
        set(handles.endBox, 'enable', 'on');
    elseif selectedIndex == 3 || selectedIndex == 4 || selectedIndex == 6
        set(handles.endBox, 'enable', 'off');
    end
    if selectedIndex == 3
        set(handles.extraFuncBox, 'enable', 'on');
    else
        set(handles.extraFuncBox, 'enable', 'off');
    end
catch ME
    errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
        ME.stack(1).name, ME.stack(1).line, ME.message);
    fprintf(1, '%s\n', errorMessage);
    uiwait(errordlg(errorMessage));
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
    global changedData;
    changedData = true;
    inputFile = fopen('input.txt');
    selectedIndex = get(handles.popupmenu1, 'value');
    if selectedIndex  == 1 || selectedIndex == 2 || selectedIndex == 5
        C = textscan(inputFile,'%s %s %s');
        set(handles.funcBox, 'string', C{1}{1});
        set(handles.startBox, 'string', C{2}{1});
        set(handles.endBox, 'string', C{3}{1});
    elseif selectedIndex == 3 || selectedIndex == 4 || selectedIndex == 6
        C = textscan(inputFile,'%s %s %s');
        set(handles.funcBox, 'string', C{1}{1});
        set(handles.extraFuncBox, 'string', C{2}{1});
        set(handles.startBox, 'string', C{3}{1});
    end
catch ME
    errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
        ME.stack(1).name, ME.stack(1).line, ME.message);
    fprintf(1, '%s\n', errorMessage);
    uiwait(errordlg(errorMessage));
end
fclose(inputFile);


function funcBox_Callback(hObject, eventdata, handles)
global changedData;
changedData = true;

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
global changedData;
changedData = true;
text = get(hObject, 'string');
number = str2num(text);
if isempty(str2num(text))
    set(hObject,'string','0');
    errordlg('Input must be an numerical');
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
global changedData;
changedData = true;
text = get(hObject, 'string');
number = str2num(text);
if isempty(str2num(text))
    set(hObject,'string','0');
    errordlg('Input must be an numerical');
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

function buildTable(table,header, data)
set(table, 'columnname', header);
set(table, 'data', data);




function extraFuncBox_Callback(hObject, eventdata, handles)
global changedData;
changedData = true;


% --- Executes during object creation, after setting all properties.
function extraFuncBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to extraFuncBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mainStartBox_Callback(hObject, eventdata, handles)
global changedData;
changedData = true;


% --- Executes during object creation, after setting all properties.
function mainStartBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mainStartBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function plot_Callback(hObject, eventdata, handles)
global pIndex pF pA pB pG pMaxIterations pEps pIter;
axes(handles.axes1);
try
    switch pIndex
        case 1
            syms x y
            cla;
            ezplot(pF, [pA, pB]);
            val1 = eval(subs(pF, pA));
            val2 = eval(subs(pF, pB));
            maxVal = max(abs(val1), abs(val2));
            hold on;
            plot([pA, pB], [0 0], 'k-');
            hold on;
            plot([0, 0], [pA pB], 'k-');
            hold on;
            plot([pIter(5), pIter(5)], [-maxVal, maxVal], '--'); 
            hold on;
            plot([pIter(1), pIter(1)], [-maxVal, maxVal]);
            hold on;
            plot([pIter(3), pIter(3)], [-maxVal, maxVal]);            
            %[root,iterations,header,IterTable,precision,time] = bisection(f, a, b, maxIterations,eps);
        case 2
            %[root,iterations,header,IterTable,precision,time] = regulafalsi(f,a,b, maxIterations,eps);
        case 3
            %[ root,iterations,header,IterTable,precision,time ] = fixed_point( f,a,g, maxIterations, eps );
        case 4
            %[root,iterations,header,IterTable,precision,time] = NewtonRaphson(f,a,maxIterations,eps,eps);
        case 5
            %[root,iterations,header,IterTable,precision,time] = Secant(f,a, b,maxIterations,eps,eps);
        case 6
            %[root,iterations,header,IterTable,precision,time] = birgeVieta(f,a,eps,maxIterations);
        otherwise
            errordlg('Wrong Plotting data!');
            return;
    end    
catch ME
    errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
        ME.stack(1).name, ME.stack(1).line, ME.message);
    fprintf(1, '%s\n', errorMessage);
    uiwait(errordlg(errorMessage));
end


% --- Executes on button press in funcPlotter.
function funcPlotter_Callback(hObject, eventdata, handles)
f = get(handles.funcBox, 'string');
a = str2num(get(handles.startBox, 'string'));
b = str2num(get(handles.endBox, 'string'));
cla;
ezplot(f, [a, b]);
hold on;
plot([a, b], [0 0], 'k-');
hold on;
plot([0, 0], [a b], 'k-');
