function [a, b, scale] = pivot(a, b, scale, n, k)
    piv = k;
    largest = abs(a(k, k) / scale(k));
    for i = k + 1 : n
        temp = abs(a(i, k) / scale(i));
        if temp > largest
            piv = i;
            largest = temp;
        end
    end
    for i = k : n
        temp = a(k, i);
        a(k, i) = a(piv, i);
        a(piv, i) = temp;
    end
    temp = b(k);
    b(k) = b(piv);
    b(piv) = temp;
    temp = scale(k);
    scale(k) = scale(piv);
    scale(piv) = temp;
end