function [root,iterations, header,iterTable,precision,bound,time] = regulafalsi(f,a,b, maxIterations,eps)
iterTable = [];
bound = 0;
header = {'Xl' 'Xu' 'Xr' 'f(Xr)' 'eps'};
Xl = min(a, b);
Xu = max(a, b);
tic;
Xl_val = eval_func(f, Xl);
Xu_val = eval_func(f, Xu);
if Xl_val * Xu_val > 0.0
    error('Function has same sign at end points');
end
prev_Xr = nan;
Xr = 0;
relative_error = nan;
for i = 1 : maxIterations
    Xr = Xu - Xu_val * (Xu - Xl) / (Xu_val - Xl_val);
    Xr_val = eval_func(f, Xr);
    if i > 1
        relative_error = abs((Xr - prev_Xr) / Xr) * 100;
    end
    iterTable = [iterTable; [Xl Xu Xr Xr_val relative_error]];
    if Xr_val == 0.0
        break;
    elseif Xr_val * Xl_val < 0
        Xu = Xr;
        Xu_val = Xr_val;
    else
        Xl = Xr;
        Xl_val = Xr_val;
    end
    if i > 1 && abs(Xr - prev_Xr) < eps
        break;
    end
    prev_Xr = Xr;
end
time = toc;
root = Xr;
iterations = i;
precision = relative_error;
end

function [answer] =  eval_func(func, value)
answer = eval(subs(func, value));
end