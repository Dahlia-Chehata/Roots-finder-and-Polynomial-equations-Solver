function [method_name, x, err] = gaussElemination(a, b, tol)
method_name = 'Gaussian-elimination';
n = size(a, 1);
scale = zeros(n);
for i = 1:n
    scale(i) = abs(a(i, 1));
    for j = 2 : n
        if(abs(a(i, j)) > scale(i))
            scale(i) = abs(a(i, j));
        end
    end
end
[a, b, err] = eleminate(a, b, scale, n, tol);
if(err == -1)
    return;
end
x = substitute(a, n, b);
end