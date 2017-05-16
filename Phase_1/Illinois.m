function [root,iterations,header,iterTable,precision,time] = Illinois(f,a,b,maxIterations, eps)
iterTable = [];
header = {'Xl' 'Xu' 'Xr' 'f(Xr)' 'abs(ea)'};
xlow = min(a, b);
xup = max(a, b);
tic;
side = 0;
xlow_val = eval_func(f, xlow);
xup_val = eval_func(f, xup);
if xlow_val * xup_val > 0.0
    error('Function has same sign at end points');
end
prev_root = nan;
xroot = 0;
abs_error = nan;
for i = 1 : maxIterations
    xroot = xup - xup_val * (xup - xlow) / (xup_val - xlow_val);
    xroot_val = eval_func(f, xroot);
    if i > 1
        abs_error = abs((xroot - prev_root));
    end
    iterTable = [iterTable; [xlow xup xroot xroot_val abs_error]];
    if xroot_val == 0.0
        break;
    elseif xroot_val * xlow_val < 0
        xlow = xroot;
        xlow_val = xroot_val;
		if side == 1
			xup_val = xup_val / 2.0;
		else
			side = 1;
		end
    else
        xup = xroot;
        xup_val = xroot_val;
		if side == -1
			xlow_val = xlow_val / 2.0;
		else
			side = -1;
		end
    end
    if i > 1 && abs_error < eps
        break;
    end
    prev_root = xroot;
end
time = toc;
root = xroot;
iterations = i;
precision = abs_error;
end

function [answer] =  eval_func(func, value)
answer = eval(subs(func, value));
end