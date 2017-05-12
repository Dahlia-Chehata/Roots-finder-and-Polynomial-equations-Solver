function [] = write_to_xls(filename, sheet, table)
    columns_are_numbered = strcmp(transform_to_array(get(table, 'columnname')), 'numbered');
    rows_are_numbered = strcmp(transform_to_array(get(table, 'RowName')), 'numbered');
    [columns_names] = transform_to_array(get(table, 'columnname'));
    rows_names = get(table, 'RowName');
    matrix = get(table, 'data');
    if (size(matrix) == zeros(1, 2))
        return;
    end
    success = true;
    if (rows_are_numbered)
        if (columns_are_numbered)
            success = success && xlswrite(filename, matrix, sheet);
        else
            success = success && xlswrite(filename, columns_names, sheet);
            success = success && xlswrite(filename, matrix, sheet, 'A2');
        end
    else
        if (columns_are_numbered)
            success = succes && xlswrite(filename, matrix, sheet);
            success = success && xlswrite(filename, rows_names, sheet, 'B1');
        else
            success = success && xlswrite(filename, rows_names, sheet, 'A2');
            success = success && xlswrite(filename, columns_names, sheet, 'B1');
            success = success && xlswrite(filename, matrix, sheet, 'B2');
        end
    end
    assert(success, 'Error writing to file');
 
    function [array] = transform_to_array(matrix)
        [rows_size, columns_size] = size(matrix);
        k = 1;
        for i = 1: rows_size
            for j = 1: columns_size
                array(k) = matrix(i, j);
                k = k + 1;
            end
        end
     
     
     