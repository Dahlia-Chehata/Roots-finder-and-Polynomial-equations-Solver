function [ root,iterations,header,IterTable,precision,bound,time ] = fixed_point( f,a,g, maxIterations, eps )
    tic;
    i = 0;
    xr = a;
    IterTable = zeros(0,4);
    iterations = 0;
    condition = true;
    header = {'x(i)' 'g(x(i))' 'x(i+1)' 'abs(ea)'};
    while(condition)
        xr_old = xr;
        xr = subs(g, 'x', xr_old);
        if(xr ~= 0)
        	ea = fabs((xr - xr_old) / xr) * 100;
        end
        iterations = iterations + 1;
        row=[xr_old,subs(g, 'x', xr_old),xr,abs(ea)];
        IterTable=[IterTable;row];
        condition = (ea < eps) && (iteration < maxIterations);
   end
   root = xr;
   precision=f(root);
   time=toc;
   iterations=i;
end