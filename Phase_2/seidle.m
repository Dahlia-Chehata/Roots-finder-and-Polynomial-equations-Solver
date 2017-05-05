function [matrix] = seidle(a, b, x, iterations, eps)
sz = size(a, 1);
matrix = zeros(0, sz*2);
for i = 1 : sz
    matrix(1, 2 * i - 1) = x(i);
    matrix(1, 2 * i) = 0;
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
                sum = sum - a(var_x, i) * matrix(index, 2 * i - 1);
            end
        end
        if a(var_x, var_x) ~= 0
            matrix(iter, 2 * var_x - 1) = sum / a(var_x, var_x);
            matrix(iter, 2 * var_x) = abs((matrix(iter, 2 * var_x - 1) - matrix(iter - 1, 2 * var_x - 1)) / matrix(iter, 2 * var_x - 1));
        else
            errordlg('Division by zero');
        end
        if matrix(iter, 2 * var_x) > eps
            stop = 0;
        end
    end
    if stop == 1
        return;
    end
end
end