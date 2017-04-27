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
function P1Roots_OpeningFcn(hObject, ~, handles, varargin)
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
function varargout = P1Roots_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function mxItBox_Callback(hObject, ~, ~)
text = get(hObject, 'string');
if isempty(str2double(text))
    set(hObject,'string','0');
    errordlg('Input must be an integer');
end

% --- Executes during object creation, after setting all properties.
function mxItBox_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function percBox_Callback(hObject, ~, ~)
text = get(hObject, 'string');
if isempty(str2double(text))
    set(hObject,'string','0');
    errordlg('Input must be numerical');
end

% --- Executes during object creation, after setting all properties.
function percBox_CreateFcn(hObject, ~, ~)
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
plotGraph(handles);


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
setConstPlotData(selectedIndex, f, a, b, g);
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
plotGraph(handles);


function [root,iterations,header,IterTable,precision,time] = solveOptionalAlgorithm(selectedIndex, f, a, b, g, maxIterations, eps, handles)
warning('off','all')
try
    switch selectedIndex
        case 1
            [root,iterations,header,IterTable,precision,time] = bisection(f, a, b, maxIterations,eps);
        case 2
            [root,iterations,header,IterTable,precision,time] = regulafalsi(f,a,b, maxIterations,eps);
        case 3
            [ root,iterations,header,IterTable,precision,time ] = fixed_point( f,a,g, maxIterations, eps );
        case 4
            [root,iterations,header,IterTable,precision,time] = NewtonRaphson(f,a,maxIterations,eps);
        case 5
            [root,iterations,header,IterTable,precision,time] = Secant(f,a, b,maxIterations,eps);
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
warning('off','all')
try
    [root,iterations,header,IterTable,precision,time] = NewtonRaphson(f,a1,maxIterations,eps);
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
plotGraph(handles);

function plotGraph(handles)
global pIndex pF pA pB pG pIter;
axes(handles.axes1);
try
    switch pIndex
        case 1
            plotBisection(handles);
        case 2
            plotRegulaFalsi(handles);
        case 3
            plotFixedPoint(handles);
        case 4
            %[root,iterations,header,IterTable,precision,time] = NewtonRaphson(f,a,maxIterations,eps);
        case 5
            %[root,iterations,header,IterTable,precision,time] = Secant(f,a, b,maxIterations,eps);
        case 6
            %[root,iterations,header,IterTable,precision,time] = birgeVieta(f,a,eps,maxIterations);
        otherwise
            errordlg('Wrong Plotting data!');
            return;
    end
catch ME
    errorMessage = sprintf('Err Message:\n%s', ...
        ME.message);
    fprintf(1, '%s\n', errorMessage);
    uiwait(errordlg(errorMessage));
end

function [x1,x2] = getPlotData(handles)
x1 = str2num(get(handles.plotStartX, 'string'));
x2 = str2num(get(handles.plotEndX, 'string'));


function plotBisection(handles)
global pF pA pB pIter;
[x1 x2] = getPlotData(handles);
syms x y;
cla;
ezplot(pF, [x1, x2]);
hold on;
plot([x1, x2], [0 0], 'k-');
hold on;
%Large values are used for long vertical axis
plot([0, 0], [-500000 500000], 'k-');
hold on;
plot([pIter(5), pIter(5)], [-500000, 500000], '--');
hold on;
plot([pIter(1), pIter(1)], [-500000, 500000]);
hold on;
plot([pIter(3), pIter(3)], [-500000, 500000]);

function plotRegulaFalsi(handles)
global pF pA pB pIter;
[x1 x2] = getPlotData(handles);
syms x y;
cla;
ezplot(pF, [x1, x2]);
hold on;
plot([x1, x2], [0 0], 'k-');
hold on;
%Large values are used for long vertical axis
plot([0, 0], [-500000 500000], 'k-');
hold on;
plot([pIter(1) pIter(2)], [eval(subs(pF, pIter(1))) eval(subs(pF, pIter(2)))]);
plot([pIter(3), pIter(3)], [-500000 500000], 'k-');
plot([pIter(1), pIter(1)], [-500000 500000], 'k-');
plot([pIter(2), pIter(2)], [-500000 500000], 'k-');

function plotFixedPoint(handles)
global pF pA pB pG pIter;
[x1 x2] = getPlotData(handles);
syms x y;
cla;
ezplot(pF, [x1, x2]);
ezplot(pG, [x1, x2]);
hold on;
plot([x1, x2], [0 0], 'k-');
hold on;
%Large values are used for long vertical axis
plot([0, 0], [-500000 500000], 'k-');
hold on;
plot([0, 0], [1,1]);
plot([pIter(2), pIter(2)], [-500000 500000], 'k-');

