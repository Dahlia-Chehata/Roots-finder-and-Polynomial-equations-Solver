function [root,iterations,header, iterTable,precision, time] = NewtonRaphson(f,initVal,maxIterations, eps)
syms x;
deriv_f = diff(f, x);
iterTable = [];
old_x = initVal;
header = {'Xi' 'f(Xi)' 'f`(Xi)' 'X(i+1)' 'abs(ea)'};
tic;
abs_error = nan;
for i = 1 : maxIterations
    f_val = eval(subs(f, old_x));
    df_val = eval(subs(deriv_f, old_x));
    if (abs(df_val) == 0.0)
        error('the derivative equals zero');
    end
    new_x = old_x - (f_val / df_val);
    abs_error = abs((new_x - old_x));
    iterTable = [iterTable; [old_x,f_val, df_val, new_x, abs_error]];
    old_x = new_x;
    if(abs_error <= eps || eval(subs(f,new_x)) == 0.0)
        break;
    end
end
time = toc;
root = new_x;
iterations = i;
precision = eval(subs(f, root));
end