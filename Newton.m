function [ result ] = Newton(x0, equationString, max, es, handles)
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
    result(i) = result(i-1) - ( equ(result(i-1)) / d(result(i-1)));
    ea = abs(result(i) - result(i-1));
    %   xi, f(xi), xi+1,f'(xi), ea
    row = {result(i-1), equ(result(i-1)), result(i), d(result(i-1)), ea};
    
    oldData = get(handles.table,'Data');
    newData = [oldData; row];
    set(handles.table,'Data',newData)
    if(ea < es)
        break;
    end
set(handles.answer, 'String' ,result(end));
set(handles.time,'String',toc);
end


