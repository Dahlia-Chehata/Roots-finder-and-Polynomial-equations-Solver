function [root,iterations,header,iterTable,precision,time] = Illinois(f,a,b,maxIterations, eps)
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
xroot = 0;
relative_error = nan;
for i = 1 : maxIterations
    xroot = xup - xup_val * (xup - xlow) / (xup_val - xlow_val);
    xroot_val = eval_func(f, xroot);
    if i > 1 && xroot ~= 0.0
        relative_error = abs((xroot - prev_root) / xroot) * 100;
    end
    iterTable = [iterTable; [xlow xup xroot xroot_val relative_error]];
    if xroot_val == 0.0
        break;
    elseif xroot_val * xlow_val < 0
        xup = xlow;
        xup_val = xlow_val;
        xlow = xroot;
        xlow_val = xroot_val;
    else
        xlow = xroot;
        xlow_val = xroot_val;
        xup_val = xup_val / 2.0;
    end
    if i > 1 && relative_error < eps
        break;
    end
    prev_root = xroot;
end
time = toc;
root = xroot;
iterations = i;
precision = relative_error;
end

function [answer] =  eval_func(func, value)
answer = eval(subs(func, value));
end