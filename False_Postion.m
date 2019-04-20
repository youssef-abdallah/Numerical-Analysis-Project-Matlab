function [ xr ] = False_Postion( xl , xu , max , es , equation , handles)
tic;
format long;
xr(1) = xl;
xr(2) = xu;
equations = strcat('@(x)',equation);
equ = str2func(equations);
%Need to Zoom
x = [-10 10 10 -10];
fplot(equ,x);
hold on
zoom on
xx = -10:10;
yy = 0;
plot(xx,yy*ones(size(xx)), 'k');
hold on
%----Set Table Empty---
set(handles.table, 'Data', {})
%----------------------
if (equ(xl) * equ(xu)) > 0
    disp('no bracket')
    return
end
max = max + 3;
for i = 3:max
    xr(i) = (((xl(end) * equ(xu(end))) - (xu(end) * equ(xl(end)))) / (equ(xu(end)) - equ(xl(end))));
    ea = abs (xr(i) - xr(i - 1));
    test= equ(xl(end)) * equ(xr(i));
    % Xl      Xu       Xr       F(Xr)     Es
    row = {xl(end), xu(end), xr(i), equ(xr(i)), ea};
    oldData = get(handles.table,'Data');
    newData = [oldData; row];
    set(handles.table,'Data',newData)
    if (test == 0) 
        break;
    end
    if (test < 0)
        xu = xr;
    else
        xl = xr;
    end
    if (ea < es)
        break;
    end
end

set(handles.answer, 'String' ,xr(end));
set(handles.time,'String',toc);
end

