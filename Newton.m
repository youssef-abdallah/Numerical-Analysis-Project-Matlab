function [ ea ] = Newton(x0, equationString, max, es, handles)
tic;
format long;
result(1) = x0;
equation = strcat('@(x)', equationString);
equ = str2func(equation);
df = diff(sym(equ));
d = matlabFunction(df);

x = [-10 10 10 -10];
fplot(equ,x);
hold on;
zoom on;
xx = -10:10;
yy = 0;
plot(xx,yy*ones(size(xx)), 'k');
hold on

%----Set Table Empty---
set(handles.table, 'Data', {})
%----------------------
max = max + 1;
for i = 2:max
    try
        dd = d(result(i-1));
    catch
        dd = double(coeffs(df));
    end
    result(i) = result(i-1) - ( equ(result(i-1)) / dd);
    ea(i-1) = abs(result(i) - result(i-1));
    %   xi, f(xi), xi+1,f'(xi), ea
    row = {result(i-1), equ(result(i-1)), result(i), equ(result(i)), ea(end)};
    oldData = get(handles.table,'Data');
    newData = [oldData; row];
    set(handles.table,'Data',newData)
    if(ea(end) < es)
        break;
    end
end
set(handles.answer, 'String' ,result(end));
set(handles.time,'String',toc);
end

