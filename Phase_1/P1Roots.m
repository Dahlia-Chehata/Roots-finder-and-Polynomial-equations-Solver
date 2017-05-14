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
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in setDefaultValueBtn.
function setDefaultValueBtn_Callback(~, ~, handles)
global changedData;
changedData = true;
set(handles.itLabel, 'string', 50);
set(handles.percLabel, 'string', 0.00001);

% --- Executes on button press in setValueBtn.
function setValueBtn_Callback(~, ~, handles)
global changedData;
changedData = true;
set(handles.itLabel, 'string', get(handles.mxItBox, 'string'));
set(handles.percLabel, 'string', get(handles.percBox, 'string'));


% --- Executes on selection change in listbox1.
function listbox1_Callback(~, ~, ~)

function listbox1_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function stepButton_Callback(~, ~, handles)
global changedData;
if(changedData == true)
    getGlobalData(handles);
end
setGlobalData(handles);
plotGraph(handles);


function getGlobalData(handles)
global ind1 ind2;
global changedData;
global mRoot mIterations mHeader miterTable mPrecision mTime mError;
global oRoot oIterations oHeader oiterTable oPrecision oTime;
global selectedIndex;
selectedIndex = get(handles.popupmenu1, 'Value');
f = get(handles.funcBox, 'string');
g = get(handles.extraFuncBox, 'string');
a = str2double(get(handles.startBox, 'string'));
[a1,b1] = getInitialMain(handles,f);
b = str2double(get(handles.endBox, 'string'));
maxIterations = str2double(get(handles.itLabel, 'string'));
eps = str2double(get(handles.percLabel, 'string'));
setConstPlotData(selectedIndex, f, a, b, g);
[mRoot,mIterations,mHeader,miterTable,mPrecision,mTime,mError] = solveMainAlgorithm(f, a1, b1,maxIterations, eps);
[oRoot,oIterations,oHeader,oiterTable,oPrecision,oTime] = solveOptionalAlgorithm(selectedIndex, f, a, b, g, maxIterations, eps);
changedData = false;
ind1 = 0;
ind2 = 0;

function setGlobalData(handles)
global ind1 ind2;
global changedData;
global mRoot mIterations mHeader miterTable mPrecision mTime mError;
global oRoot oIterations oHeader oiterTable oPrecision oTime;
if(changedData == false)
    ind1 = ind1 + 1;
    ind2 = ind2 + 1;
    h1 = length(mHeader);
    h2 = length(oHeader);
    if mError == 0
        mMaxSize = min(ind1, size(miterTable,1));
        setMainData(mRoot,mIterations,mHeader,miterTable(1:mMaxSize, 1 : h1),mPrecision,mTime, handles);
    end
    oMaxSize = min(ind2, size(oiterTable,1));
    setIterPlotData(oiterTable(oMaxSize:oMaxSize, 1:h2));
    setOptData(oRoot,oIterations,oHeader,oiterTable(1:oMaxSize, 1:h2),oPrecision,oTime, handles);
end

function setConstPlotData(selectedIndex, f, a, b, g)
global pIndex pF pA pB pG;
pIndex = selectedIndex;
pF = f;
pA = a;
pB = b;
pG = g;

function setIterPlotData(iterTable)
global pIter;
pIter = iterTable;

% --- Executes on button press in solveButton.
function solveButton_Callback(~, ~, handles)
global changedData selectedIndex;
changedData = true;
selectedIndex = get(handles.popupmenu1, 'Value');
f = get(handles.funcBox, 'string');
g = get(handles.extraFuncBox, 'string');
a = str2double(get(handles.startBox, 'string'));
[a1,b1,error] = getInitialMain(handles, f);
b = str2double(get(handles.endBox, 'string'));
maxIterations = str2double(get(handles.itLabel, 'string'));
eps = str2double(get(handles.percLabel, 'string'));
setConstPlotData(selectedIndex, f, a, b, g)
if error ~= true
    [mRoot,mIterations,mHeader,miterTable,mPrecision,mTime, mError] = solveMainAlgorithm(f, a1, b1, maxIterations, eps);
    if mError == 0
        setMainData(mRoot,mIterations,mHeader,miterTable,mPrecision,mTime,handles);
        write_to_xls('output.xls',1, handles.mainTable);
    end
