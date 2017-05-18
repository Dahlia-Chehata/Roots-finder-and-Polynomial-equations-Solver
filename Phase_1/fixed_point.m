function [root,iterations,header,IterTable,precision,time,bound] = fixed_point( f,a,g, maxIterations, eps )
tic;
if(isempty(g))
    error('Extra function is required');
end
syms x;
xr = a;
IterTable = zeros(0,4);
iterations = 0;
condition = true;
header = {'x(i)' 'x(i+1) = g(x(i))' 'F(x(i + 1))' 'abs(ea)'};
ea = nan;
while(condition)
    xr_old = xr;
    xr = eval(subs(g, xr_old));
    ea = abs((xr - xr_old));
    iterations = iterations + 1;
    row=[xr_old,xr,eval(subs(f,xr)),ea];
    IterTable=[IterTable;row];
    condition = (ea > eps) && (iterations < maxIterations);
end
root = xr;
precision=eval(subs(f, root));
time=toc;
[trueRoot, good] = nearestRoot(f,a);
bound = '';
if good == 1
    if trueRoot - a ~= 0
        bound = abs((eval(subs(g,trueRoot)) - eval(subs(g,a)))/(trueRoot - a));
    end
end
end