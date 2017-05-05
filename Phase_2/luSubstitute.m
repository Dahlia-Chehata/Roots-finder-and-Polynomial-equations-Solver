function [x] = luSubstitute(a, b, ind, n)
    d = [];
    d(ind(1)) = b(ind(1));
    for i = 2 : n
        sum = b(ind(i));
        for j = 1 : i - 1
            sum = sum - d(ind(j)) * a(ind(i), j);
        end
        d(ind(i)) = sum;
    end
    x(n) = d(ind(n)) / a(ind(n), n);
    i = n - 1;
    while i > 0
        sum = 0;
        for j = i + 1 : n
            sum = sum + a(ind(i), j) * x(j);
        end
        x(i) = (d(ind(i)) - sum) / a(ind(i), i);
        i = i - 1;
    end
end