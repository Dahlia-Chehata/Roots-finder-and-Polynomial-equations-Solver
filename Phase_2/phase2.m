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
global used_gaussian_jordan;
global used_gauss_seidel;

used_gaussian_jordan = false;
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
reset_tables(handles);

global tolerance method input_equations bes used_gaussian_jordan used_gauss_seidel max_iterations epsillon initial_guesses;
total_time = tic;
if (method == 1 || method == 2)
    [header] = build_method_output_table_header();
    if (method == 1)
        start = tic;
        [~, ans_matrix, error_flag] = gaussElemination(input_equations, bes, tolerance);
        method_time = toc(start);
    else
        start = tic;
        [~, ans_matrix, error_flag] = luDecomposition(input_equations, bes, tolerance);
        method_time = toc(start);
    end
    if error_flag ~= -1
        set(handles.methods_output_table, 'data', ans_matrix);
        set(handles.methods_output_table, 'Columnname', header);
    end
    used_gaussian_jordan = false;
    used_gauss_seidel = false;
elseif(method == 3 || method == 4)
    [header] = build_iterative_output_table_header();
    
    if(method == 3)
        start = tic;
        % call of Jordan % <<=============================================
        method_time = toc(start);
        set(handles.gaussian_jordan_table, 'data', ans_matrix);
        set(handles.gaussian_jordan_table, 'Columnname', header);
        used_gaussian_jordan = true;
    else
        start = tic;
        [ans_matrix] = seidle(input_equations, bes, initial_guesses, max_iterations, epsillon);
        method_time = toc(start);
        set(handles.gauss_seidel_table, 'data', ans_matrix);
        set(handles.gauss_seidel_table, 'Columnname', header);
        used_gauss_seidel = true;
    end
elseif(method == 5)
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
global tolerance input_equations bes used_gaussian_jordan used_gauss_seidel max_iterations epsillon initial_guesses;

[header] = build_method_output_table_header();
header = [header; {'Execution Time'}];
%===================gaussElemination========
time = tic;
[method_name_1, temp_ans_matrix, error_flag] = gaussElemination(input_equations, bes, tolerance);
gauss_elemination_time = toc(time);
ans_matrix = [];
if (error_flag ~= -1)
    ans_matrix = [ans_matrix; temp_ans_matrix];
end
%===================luDecomposition========
time = tic;
[method_name_2, temp_ans_matrix, error_flag] = luDecomposition(input_equations, bes, tolerance);
lu_decomposition_time = toc(time);
if (error_flag ~= -1)
    ans_matrix = [ans_matrix; temp_ans_matrix];
end
%================Setting methods table=====================
res_table = handles.methods_output_table;
set(res_table, 'ColumnName', header);
set(res_table, 'RowName', {method_name_1, method_name_2});
set(res_table, 'data', [ans_matrix, [gauss_elemination_time; lu_decomposition_time]]);

[header] = build_iterative_output_table_header();
%====================gaussianJordan=======================
%time = tic;
% [ans_matrix] = call jordan;
%gaussian_jordan_time = toc(time);
%set(handles.gaussian_jordan_table, 'data', ans_matrix);
%set(handles.gaussian_jordan_table, 'Columnname', header);
%data = get(handles.gaussian_jordan_table, 'data');
%data = [data; [gaussian_jordan_time; size(ans_matrix, 1)]];
%set(handles.gaussian_jordan_table, 'data', data);

%====================seidle==============================
time = tic;
[ans_matrix] = seidle(input_equations, bes, initial_guesses, max_iterations, epsillon);
gauss_seidle_time = toc(time);
sz = size(ans_matrix, 1);
ans_matrix(sz + 1, 1) = gauss_seidle_time;
ans_matrix(sz + 2, 1) = sz;
set(handles.gauss_seidel_table, 'data', ans_matrix);
set(handles.gauss_seidel_table, 'ColumnName', header);
[rows] = build_iterative_table_rows_names(sz);
set(handles.gauss_seidel_table, 'RowName', rows);

used_gaussian_jordan = true;
used_gauss_seidel = true;


function [rows] = build_iterative_table_rows_names(sz)
rows = cell(sz+2, 1);
for i = 1 : sz
    rows{i} = sprintf('%d', i);
end
rows{sz + 1} = 'Execution Time';
rows{sz + 2} = 'Iterations';

function reset_tables(handles)
set(handles.gaussian_jordan_table,'data',[]);
set(handles.gauss_seidel_table,'data', []);
set(handles.methods_output_table,'data',[]);
set(handles.gauss_seidel_table,'RowName', 'numbered');
set(handles.gaussian_jordan_table,'RowName', 'numbered');
set(handles.methods_output_table,'RowName', 'numbered');
set(handles.gauss_seidel_table,'ColumnName', 'numbered');
set(handles.gaussian_jordan_table,'ColumnName', 'numbered');
set(handles.methods_output_table,'ColumnName', 'numbered');

function plot_gaussian_jordan_btn_Callback(~, ~, handles)
%global tolerance method input_equations bes used_gaussian_jordan max_iterations epsillon initial_guesses;
%if(used_gaussian_jordan == false)
%    temp = method;
%    method = 3;
%    solve_btn_Callback('dummy', 'dummy',handles);
%    method = temp;
%end
%axes(handles.plot_paper);
% [ans_matrix] = <<============= call jordan =============
%plot_iterations(ans_matrix);

function plot_gauss_seidel_btn_Callback(~, ~, handles)
global method input_equations bes used_gauss_seidel max_iterations epsillon initial_guesses;
if(used_gauss_seidel == false)
    temp = method;
    method = 4;
    solve_btn_Callback('dummy', 'dummy',handles);
    method = temp;
end
axes(handles.plot_paper);
[ans_matrix] = seidle(input_equations, bes, initial_guesses, max_iterations, epsillon);
plot_iterations(ans_matrix);




function read_file_btn_Callback(hObject, eventdata, handles)