% --- Executes on button press in funcPlotter.
function funcPlotter_Callback(hObject, eventdata, handles)
try
    f = get(handles.funcBox, 'string');
    a = str2num(get(handles.plotStartX, 'string'));
    b = str2num(get(handles.plotEndX, 'string'));
    if(a >= b)
        error('Wrong Plotting data!');
    end
    cla;
    ezplot(f, [a, b]);
    hold on;
    plot([a, b], [0 0], 'k-');
    hold on;
    plot([0, 0], [-500000 500000], 'k-');
    %%large values are used in drawing the vertical axis just to get
    %% a large enough line.
catch ME
    errorMessage = sprintf('Error Message:\n%s', ...
        ME.message);
    fprintf(1, '%s\n', errorMessage);
    uiwait(errordlg(errorMessage));
end



function plotStartX_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function plotStartX_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function plotEndX_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function plotEndX_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plotAll.
function plotAll_Callback(hObject, eventdata, handles)
try
maxIterations = str2num(get(handles.itLabel, 'string'));
eps = str2num(get(handles.percLabel, 'string'));
inputFile = fopen('allinput.txt', 'r');
[f, biA, biB, rfA, rfB, fpA, g, npA, secA, secB, bvA] = readData(inputFile);
[~,~,~,biIterTable] = bisection(f, biA, biB, maxIterations,eps);
[~,~,~,rfIterTable] = regulafalsi(f,rfA, rfB, maxIterations,eps);
[~,~,~,fpIterTable] = fixed_point( f,fpA,g, maxIterations, eps );
[~,~,~,npIterTable] = NewtonRaphson(f,npA,maxIterations,eps);
[root,~,~,secIterTable] = Secant(f,secA, secB,maxIterations,eps);
[~,~,~,bvIterTable] = birgeVieta(f,bvA,eps,maxIterations);
biIterTable = biIterTable(1:size(biIterTable), 5:5);
rfIterTable = rfIterTable(1:size(rfIterTable), 3:3);
fpIterTable = fpIterTable(1:size(fpIterTable), 2:2);
npIterTable = npIterTable(1:size(npIterTable), 4:4);
secIterTable = secIterTable(1:size(secIterTable), 3:3);
bvIterTable = bvIterTable(1:size(bvIterTable), 2:2);
plotAllIterations(biIterTable, rfIterTable, fpIterTable, npIterTable, secIterTable, bvIterTable, handles);
catch ME
    errorMessage = sprintf('Error in function %s()\nError Message:\n%s', ...
        ME.stack(1).name, ME.message);
    fprintf(1, '%s\n', errorMessage);
    uiwait(errordlg(errorMessage));
end

function [f, biA, biB, rfA, rfB, fpA, g, npA, secA, secB, bvA] = readData(inputFile)
[f] = readFunction(inputFile);
[biA, biB] = readIntervalRanges(inputFile);
[rfA, rfB] = readIntervalRanges(inputFile);
[fpA, g] = readFunctionWithData(inputFile);
[npA] = readStartingPoint(inputFile);
[secA, secB] = readIntervalRanges(inputFile);
[bvA] = readStartingPoint(inputFile);


function [f] = readFunction(inputFile)
f = fscanf(inputFile,'%s',1);

function [a, b] = readIntervalRanges(inputFile)
C = fscanf(inputFile,' %s',1);
a = str2double(C);
C = fscanf(inputFile,' %s',1);
b = str2double(C);

function [a] = readStartingPoint(inputFile)
C = fscanf(inputFile,' %s',1);
a = str2double(C);

function [fpA, g] = readFunctionWithData(inputFile)
[fpA] = readStartingPoint(inputFile);
[g] = readFunction(inputFile);

function plotAllIterations(biIterTable, rfIterTable, fpIterTable, npIterTable, secIterTable, bvIterTable, handles)
maxSize = max(size(biIterTable), size(rfIterTable));
maxSize1 = max(size(fpIterTable), size(npIterTable));
maxSize2 = max(size(secIterTable), size(bvIterTable));
maxSize1 = max(maxSize1, maxSize2);
maxSize = max(maxSize1, maxSize);
[biIterTable] = fix(biIterTable, maxSize);
[rfIterTable] = fix(rfIterTable, maxSize);
[fpIterTable] = fix(fpIterTable, maxSize);
[npIterTable] = fix(npIterTable, maxSize);
[secIterTable] = fix(secIterTable, maxSize);
[bvIterTable] = fix(bvIterTable, maxSize);
t = 1:maxSize;
c = horzcat(biIterTable, rfIterTable, fpIterTable, npIterTable, secIterTable, bvIterTable);
axes(handles.axes1);
plot(t, c);
legend('Bisection','False Position','Fixed Point','Newt. Raph.','Birge V.');

function [b] = fix(a, bSize)
b = zeros(bSize);
aSize = size(a);
aSize = aSize(1, 1);
for i = 1:bSize
    if(i <= aSize)
        b(i) = a(i);
    else
        b(i) = a(aSize);
    end
end
