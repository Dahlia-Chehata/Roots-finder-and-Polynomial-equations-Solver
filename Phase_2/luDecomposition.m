function [method_name, x, err] = luDecomposition(a, b, tol)
method_name = 'LU Decomposition';
err = 0;
n = size(a, 1);
[a, ind, err] = decompose(a, tol);
if err == -1
    return;
end
x = luSubstitute(a, b, ind, n);
end