end
[oRoot,oIterations,oHeader,oiterTable,oPrecision,oTime] = solveOptionalAlgorithm(selectedIndex, f, a, b, g, maxIterations, eps);
setOptData(oRoot,oIterations,oHeader,oiterTable,oPrecision,oTime, handles);
write_to_xls('output.xls',2, handles.optTable);
plotGraph(handles);

function [a1,b1,error] = getInitialMain(handles, funct)
try
    a1 = 0;
    b1 = 0;
    searchStart = str2double(get(handles.searchStart, 'string'));
    searchDelta = str2double(get(handles.searchDelta, 'string'));
    maxTime = str2double(get(handles.searchTime, 'string'));
    timeSum = 0;
    i = 0;
    error = false;
    while timeSum < maxTime
        tic;
        firstVal = eval(subs(funct,searchStart + i * searchDelta));
        secondVal = eval(subs(funct,searchStart + (i+1) * searchDelta));
        if firstVal * secondVal <= 0
            a1 = searchStart + i * searchDelta;
            b1 = searchStart + (i + 1) * searchDelta;
            break;
        end
        timeSum = timeSum + toc;
        i = i + 1;
    end
    if timeSum >= maxTime
        error = true;
        errorMessage = sprintf('Could not find a good guesses method will stop');
        fprintf(1, '%s\n', errorMessage);
        uiwait(errordlg(errorMessage));
    end
catch ME
    ME.message()
    errorMessage = sprintf('Error Message:Please make sure that search data are valid.');
    fprintf(1, '%s\n', errorMessage);
    uiwait(errordlg(errorMessage));
end


function [root,iterations,header,iterTable,precision,time] = solveOptionalAlgorithm(selectedIndex, f, a, b, g, maxIterations, eps)
warning('off','all');
try
    switch selectedIndex
        case 1
            [root,iterations,header,iterTable,precision,time] = bisection(f, a, b, maxIterations,eps);
        case 2
            [root,iterations,header,iterTable,precision,time] = regulafalsi(f,a,b, maxIterations,eps);
        case 3
            [ root,iterations,header,iterTable,precision,time ] = fixed_point( f,a,g, maxIterations, eps );
        case 4
            [root,iterations,header,iterTable,precision,time] = NewtonRaphson(f,a,maxIterations,eps);
        case 5
            [root,iterations,header,iterTable,precision,time] = Secant(f,a, b,maxIterations,eps);
        case 6
            [root,iterations,header,iterTable,precision,time] = birgeVieta(f,a,maxIterations,eps);
        otherwise
            errordlg('Wrong method!');
            return;
    end
    setIterPlotData(iterTable(1:length(header)));
catch ME
    errorMessage = sprintf('Error Message:\n%s', ...
        ME.stack(1).name, ME.stack(1).line, ME.message);
    fprintf(1, '%s\n', errorMessage);
    uiwait(errordlg(errorMessage));
end

function setOptData(root,iterations,header,iterTable,precision,time, handles)
set(handles.optRootLabel, 'string', root);
set(handles.optIterationsLabel, 'string', iterations);
set(handles.optPrecisionLabel, 'string', precision);
set(handles.optTimeLabel, 'string', time);
buildTable(handles.optTable,header, iterTable)

function [root,iterations,header,iterTable,precision,time,error] = solveMainAlgorithm(f, a1, b1, maxIterations, eps)
warning('off','all')
error = 0;
try
    [root,iterations,header,iterTable,precision,time] = Illinois(f,a1,b1,maxIterations,eps);
catch ME
    errorMessage = sprintf('Error Message:\n%s', ...
        ME.message);
    fprintf(1, '%s\n', errorMessage);
    uiwait(errordlg(errorMessage));
    error = 1;
end

