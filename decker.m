function decker(equation, eps, max, handles)
format long;
equ = strcat('@(x)',equation);
f = str2func(equ);
[a, b] = getInitialGuess(f, max);
fa = f(a);
fb = f(b);
tic;
if sign(fa) == sign(fb)
      set(handles.extraInfo, 'String', 'no bracket');
      return;
end

x = [-10 10 10 -10];
fplot(f,x);
hold on;
zoom on;
xx = -10:10;
yy = 0;
plot(xx,yy*ones(size(xx)), 'k');
hold on

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
    
    if abs(b - a) < eps
        break;
    end
    if f(b) == 0
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
    if (fb - fa) ~= 0
        s = b - fb * (b - a) /(fb - fa);
    else
        s = m;
    end
    a = b;
    fa = fb;
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
