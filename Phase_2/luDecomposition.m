function [x] = luDecomposition(a, b, n, x, tol, err)
    err = 0;
    scale = [];
    ind = [];
    [a, ind, scale, err] = decompose(a, scale, ind, n, tol, err);
    if err == -1
        return;
    end
    x = luSubstitute(a, b, ind, n, x);
end