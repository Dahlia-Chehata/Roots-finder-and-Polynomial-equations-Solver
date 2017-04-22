function [root,iterations,IterTable,precision,bound,time] = bisection(f, a, b, MaxIterations,eps)
    
    
    tic;
    IterTable = zeros(0,7);
    r=zeros(0);
    if ( abs (f(a)) <=eps)
	xr = a;
    time=toc;
    elseif ( abs(f(b)) <=eps)
	xr = b;
    time=toc;
    elseif ( f(a) * f(b) > 0 )
      error( 'f(a) and f(b) do not have opposite signs' );
    end
   
    for i = 1:MaxIterations
        r(i) = (a + b)/2;
        if (i~=1)
            ea=((r(i)-r(i-1))/r(i))*100;
        else 
            ea=0;
        end   
            row=[a,f(a),b,f(b),r(i),f(r(i)),abs(ea)];
            IterTable=[IterTable;row];
        if ( abs(f(r(i))) <=eps )
            xr = r(i);
            time=toc;
            break;
        elseif ( f(r)*f(a) < 0 )
            b = r(i);
        else
            a = r(i);
        end
    end
    root=xr;
    iterations=i;
    precision=f(xr);
    bound=(b-a)/(2^iterations);
end