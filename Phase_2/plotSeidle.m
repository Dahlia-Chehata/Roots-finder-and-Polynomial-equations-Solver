function [] = plotSeidle(matrix)
    [rows, cols] = size(matrix);
    iteratins = [];
    for i = 1 : rows
        iterations(i) = i;
    end
    for i = 1 : cols
        x = [];
        for j = 1 : rows
            x(j) = matrix(j, i);
        end
        plot(x, iterations);
        hold on;
    end
end