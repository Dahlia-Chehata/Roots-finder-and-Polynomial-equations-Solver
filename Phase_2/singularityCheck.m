function [error] = singularityCheck(a, b)
    error = false;
    sz = size(a, 1);
    augMatrix = zeros(0, sz + 1);
    for i = 1 : sz;
        for j = 1 : sz
            augMatrix(i, j) = a(i, j);
        end
        augMatrix(i, sz + 1) = b(i);
    end
    rnk = rank(a);
    rnkAug = rank(augMatrix);
    if (rnk ~= rnkAug) || (rnk ~= sz)
        error = true;
    end
end