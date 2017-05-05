function [a, ind, err] = decompose(a, tol)
    err = 0;
    n = size(a, 1);
    ind = zeros(n);
    scale = zeros(n);
    for i = 1 : n
        ind(i) = i;
        scale(i) = abs(a(i, 1));
        for j = 2 : n
            if(abs(a(i, j)) > scale(i))
                scale(i) = abs(a(i, j));
            end
        end
    end
    for k = 1 : n - 1
        ind = luPivot(a, scale, ind, n, k);
        if abs(a(ind(k), k) / scale(ind(k))) < tol
            err = -1;
            return;
        end
        for i = k + 1 : n
            factor = a(ind(i), k) / a(ind(k), k);
            a(ind(i), k) = factor;
            for j = k + 1 : n
                a(ind(i), j) = a(ind(i), j) - factor * a(ind(k), j);
            end
        end
    end
    if abs(a(ind(n), n)) / scale(ind(n)) < tol
        err = -1;
    end
end