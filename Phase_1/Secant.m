function [root,iterations,header,IterTable,precision,time] = Secant(f,a, b,MaxIterations,eps)
tic;
iter_value = zeros(1,MaxIterations);
iter_value(1)=a;
iter_value(2) = b;
IterTable=zeros(0,6);
header = {'x(i-1)' 'x(i)' 'x(i + 1)' 'F(x(i - 1))' 'F(x(i))' 'abs(ea)'};
ea = nan;
for i=2:1:MaxIterations + 1
    f_new = eval(subs(f,iter_value(i)));
    f_old = eval(subs(f,iter_value(i - 1)));
    if(abs(f_old - f_new) <= eps)
        break;
        error('the denominator is equal to zero');
    else
        iter_value(i+1) = iter_value(i) - ((f_new * (iter_value(i - 1) - iter_value(i)))/(f_old - f_new));
        ea = abs(iter_value(i+1)-iter_value(i));
        row =[iter_value(i - 1),iter_value(i),iter_value(i + 1),f_old, f_new,ea];
        IterTable = [IterTable;row];
    end
    check=abs(double(eval(subs(f,iter_value(i+1)))));
    root=iter_value(i+1);
    if (check<=eps || abs(ea)<=eps)
        time = toc;
        break;
    end
end
time = toc;
iterations=i - 1;
bound = 'undefined';
precision=double(subs(f,root));
end