function setMainData(root,iterations,header,iterTable,precision,time,handles)
set(handles.mainRootLabel, 'string', root);
set(handles.mainIterationsLabel, 'string', iterations);
set(handles.mainPrecisionLabel, 'string', precision);
set(handles.mainTimeLabel, 'string', time);
buildTable(handles.mainTable,header, iterTable)

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(~, ~, handles)
global changedData;
changedData = true;
try
    selectedIndex = get(handles.popupmenu1, 'Value');
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
    errorMessage = sprintf('Error Message:\n%s', ...
        ME.stack(1).name, ME.stack(1).line, ME.message);
    fprintf(1, '%s\n', errorMessage);
    uiwait(errordlg(errorMessage));
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(~, ~, handles)
global changedData;
changedData = true;
try
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
catch
    errorMessage = sprintf('Error in reading the File, Make sure it follows the documentations');
    fprintf(1, '%s\n', errorMessage);
    uiwait(errordlg(errorMessage));
end
fclose(inputFile);


function funcBox_Callback(~, ~, ~)
global changedData;
changedData = true;


function funcBox_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function startBox_Callback(hObject, ~, ~)
global changedData;
changedData = true;
text = get(hObject, 'string');
if isempty(str2double(text))
    set(hObject,'string','0');
    errordlg('Input must be an numerical');
end

function startBox_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endBox_Callback(hObject, ~, ~)
global changedData;
changedData = true;
text = get(hObject, 'string');
if isempty(str2double(text))
    set(hObject,'string','0');
    errordlg('Input must be an numerical');
end

function endBox_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function buildTable(table,header, data)
set(table, 'columnname', header);
set(table, 'data', data);




function extraFuncBox_Callback(~, ~, ~)
global changedData;
changedData = true;


function extraFuncBox_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mainStartBox_Callback(~, ~, ~)
global changedData;
changedData = true;


% --- Executes during object creation, after setting all properties.
function mainStartBox_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function plot_Callback(~, ~, handles) %#ok<*DEFNU>
plotGraph(handles);

function plotGraph(handles)
global pIndex;
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
            plotNewtonRphason(handles);
        case 5
            plotSecant(handles);
        case 6
            errordlg('Cannot plot Birge-Vieta''s method!');
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


function drawFunction(handles)
global pF;
[x1, x2] = getPlotData(handles);
syms x y;
cla;
ezplot(pF, [x1, x2]);
hold on;
plot([x1, x2], [0 0], 'k-');
hold on;
%Large values are used for long vertical axis
plot([0, 0], [-500000 500000], 'k-');
hold on;

function [x1,x2] = getPlotData(handles)
x1 = str2double(get(handles.plotStartX, 'string'));
x2 = str2double(get(handles.plotEndX, 'string'));


function plotBisection(handles)
global pIter;
drawFunction(handles);
plot([pIter(5), pIter(5)], [-500000, 500000], '--');
hold on;
plot([pIter(1), pIter(1)], [-500000, 500000]);
hold on;
plot([pIter(3), pIter(3)], [-500000, 500000]);

function plotRegulaFalsi(handles)
global pF pIter;
drawFunction(handles);
syms x;
plot([pIter(1) pIter(2)], [eval(subs(pF, pIter(1))) eval(subs(pF, pIter(2)))]);
plot([pIter(3), pIter(3)], [-500000 500000], 'k-');
plot([pIter(1), pIter(1)], [-500000 500000], 'k-');
plot([pIter(2), pIter(2)], [-500000 500000], 'k-');

function plotFixedPoint(handles)
global pF pG pIter;
[x1, x2] = getPlotData(handles);
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
plot([0, 0], [0,500000]);
hold on;
plot([pIter(2), pIter(2)], [-500000 500000], 'k-');


function plotNewtonRphason (handles)
global pIter;
drawFunction(handles);
plot([pIter(1), pIter(1)], [-500000, 500000], 'g-');
m = pIter(3);
c = pIter(2) - m * pIter(1);
x1 = 500000;
y1 = m * x1 + c;
x2 = -500000;
y2 = m * x2 + c;
plot([x1, x2],[y1, y2], 'r-');
plot([pIter(4), pIter(4)], [-500000, 500000], 'y-');


