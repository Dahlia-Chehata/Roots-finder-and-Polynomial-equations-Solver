function varargout = phase2(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @phase2_OpeningFcn, ...
    'gui_OutputFcn',  @phase2_OutputFcn, ...
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

function phase2_OpeningFcn(hObject, eventdata, handles, varargin)
global used_gauss_seidel;

used_gauss_seidel = false;
handles.output = hObject;
guidata(hObject, handles);

function varargout = phase2_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

function max_iterations_Callback(hObject, ~, ~)
global max_iterations;
number = str2double(get(hObject, 'string'));
if isempty(number) || floor(number) ~= number
    set(hObject, 'string', '50');
    errordlg('input must be an integer!');
    return;
end
max_iterations = floor(number);

function max_iterations_CreateFcn(hObject, ~, ~)
global max_iterations;
max_iterations = 50;
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function epsillon_Callback(hObject, ~, ~)
global epsillon;
number = str2double(get(hObject, 'string'));
if isempty(number)
    set(hObject, 'string', '0.00001');
    errordlg('input must be a real number!');
    return;
end
epsillon = number;

function epsillon_CreateFcn(hObject, ~, ~)
global epsillon;
epsillon = 0.00001;
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function tolerance_input_CreateFcn(hObject, eventdata, handles)
global tolerance;
tolerance = 0.00001;

function tolerance_input_Callback(hObject, eventdata, handles)
global tolerance;
number = str2double(get(hObject, 'string'));
if isempty(number)
    set(hObject, 'string', '0.00001');
    errordlg('input must be a real number!');
    return;
end
tolerance = number;

function methods_Callback(hObject, ~, ~)
global method;
method = get(hObject, 'Value');

function methods_CreateFcn(hObject, ~, ~)
global method;
method = 1;
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function equations_number_Callback(hObject, ~, handles)
global number_of_equations bes input_equations initial_guesses;
number = str2double(get(hObject, 'string'));
if isempty(number) || floor(number) ~= number || number < 2 || number > 100
    set(hObject, 'string', '2');
    errordlg('input must be an integer in the range [ 2 , 100 ]');
else
    number_of_equations = floor(number);
    input_equations = zeros(number_of_equations, number_of_equations);
    bes = zeros(1, number_of_equations);
    initial_guesses = zeros(1, number_of_equations);
    header = build_input_table_header(number_of_equations);
    set(handles.input_equations, 'columnname', header);
    set(handles.input_equations, 'data', zeros(number_of_equations, number_of_equations + 1));
    set(handles.input_equations,'ColumnEditable',true(1,number_of_equations + 1));
    set(handles.initial_guesses, 'columnname', header(1: number_of_equations));
    set(handles.initial_guesses, 'data', zeros(1, number_of_equations));
    set(handles.initial_guesses,'ColumnEditable',true(1,number_of_equations))
end

function [header] = build_input_table_header(n)
names = cell(n + 1 , 1);
for i = 1: n
    names{i} = sprintf('x%d' , i);
end
names{n + 1} = 'b';
header = names;

function equations_number_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function input_equations_CellEditCallback(~, eventdata, ~)
% hObject    handle to input_equations (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
global number_of_equations;
global input_equations;
global bes;
row_index = eventdata.Indices(1);
column_index = eventdata.Indices(2);
number = str2double(strcat(eventdata.EditData));
if(isempty(number))
    errordlog('input must be a real number');
elseif (column_index == number_of_equations + 1)
    bes(row_index) = number;
else
    input_equations(row_index, column_index) = number;
end

function initial_guesses_CellEditCallback(~, eventdata, ~)
% hObject    handle to initial_guesses (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
global initial_guesses;
number = str2double(strcat(eventdata.EditData));
if(isempty(number))
    errordlog('input must be a real number');
else
    row_index = eventdata.Indices(2);
    initial_guesses(row_index) = number;
end

function solve_btn_Callback(~, ~, handles)
reset_fields(handles);

global tolerance method input_equations bes used_gauss_seidel max_iterations epsillon initial_guesses;
method_time = 0;

if (method == 1 || method == 2 || method == 3)
    [header] = build_method_output_table_header();
    error_flag = 0;
    ans_matrix = [];
    method_time = 0;
    if (method == 1)
        start = tic;
        [~, ans_matrix, error_flag] = gaussElemination(input_equations, bes, tolerance);
        method_time = toc(start);
    elseif(method == 2);
        start = tic;
        [~, ans_matrix, error_flag] = luDecomposition(input_equations, bes, tolerance);
        method_time = toc(start);
    elseif(method == 3)
        start = tic;
        try
            [~, ans_matrix] = gaussJordan(input_equations, bes, tolerance);
        catch exception
            errordlg(exception.message);
            error_flag = -1;
        end
        method_time = toc(start);
    end
    if error_flag ~= -1
        set(handles.final_answer_table, 'data', ans_matrix);
        set(handles.final_answer_table, 'Columnname', header);
    end
    used_gauss_seidel = false;
    set(handles.number_of_iterations, 'string', 0);
elseif(method == 4)
    try
        [header] = build_iterative_output_table_header();
        start = tic;
        [~, final_ans, ans_matrix] = seidle(input_equations, bes, initial_guesses, max_iterations, epsillon);
        method_time = toc(start);
        set(handles.gauss_seidel_table, 'data', ans_matrix);
        set(handles.gauss_seidel_table, 'Columnname', header);
        [header] = build_method_output_table_header();
        set(handles.final_answer_table,'data', final_ans);
        set(handles.final_answer_table, 'Columnname', header);
        set(handles.number_of_iterations, 'string', size(ans_matrix, 1));
        used_gauss_seidel = true;
    catch exception
        errordlg(exception.message);
    end
elseif(method == 5)
    total_time = tic;
    solve_all_methods(handles);
    set(handles.execution_time, 'string', toc(total_time));
    return;
else
    errordlog('No such a method');
end
set(handles.execution_time, 'string', method_time);


function [header] =  build_method_output_table_header()
global number_of_equations;
header = cell(number_of_equations, 1);
for i = 1 : number_of_equations
    header{i} = sprintf('x%d', i);
end


function [header] =  build_iterative_output_table_header()
global number_of_equations;
n = number_of_equations * 2;
header = cell(n, 1);
for i = 1 : n
    if (mod(i, 2) == 1)
        header{i} = sprintf('x%d', ceil(i / 2));
    else
        header{i} = sprintf('err%d', i / 2);
    end
end

function solve_all_methods(handles)
global tolerance input_equations bes used_gauss_seidel max_iterations epsillon initial_guesses;
methods_names = [];
final_answers = [];
consumed_time = [];

%===================gaussElemination========
time = tic;
[temp_method_name, ans_matrix, error_flag] = gaussElemination(input_equations, bes, tolerance);
if (error_flag ~= -1)
    consumed_time =  [consumed_time; toc(time)];
    if(~strcmp(temp_method_name, ''))
        methods_names = strvcat(methods_names, temp_method_name);
    end
    final_answers = [final_answers; ans_matrix];
end
%===================luDecomposition========
time = tic;
[temp_method_name, ans_matrix, error_flag] = luDecomposition(input_equations, bes, tolerance);
if (error_flag ~= -1)
    consumed_time =  [consumed_time; toc(time)];
    if(~strcmp(temp_method_name, ''))
        methods_names = strvcat(methods_names, temp_method_name);
    end
    final_answers = [final_answers; ans_matrix];
end
%====================gaussianJordan=======================
time = tic;
try
[temp_method_name, ans_matrix] = gaussJordan(input_equations, bes, tolerance);
catch exception
    errordlg(exception.message);
    error_flag = -1;
end
if (error_flag ~= -1)
    consumed_time =  [consumed_time; toc(time)];
    if(~strcmp(temp_method_name, ''))
        methods_names = strvcat(methods_names, temp_method_name);
    end
    final_answers = [final_answers; ans_matrix];
end
%====================seidle==============================
try
    [header] = build_iterative_output_table_header();
    time = tic;
    [temp_method_name, ans_matrix,iterations_matrix] = seidle(input_equations, bes, initial_guesses, max_iterations, epsillon);
    methods_names = strvcat(methods_names, temp_method_name);
    consumed_time =  [consumed_time; toc(time)];
    final_answers = [final_answers; ans_matrix];
    set(handles.gauss_seidel_table, 'data', iterations_matrix);
    set(handles.gauss_seidel_table, 'ColumnName', header);
    set(handles.number_of_iterations, 'string', size(iterations_matrix, 1));
catch exception
    errordlg(exception.message);
end

%================Setting final answer table=====================
[header] = build_method_output_table_header();
header = [header; {'Execution Time'}];

set(handles.final_answer_table, 'ColumnName', header);
set(handles.final_answer_table, 'RowName', methods_names);
set(handles.final_answer_table, 'data', [final_answers, consumed_time]);

used_gauss_seidel = true;


function [rows] = build_iterative_table_rows_names(sz)
rows = cell(sz+2, 1);
for i = 1 : sz
    rows{i} = sprintf('%d', i);
end
rows{sz + 1} = 'Execution Time';
rows{sz + 2} = 'Iterations';

function reset_fields(handles)
axes(handles.plot_paper);
cla;
set(handles.number_of_iterations, 'string', 0);
set(handles.gauss_seidel_table,'data', []);
set(handles.final_answer_table,'data',[]);
set(handles.gauss_seidel_table,'RowName', 'numbered');
set(handles.final_answer_table,'RowName', 'numbered');
set(handles.gauss_seidel_table,'ColumnName', 'numbered');
set(handles.final_answer_table,'ColumnName', 'numbered');

function plot_btn_Callback(~, ~, handles)
global method input_equations bes used_gauss_seidel max_iterations epsillon initial_guesses;
if (used_gauss_seidel == false)
    set(handles.methods, 'Value', 4);
    temp = method;
    method = 4;
    solve_btn_Callback('dummy', 'dummy',handles);
    method = temp;
end
ans_matrix = [];
try
    ans_matrix = get(handles.gauss_seidel_table, 'data');
catch exception
    errordlg(exception.message);
end
axes(handles.plot_paper);
plot_iterations(ans_matrix);




function read_file_btn_Callback(~, ~, handles)
global number_of_equations bes input_equations initial_guesses;
[file_name, path_name] =  uigetfile('*.txt', 'inputfile');
path = strcat(path_name , file_name);
[number_of_equations ,input_equations, temp_bes, initial_guesses] = read(path);
set(handles.equations_number, 'string', number_of_equations);
augmented_matrix = [input_equations, temp_bes];
bes = transpose(temp_bes);
set(handles.input_equations, 'data', augmented_matrix);
set(handles.initial_guesses, 'data', initial_guesses);
set(handles.input_equations,'ColumnEditable',true(1,number_of_equations + 1));
set(handles.initial_guesses,'ColumnEditable',true(1,number_of_equations));



% --- Executes on button press in write_to_file_btn.
function write_to_file_btn_Callback(~, ~, handles)
try
    file_name = inputdlg('Enter space-separated numbers:',...
             'Sample', [1 89]);
    path = strcat(file_name , '.xls');
    write_to_xls( path, 1, handles.final_answer_table);
    write_to_xls( path, 2, handles.gauss_seidel_table);
catch exception
    errordlg(getReport(exception));
end