function [root,iterations,IterTable,precision,time] = regulafalsi(f,a,b,eps)
    
    tic;
    i = 0;
    fr = 1;
    IterTable = zeros(0,7);
    r=zeros(0);
    while(abs (fr) > eps)
        i=i+1;
         if (abs(f(a)-f(b))<=eps)
            iterations=i;
            root = 'Regula falsi can''t compute the root';
            return;
        end
        r(i) = a - ((f(a)*(b-a))/(f(b) - f(a)));
        if (i~=1)
            ea=((r(i)-r(i-1))/r(i))*100;
        else 
            ea=0;
        end  
           row=[a,f(a),b,f(b),r(i),f(r(i)),abs(ea)];
            IterTable=[IterTable;row];
        if(f(r(i))*f(a) > 0)
            b = r(i);
            fr = f(b);
            root = b;
        else
            a = r(i);
            fr = f(a);
            root = a;
        end
    end
   time=toc;
   iterations=i;
   precision=f(root);
end