function plotSecant(handles)
global pIter;
drawFunction(handles);
plot([pIter(1), pIter(1)], [-500000, 500000], 'g-');
plot([pIter(2), pIter(2)], [-500000, 500000], 'y-');
m = (pIter(4) - pIter(5))/(pIter(1) - pIter(2));
c = pIter(4) - m * pIter(1);
x1 = 500000;
y1 = m * x1 + c;
x2 = -500000;
y2 = m * x2 + c;
plot([x1, x2],[y1, y2], 'r-');
plot([pIter(3), pIter(3)],[-500000 500000],'m-');




% --- Executes on button press in funcPlotter.
function funcPlotter_Callback(~, ~, handles)
try
    f = get(handles.funcBox, 'string');
    a = str2double(get(handles.plotStartX, 'string'));
    b = str2double(get(handles.plotEndX, 'string'));
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



function plotStartX_Callback(hObject, ~, ~)
text = get(hObject, 'string');
all(ismember(text, '0123456789+-.eEdD'))
if ~all(ismember(text, '0123456789+-.eEdD'))
    set(hObject,'string','0');
    uiwait(errordlg('Input must be numerical'));
end


% --- Executes during object creation, after setting all properties.
function plotStartX_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function plotEndX_Callback(hObject, ~, ~)
text = get(hObject, 'string');
all(ismember(text, '0123456789+-.eEdD'))
if ~all(ismember(text, '0123456789+-.eEdD'))
    set(hObject,'string','0');
    uiwait(errordlg('Input must be numerical'));
end

% --- Executes during object creation, after setting all properties.
function plotEndX_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plotAll.
function plotAll_Callback(~, ~, handles)
warning('off','all');
try
    maxIterations = str2num(get(handles.itLabel, 'string'));
    eps = str2num(get(handles.percLabel, 'string'));
    inputFile = fopen('allinput.txt', 'r');
    [f, biA, biB, rfA, rfB, fpA, g, npA, secA, secB, bvA] = readData(inputFile);
    try
        [~,~,~,biiterTable] = bisection(f, biA, biB,maxIterations,eps);
    catch ME
        biiterTable = [0 0 0 0 0 0 0 0;];
        errorMessage = sprintf('Error in Plotting Bisection, Please recheck\n%s'...
            ,ME.message);
        fprintf(1, '%s\n', errorMessage);
        uiwait(errordlg(errorMessage));
    end
    try
        [~,~,~,rfiterTable] = regulafalsi(f,rfA, rfB, maxIterations,eps);
    catch ME
        rfiterTable = [0 0 0 0 0;];
        errorMessage = sprintf('Error in Plotting Regular Falsai, Please recheck\n%s'...
            ,ME.message);
        fprintf(1, '%s\n', errorMessage);
        uiwait(errordlg(errorMessage));
    end
    try
        [~,~,~,fpiterTable] = fixed_point( f,fpA,g, maxIterations, eps);
    catch ME
        fpiterTable = [0 0 0 0;];
        errorMessage = sprintf('Error in Plotting Fixed Point, Please recheck\n%s'...
            ,ME.message);
        fprintf(1, '%s\n', errorMessage);
        uiwait(errordlg(errorMessage));
    end
    try
        [~,~,~,npiterTable] = NewtonRaphson(f,npA,maxIterations,eps);
    catch ME
        npiterTable = [0 0 0 0 0;];
        errorMessage = sprintf('Error in Plotting Newton Raphson, Please recheck\n%s'...
            ,ME.message);
        fprintf(1, '%s\n', errorMessage);
        uiwait(errordlg(errorMessage));
    end
    try
        [~,~,~,seciterTable] = Secant(f,secA, secB,maxIterations,eps);
    catch
        seciterTable = [0 0 0 0 0 0;];
        errorMessage = sprintf('Error in Plotting Secant, Please recheck\n%s'...
            ,ME.message);
        fprintf(1, '%s\n', errorMessage);
        uiwait(errordlg(errorMessage));
    end
    try
        [~,~,~,bviterTable] = birgeVieta(f,bvA,maxIterations,eps);
    catch
        bviterTable = [0 0 0;];
        errorMessage = sprintf('Error in Plotting Birge Veta, Please recheck\n%s'...
            ,ME.message);
        fprintf(1, '%s\n', errorMessage);
        uiwait(errordlg(errorMessage));
    end
    try
        [a1,b1,errorOccur] = getInitialMain(handles,f);
        if errorOccur == true
           error('Could not find an initial guess for Illinois'); 
        end
        [~,~,~,illIterable] = Illinois(f,a1,b1,maxIterations,eps);
    catch
        illIterable = [0 0 0 0 0 0;];
        errorMessage = sprintf('Error in Plotting Illinois, Please recheck\n%s'...
            ,ME.message);
        fprintf(1, '%s\n', errorMessage);
        uiwait(errordlg(errorMessage));
    end
    biiterTable = biiterTable(1:size(biiterTable), 5:5);
    rfiterTable = rfiterTable(1:size(rfiterTable), 3:3);
    illIterable = illIterable(1:size(illIterable), 3:3);
    fpiterTable = fpiterTable(1:size(fpiterTable), 2:2);
    npiterTable = npiterTable(1:size(npiterTable), 4:4);
    seciterTable = seciterTable(1:size(seciterTable), 3:3);
    bviterTable = bviterTable(1:size(bviterTable), 2:2);
    plotAllIterations(biiterTable, rfiterTable, fpiterTable, npiterTable, seciterTable, bviterTable, illIterable, handles);
