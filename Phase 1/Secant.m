function [root,iterations,header,IterTable,precision,time] = Secant(f,a, b,MaxIterations,eps)
tic;
x = zeros(1,MaxIterations);
x(1)=a;
x(2) = b;
IterTable=zeros(0,6);
header = {'x(i-1)' 'x(i)' 'x(i + 1)' 'F(x(i - 1))' 'F(x(i))' 'abs(ea)'};
for i=2:1:MaxIterations + 1
    fNew = eval(subs(f,x(i)));
    fOld = eval(subs(f,x(i - 1)));
    if(abs(fOld - fNew) <= eps)
        break;
        error('the denominator is equal to zero');
    else
        x(i+1) = x(i) - ((fNew * (x(i - 1) - x(i)))/(fOld - fNew));
        ea= (x(i+1)-x(i))/(x(i+1))*100;
        row=[x(i - 1),x(i),x(i + 1),fOld, fNew,abs(ea)];
        IterTable=[IterTable;row];
    end
    check=abs(double(eval(subs(f,x(i+1)))));
    if (check<=eps || abs(ea)<=eps)
        root=x(i+1);
        time = toc;
        break;
    end
end
time = toc;
iterations=i - 1;
bound = 'undefined';
precision=double(subs(f,root));
end