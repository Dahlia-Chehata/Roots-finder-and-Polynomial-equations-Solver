function [method_name ,final_ans,iterations_matrix] = seidle(a, b, x, iterations, eps)
method_name = 'Gauss-Seidel';
sz = size(a, 1);
iterations_matrix = zeros(0, sz*2);
for i = 1 : sz
    iterations_matrix(1, 2 * i - 1) = x(i);
    iterations_matrix(1, 2 * i) = 0;
end
for iter = 2 : iterations
    stop = 1;
    for var_x = 1 : sz
        sum = b(var_x);
        for i = 1 : sz
            if i ~= var_x
                index = iter;
                if(var_x < i)
                    index = iter - 1;
                end
                sum = sum - a(var_x, i) * iterations_matrix(index, 2 * i - 1);
            end
        end
        if a(var_x, var_x) ~= 0
            iterations_matrix(iter, 2 * var_x - 1) = sum / a(var_x, var_x);
            iterations_matrix(iter, 2 * var_x) = abs((iterations_matrix(iter, 2 * var_x - 1) - iterations_matrix(iter - 1, 2 * var_x - 1)) / iterations_matrix(iter, 2 * var_x - 1));
        else
            errordlg('Division by zero');
        end
        if iterations_matrix(iter, 2 * var_x) > eps
            stop = 0;
        end
    end
    if stop == 1
        break;
    end
end
row_size = size(iterations_matrix, 2);
last_row_index = size(iterations_matrix, 1);
final_ans = zeros(1, row_size / 2);
for i = 1: row_size
    if(mod(i, 2) == 1)
        final_ans(ceil(i / 2)) = iterations_matrix(last_row_index, i);
    end
end
end