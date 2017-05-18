function [root,iterations,header,iterTable,precision,time,bound] = regulafalsi(f,a,b, maxIterations,eps)
iterTable = [];
header = {'Xl' 'Xu' 'Xr' 'f(Xr)' 'abs(ea)'};
xlow = min(a, b);
xup = max(a, b);
bound = '';
tic;
xlow_val = eval_func(f, xlow);
xup_val = eval_func(f, xup);
if xlow_val * xup_val > 0.0
    error('Function has same sign at end points');
end
prev_root = nan;
aprox_root = 0;
abs_error = nan;
for i = 1 : maxIterations
    aprox_root = xup - xup_val * (xup - xlow) / (xup_val - xlow_val);
    Xroot_val = eval_func(f, aprox_root);
    if i ~= 1
        abs_error = abs((aprox_root - prev_root));
    end
    iterTable = [iterTable; [xlow xup aprox_root Xroot_val abs_error]];
    if Xroot_val == 0.0
        break;
    elseif Xroot_val * xlow_val < 0
        xup = aprox_root;
        xup_val = Xroot_val;
    else
        xlow = aprox_root;
        xlow_val = Xroot_val;
    end
    if i > 1 && abs_error < eps
        break;
    end
    prev_root = aprox_root;
end
time = toc;
root = aprox_root;
iterations = i;
precision = eval_func(f,root);
end

function [answer] =  eval_func(func, value)
answer = eval(subs(func, value));
end