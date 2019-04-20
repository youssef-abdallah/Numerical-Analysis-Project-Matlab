function [ result ] = Secant(x0 ,x1 , equation, max, es, handles)
tic;
format long;
result(1) = x0;
result(2) = x1;
equations = strcat('@(x)',equation);
equ = str2func(equations);
%Need to Zoom
x = [-10 10 10 -10];
fplot(equ,x);
hold on
xx = -10:10;
yy = 0;
plot(xx,yy*ones(size(xx)), 'k');
hold on
%----Set Table Empty---
set(handles.table, 'Data', {})
%----------------------
max = max + 3;
for i = 3:max
    if((equ(result(i - 2)) - equ(result(i - 1)))== 0)
        fprintf('Error');
        break;
    end 
    result(i) = result(i - 1) - ((equ(result(i - 1)) * ((result(i - 2) - result(i - 1)))) / (equ(result(i - 2)) - equ(result(i - 1))));
    ea = abs (result(i) - result(i - 1));
    % Xi-1      Xi       Xi+1       F(Xi+1)     Es
    row = {result(i - 2), result(i - 1), result(i), equ(result(i)), ea};
    oldData = get(handles.table,'Data');
    newData = [oldData; row];
    set(handles.table,'Data',newData)
    if(ea < es)
        break;
    end
end
set(handles.answer, 'String' ,result(end));
set(handles.time,'String',toc);
end

