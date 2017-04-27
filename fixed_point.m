function [ root,iterations,header,IterTable,precision,time] = fixed_point( f,a,g, maxIterations, eps )
tic;
syms x;
i = 0;
xr = a;
IterTable = zeros(0,4);
iterations = 0;
condition = true;
header = {'x(i)' 'x(i+1) = g(x(i))' 'F(x(i + 1))' 'abs(ea)'};
while(condition)
    xr_old = xr;
    xr = eval(subs(g, xr_old));
    if(xr ~= 0)
        ea = abs((xr - xr_old) / xr) * 100;
    else
        ea = inf;
    end
    iterations = iterations + 1;
    row=[xr_old,xr,eval(subs(f,xr)),abs(ea)];
    IterTable=[IterTable;row];
    condition = (ea > eps) && (iterations < maxIterations);
end
root = xr;
precision=eval(subs(f, root));
time=toc;
bound = 'undefined';
end