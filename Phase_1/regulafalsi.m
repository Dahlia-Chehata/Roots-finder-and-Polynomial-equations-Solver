function [root,iterations,header,iterTable,precision,time] = regulafalsi(f,a,b, maxIterations,eps)
iterTable = [];
header = {'Xl' 'Xu' 'Xr' 'f(Xr)' 'eps'};
xlow = min(a, b);
xup = max(a, b);
tic;
xlow_val = eval_func(f, xlow);
xup_val = eval_func(f, xup);
if xlow_val * xup_val > 0.0
    error('Function has same sign at end points');
end
prev_root = nan;
aprox_root = 0;
relative_error = nan;
for i = 1 : maxIterations
    aprox_root = xup - xup_val * (xup - xlow) / (xup_val - xlow_val);
    Xroot_val = eval_func(f, aprox_root);
    if i > 1
        relative_error = abs((aprox_root - prev_root) / aprox_root) * 100;
    end
    iterTable = [iterTable; [xlow xup aprox_root Xroot_val relative_error]];
    if Xroot_val == 0.0
        break;
    elseif Xroot_val * xlow_val < 0
        xup = aprox_root;
        xup_val = Xroot_val;
    else
        xlow = aprox_root;
        xlow_val = Xroot_val;
    end
    if i > 1 && abs(aprox_root - prev_root) < eps
        break;
    end
    prev_root = aprox_root;
end
time = toc;
root = aprox_root;
iterations = i;
precision = relative_error;
end

function [answer] =  eval_func(func, value)
answer = eval(subs(func, value));
end