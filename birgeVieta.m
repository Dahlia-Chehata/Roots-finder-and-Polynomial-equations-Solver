function [root,iterations,header,IterTable,precision,bound ,time] = birgeVieta(polynomial,initVal,eps,MaxIterations)
 
 tic;
 x=zeros(MaxIterations,1);
 x(1)=initVal;
 coeff=sym2poly(polynomial);
 a=fliplr(coeff);
 order=size(a,2);
 check=true;
 cnt=1;
 IterTable = zeros(0,3);
 header = {'x' 'x(i+1)' 'abs(ea)'};
 while (check) 
     b=[];
     c=[];
     b(order)= a(order);
     c(order)= a(order);
     disp(order);
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
        ea=((x(cnt+1)-x(cnt))/x(cnt+1))*100;
    else
        ea=0;
    end
         row=[x(cnt),x(cnt+1),abs(ea)];
         IterTable=[IterTable;row];
         cnt=cnt+1;
         
 end
 root=x(cnt);
 iterations=cnt-1;
 precision=polyval(coeff,root);
end