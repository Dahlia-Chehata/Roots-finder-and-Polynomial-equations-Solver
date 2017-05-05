function [] = plot_iterations(matrix)
cla;
    [rows, cols] = size(matrix);
    iteratins = zeros(rows, 1);
    for i = 1 : rows
        iteratins(i) = i;
    end
    for i = 1 : cols
        if mod(i, 2) == 0
            continue;
        end
        x = zeros(rows, 1);
        for j = 1 : rows
            x(j) = matrix(j, i);
        end
        plot(iteratins, x);
        hold on;
    end
end