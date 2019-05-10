function decker(equation, eps, max, handles)
format long;
equ = strcat('@(x)',equation);
f = str2func(equ);
syms x;
temp = fzero(f, 0);
a = temp + 0.05;
b = temp - 0.05;
fa = f(a);
fb = f(b);
tic;
if sign(fa) == sign(fb) || isnan(temp)
      error('f(x) must change sign on the interval [a,b].');
end
c = a;
fc = fa;
i = 0;
m = (b + c) / 2;
set(handles.table, 'Data', {})
while i < max
    i = i + 1;
    if sign(fb) == sign(fc)
        c = a;
        fc = fa;
    end
    
    % A      B       C       M     Es
    row = {a, b, c, m, abs(b - c)};
    oldData = get(handles.table,'Data');
    newData = [oldData; row];
    set(handles.table,'Data',newData)
    
    if abs(b - c) < eps
        break;
    end
    if abs(fc) < abs(fb)
        a = b;
        fa = fb;
        b = c;
        fb = fc;
        c = a;
        fc = fa;
    end
    m = (b + c) / 2;
    if (fb - fc) ~= 0
        s = b - fb * (b - c) /(fb - fc);
    else
        s = m;
    end
    c = b;
    fc = fb;
    if (s > m && s < b) || (s > b && s < m)
        b = s;
        fb = f(s);
    else
        b = m;
        fb = f(m);
    end
end
set(handles.answer, 'String' ,b);
set(handles.time,'String',toc);
