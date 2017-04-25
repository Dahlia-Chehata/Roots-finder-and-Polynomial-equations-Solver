function [root,Iterations,header,IterTable,precision,time] = bisection(f, a, b, maxIterations,eps)
tic;
syms x;
IterTable = zeros(0,7);
Xl = min(a, b);
Xu = max(a, b);
r=zeros(0);
if ( abs (eval(subs(f,Xl))) <=eps)
    xr = Xl;
    time=toc;
elseif ( abs(eval(subs(f,Xu))) <=eps)
    xr = Xu;
    time=toc;
elseif (eval(subs(f,Xl)) * eval(subs(f,Xu)) > 0 )
    error( 'eval f(a) and f(b) do not have opposite signs' );
end
Iterations = maxIterations;
header = {'a' 'F(a)' 'b' 'F(b)' 'r(i)' 'F(r(i))' 'abs(ea)' 'bound'};
for i = 1:1:maxIterations
    r(i) = (Xl + Xu)/2;
    if (i~=1)
        ea=((r(i)-r(i-1))/r(i))*100;
    else
        ea=0;
    end
    row=[Xl,eval(subs(f,Xl)),Xu,eval(subs(f,Xu)),r(i),eval(subs(f, r(i))),abs(ea),(b - a)/(2^i)];
    IterTable=[IterTable;row];
    if ( abs(eval(subs(f,r(i)))) <= eps)
        xr = r(i);
        time=toc;
        Iterations = i;
        break;
    elseif (eval(subs(f,r(i)))*eval(subs(f,Xl)) < 0 )
        Xu = r(i);
    else
        Xl = r(i);
    end
end
root=xr;
precision=eval(subs(f,xr));
end