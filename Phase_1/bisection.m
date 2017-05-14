function [root,Iterations,header,IterTable,precision,time] = bisection(f, a, b, maxIterations,eps)
tic;
syms x;
IterTable = zeros(0,7);
xlow = min(a, b);
xup = max(a, b);
approx_root=zeros(0);
xlow_val = eval(subs(f,xlow));
xup_val = eval(subs(f,xup));
if (abs(xlow_val) == 0.0)
    xr = xlow;
    time=toc;
elseif (abs(xup_val) == 0.0)
    xr = xup;
    time=toc;
elseif (xlow_val * xup_val > 0 )
    error('eval f(a) and f(b) do not have opposite signs');
end
Iterations = maxIterations;
header = {'a' 'F(a)' 'b' 'F(b)' 'r(i)' 'F(r(i))' 'abs(ea)' 'bound'};
for i = 1:1:maxIterations
    approx_root(i) = (xlow + xup)/2;
    if (i~=1 && approx_root(i) ~= 0)
        ea=((approx_root(i)-approx_root(i-1))/approx_root(i))*100;
    else
        ea = 100;
    end
    xr_val = eval(subs(f,approx_root(i)));
    row=[xlow,xlow_val,xup,xup_val,approx_root(i),xr_val,abs(ea),(b - a)/(2^i)];
    IterTable=[IterTable;row];
    if (xr_val == 0.0)
        xr = approx_root(i);
        Iterations = i;
        break;
    elseif (xr_val*xlow_val < 0 )
        xup = approx_root(i);
        xup_val = xr_val;
    else
        xlow = approx_root(i);
        xlow_val = xr_val;
    end
    if abs(ea) <= eps
        xr = approx_root(i);
        Iterations = i;
        break;
    end
end
time = toc;
root=xr;
precision=eval(subs(f,xr));
end