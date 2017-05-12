function [] = write_to_xls(filename, sheet, table)
file_name = char(filename);
matrix = get(table, 'data');
columns_are_numbered = strcmp(cellstr(get(table, 'columnname')), 'numbered');
rows_are_numbered = strcmp(cellstr(get(table, 'RowName')), 'numbered');
[columns_names] = transpose(cellstr(get(table, 'columnname')));
rows_names = cellstr(get(table, 'RowName'));
if (size(matrix) == zeros(1, 2))
    return;
end
success = true;
if (rows_are_numbered)
    if (columns_are_numbered)
        success = success && xlswrite(file_name, matrix, sheet);
    else
        success = success && xlswrite(file_name, columns_names, sheet);
        success = success && xlswrite(file_name, matrix, sheet, 'A2');
    end
else
    if (columns_are_numbered)
        success = succes && xlswrite(file_name, matrix, sheet);
        success = success && xlswrite(file_name, rows_names, sheet, 'B1');
    else
        success = success && xlswrite(file_name, rows_names, sheet, 'A2');
        success = success && xlswrite(file_name, columns_names, sheet, 'B1');
        success = success && xlswrite(file_name, matrix, sheet, 'B2');
    end
end
assert(success, 'Error writing to file');