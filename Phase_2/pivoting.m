function [a, b] = pivoting(a, b, eps)
    n = size(a, 1);
    for i = 1 : n
        if a(i, i) <= eps
            for j = 1 : n
                if ((i > j && abs(a(i, j)) > eps) || i < j)  && (abs(a(j, i)) > eps)
                    for k = 1 : n
                        temp = a(i, k);
                        a(i, k) = a(j, k);
                        a(j, k) = temp;
                    end
                    temp = b(i);
                    b(i) = b(j);
                    b(j) = temp;
                    break;
                end
            end
        end
    end
end