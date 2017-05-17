function [ordered, orderedB, err] = reOrder(unOrdered, b)
     n = size(unOrdered, 1);
    orderdB = [];
    taken = [];
    orderd = zeros(0, n * 2);
    err = 0;
    for i = 1:n
        taken(i) = 0;
        orderdB(i) = 0;
    end
    for i = 1:n
        maxIndex = 1;
        maxElement = abs(unOrdered(i, 1));
        for j = 1:n
            if abs(unOrdered(i, j)) >= maxElement
                maxIndex = j;
                maxElement = abs(unOrdered(i, j));
            end
        end
        if taken(maxIndex) == 1
            err = 1;
            orderedB = b(1:end);
            ordered = unOrdered(1:end, 1:end);
            return;
        end
        taken(maxIndex) = 1;
        for j = 1:n
            ordered(maxIndex, j) = unOrdered(i, j);
        end
        orderedB(maxIndex) = b(i);
    end
end