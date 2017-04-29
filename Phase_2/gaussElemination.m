function [x] = gaussElemination(a, b, n, x, tol, err)
    scale = [];
    for i = 1:n
        scale(i) = abs(a(i, 1));
        for j = 2 : n
            if(abs(a(i, j)) > scale(i))
                scale(i) = abs(a(i, j));
            end
        end
    end
    [a, b, err] = eleminate(a, b, scale, n, x, tol, err);
    if(err == -1)
        return;
    end
    x = substitute(a, n, b, x);
end