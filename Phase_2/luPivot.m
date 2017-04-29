function [ind] = luPivot(a, scale, ind, n, k)
    piv = k;
    largest = abs(a(ind(k), k) / scale(ind(k)));
    for i = k + 1 : n
        temp = abs(a(ind(i), k) / scale(ind(i)));
        if(temp > largest)
            piv = i;
            largest = temp;
        end
    end
    temp = ind(k);
    ind(k) = ind(piv);
    ind(piv) = temp;
end