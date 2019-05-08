function [x] =  Gauss_Elimination(a, b, n, tol,handles)
format long;
tic;
s = zeros(n, 1);
for i = 1 : n
    s(i) = abs(a(i,1));
    for j = 2 : n
        if (abs(a(i,j)) > s(i))
            s(i) = abs(a(i,j));
        end
    end
end

[er, a, b] = Eliminate(a, b, n, s, tol);
if (er ~= -1)
    x = Substitute(a, n, b);
else
    %print many solutions
end
set(handles.time,'String',toc);
end

function [er, a, b] =  Eliminate(a, b, n, s, tol)
er = 0;
for k = 1 : (n - 1)
    [a, b, s] = Pivot(a, b, n, s, k);
    if (abs(a(k,k) / s(k)) < tol)
        er = -1;
        return;
    end
    for i = k+1 : n
        factor = a(i,k)/a(k,k);
        for j = k : n
            a(i,j) = a(i,j) - factor * a(k,j);
        end
        b(i) = b(i) - factor * b (k);
    end
    if (abs(a(n,n) / s(n)) < tol)
        er = -1;
    end
end
end

function [x] = Substitute(a, n, b)
x(n) = b (n) / a(n,n);
for i = n-1 : -1: 1 
    sum = 0;
    for j = i+1 : n
        sum = sum + a(i,j) * x(j);
    end
    x(i) = (b(i) - sum )/a(i,i);
end
end

function [a,b,s] = Pivot(a, b, n, s, k)
p = k;
big = abs(a(k,k)/s(k));
for i = (k+1) : n
    dummy = abs(a(i,k)/s(i));
    if (dummy > big)
        big = dummy;
        p = i;
    end
end
if (p~=k)
    for j = k : n
        dummy = a(p,j);
        a(p,j) = a(k,j);
        a(k,j) = dummy;
    end
    
    dummy = b(p);
    b(p) = b(k);
    b(k) = dummy;
        
    dummy = s(p);
    s(p) = s(k);
    s(k) = dummy;
end
end