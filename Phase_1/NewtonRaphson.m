function [root,iterations,header, iterTable,precision, time] = NewtonRaphson(f,initVal,maxIterations, eps)
syms x;
df = diff(f, x);
iterTable = [];
old_x = initVal;
header = {'Xi' 'f(Xi)' 'f`(Xi)' 'X(i+1)' 'eps'};
tic;
for i = 1 : maxIterations
    f_val = eval(subs(f, old_x));
    df_val = eval(subs(df, old_x));
    if (abs(df_val) == 0.0)
        error('the derivative equals zero');
    end
    new_x = old_x - (f_val / df_val);
    relative_error = abs((new_x - old_x) / new_x) * 100;
    iterTable = [iterTable; [old_x,f_val, df_val, new_x, relative_error]];
    old_x = new_x;
    if(relative_error <= eps || eval(subs(f,new_x)) <= eps)
        break;
    end
end
time = toc;
root = new_x;
iterations = i;
precision = eval(subs(f, root));
end