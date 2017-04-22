function [root,Iterations,IterTable,precision,bound,time] = bisection(f, a, b, MaxIterations,eps)
    tic;
    IterTable = zeros(0,7);
    r=zeros(0);
    if ( abs (subs(f,'x',a)) <=eps)
	xr = a;
    time=toc;
    elseif ( abs(subs(f,'x',b)) <=eps)
	xr = b;
    time=toc;
    elseif (subs(f,'x',a) * subs(f,'x',b) > 0 )
      error( 'eval f(a) and f(b) do not have opposite signs' );
    end
    Iterations = MaxIterations;
    for i = 1:1:MaxIterations
        r(i) = (a + b)/2;
        if (i~=1)
            ea=((r(i)-r(i-1))/r(i))*100;
        else 
            ea=0;
        end   
            row=[a,subs(f,'x',a),b,subs(f,'x',b),r(i),subs(f, 'x', r(i)),abs(ea)];
            IterTable=[IterTable;row];
        if ( abs(subs(f, 'x',r(i))) <=eps )
            xr = r(i);
            time=toc;
            Iterations = i + 1;
            break;
        elseif (subs(f, 'x',r(i))*subs(f,'x',a) < 0 )
            b = r(i);
        else
            a = r(i);
        end
    end
    root=xr;
    precision=subs(f, 'x',xr);
    bound=(b-a)/(2^Iterations);
end