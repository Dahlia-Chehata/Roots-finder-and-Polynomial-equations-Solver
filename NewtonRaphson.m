function [root,iterations,IterTable,precision,time] = NewtonRaphson(f,initVal,MaxIterations,eps,es)
tic;
x = zeros(1,MaxIterations);
x(1)=initVal;
IterTable=zeros(0,5);
 for i=1:1:MaxIterations
      g=f;
      dF=diff(g);
      dFx=eval((subs((dF),x(i))));
    if (abs(dFx)<=eps)
        error('the derivative equals zero');
    else 
        Fx=double(subs(g,x(i)));
        x(i+1)=x(i)-(Fx/dFx);
        ea= (x(i+1)-x(i))/(x(i+1))*100;
        row=[x(i),Fx,dFx,x(i+1),abs(ea)];
        IterTable=[IterTable;row];
        check=double(subs(f,x(i+1)));
        if (check<=eps || abs(ea)<=es)
            root=x(i+1);
            time=toc;
            break;
        end
        g=dF;
    end 
 end
iterations=i;
precision=double(subs(f,root));
end

