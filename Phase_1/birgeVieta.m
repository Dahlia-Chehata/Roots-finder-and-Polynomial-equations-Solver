function [root,iterations,header,IterTable,precision,time,bound] = birgeVieta(polynomial,initVal,MaxIterations,eps)
tic;
x=zeros(MaxIterations,1);
bound = '';
x(1)=initVal;
coeff=sym2poly(sym(polynomial));
a=fliplr(coeff);
order=size(a,2);
check=true;
cnt=1;
IterTable = zeros(0,3);
header = {'x' 'x(i+1)' 'abs(ea)'};
ea = nan;
while (check)
    b=[];
    c=[];
    b(order)= a(order);
    c(order)= a(order);
    for i=order-1:-1:1
        b(i)= a(i)+x(cnt)*b(i+1);
        if i > 1
            c(i)=b(i)+x(cnt)*c(i+1);
        end
    end
    x(cnt+1)=x(cnt)-(b(1)/c(2));
    if abs(b(1)) <= eps
        time=toc;
        check=false;
    end
    if(cnt>1)
        ea=abs(x(cnt+1)-x(cnt));
    end
    row=[x(cnt),x(cnt+1),ea];
    IterTable=[IterTable;row];
    if(cnt == MaxIterations)
        break;
    end
    cnt=cnt+1;
end
root=x(cnt);
iterations=cnt-1;
time = toc;
precision=polyval(coeff,root);
end