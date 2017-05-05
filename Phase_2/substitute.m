function [x] = substitute(a, n, b)
    x(n) = b(n) / a(n, n);
    i = n - 1;
    while i > 0
        sum = 0;
        for j = i + 1 : n
            sum = sum + a(i, j) * x(j);
        end
        x(i) = (b(i) - sum) / a(i, i);
        i = i - 1;
    end
end