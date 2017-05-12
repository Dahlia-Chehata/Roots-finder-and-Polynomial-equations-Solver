function [a, b, err] = eleminate(a, b, scale, n, tol)
    err = 0;
    for i = 1 : n - 1
        [a, b, scale] = pivot(a, b, scale, n, i);
        if (abs(a(i, i) / scale(i)) < tol)
            err = - 1;
            return;
        end
        for j = i + 1 : n
            factor = a(j, i) / a(i, i);
            for k = i : n
                a(j, k) = a(j, k) - factor * a(i, k);
            end
            b(j) = b(j) - factor * b(i);
        end
    end
    if (abs(a(n, n)) < tol)
        err = - 1;
    end
end