catch ME
    errorMessage = sprintf('Error in Plotting all methods, Please recheck\n%s', ...
        ME.message);
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

function plotAllIterations(biiterTable, rfiterTable, fpiterTable, npiterTable, seciterTable, bviterTable, illIterable, handles)
maxSize = max(size(biiterTable), size(rfiterTable));
maxSize1 = max(size(fpiterTable), size(npiterTable));
maxSize2 = max(size(seciterTable), size(bviterTable));
maxSize1 = max(maxSize1, maxSize2);
maxSize = max(maxSize1, maxSize);
maxSize = max(maxSize, size(illIterable));
[biiterTable] = fix(biiterTable, maxSize);
[rfiterTable] = fix(rfiterTable, maxSize);
[fpiterTable] = fix(fpiterTable, maxSize);
[npiterTable] = fix(npiterTable, maxSize);
[seciterTable] = fix(seciterTable, maxSize);
[bviterTable] = fix(bviterTable, maxSize);
[illIterable] = fix(illIterable, maxSize);
t = 1:maxSize;
c = horzcat(biiterTable, rfiterTable, fpiterTable, npiterTable, seciterTable, bviterTable, illIterable);
axes(handles.axes1);
cla reset;
plot(t, c);
legend('Bisection','False Position','Fixed Point','Newt. Raph.','Birge V.', 'Illinois');

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



function searchStart_Callback(hObject, ~, ~)
text = get(hObject, 'string');
all(ismember(text, '0123456789+-.eEdD'))
if ~all(ismember(text, '0123456789+-.eEdD'))
    set(hObject,'string','0');
    uiwait(errordlg('Input must be numerical'));
end

% --- Executes during object creation, after setting all properties.
function searchStart_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function searchDelta_Callback(hObject, ~, ~)
text = get(hObject, 'string');
all(ismember(text, '0123456789+-.eEdD'))
if ~all(ismember(text, '0123456789+-.eEdD'))
    set(hObject,'string','0');
    uiwait(errordlg('Input must be numerical'));
end

function searchDelta_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function searchTime_Callback(hObject, ~, ~)
text = get(hObject, 'string');
all(ismember(text, '0123456789+-.eEdD'))
if ~all(ismember(text, '0123456789+-.eEdD'))
    set(hObject,'string','0');
    uiwait(errordlg('Input must be numerical'));
end

function searchTime_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end