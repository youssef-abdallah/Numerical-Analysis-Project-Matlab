function [ ea ] = Fixed_Point( x0,max,error,equationString , handles)
tic;
format long;
test = 0;
check = 0;
syms x;
% equation = strcat('@(x)', equationString);
% f = str2func(equation);
[coeff,types] = coeffs(eval(equationString));
[~,m] = size(coeff);
for k = 1 : m
    if (types(k) == x)
        check = 1;
        if (coeff(k) > 0)
            equa = strcat(equationString,'-x');
        else if (coeff(k) < 0)
                equa = strcat(equationString,'+x');
            end
        end
    end
end
if (check == 0)
    return;
end
equation2 = strcat('@(x)', equa);
g = str2func(equation2);
equation3 = strcat('@(x)', 'x');
y = str2func(equation3);
derivative = diff(eval(equa));
[coeff,~] = coeffs(derivative);
[~,m] = size(coeff);
if (m > 1) || (m == 1 && g(1) ~= double(coeffs(derivative)))
    der = matlabFunction(derivative);
    r = der(x0);
else
    r = double(coeffs(derivative));
end
if (abs(r) <= 1 && r > 0)
    set(handles.extra, 'String','converge');
    set(handles.extraInfo, 'String', strcat(num2str(abs(r)),'  converge, monotonic'));
else if (abs(r) <= 1 && r < 0)
    set(handles.extra, 'String','converge');
    set(handles.extraInfo, 'String', strcat(num2str(abs(r)),'  converge, oscillate'));
else if (abs(r) > 1 && r > 0)
    set(handles.extra, 'String','converge');
    set(handles.extraInfo, 'String', strcat(num2str(abs(r)),'  diverge, monotonic'));
else if (abs(r) < 1 && r < 0)
      set(handles.extra, 'String','converge');
    set(handles.extraInfo, 'String', strcat(num2str(abs(r)),'  diverge, oscillate'));
    end
    end
    end
end
xplot = [-10 10 10 -10];
fplot(g,xplot);
hold on;
fplot(y,xplot);
hold on;
zoom on;
xx = -10:10;
yy = 0;
plot(xx,yy*ones(size(xx)), 'k');
hold on

set(handles.table, 'Data', {})
max=max+1;
xi(1)=x0;
for i=2:max;
    xi(i)=g(xi(i-1));
    ea(i-1) =abs(xi(i)-xi(i-1));
    if g(xi(i)) == inf
        test = 1;
        break;
    end
     %   xi, g(xi), xi+1,g'(xi), ea
     row = {xi(i-1), g(xi(i-1)), xi(i), g(xi(i)), ea(end)};
    oldData = get(handles.table,'Data');
    newData = [oldData; row];
    set(handles.table,'Data',newData)
    if(ea(end) < error)
        break;
    end
end
if test == 1
    set(handles.answer, 'String' ,'Diverge');
else
    set(handles.answer, 'String' ,xi(end));
end
set(handles.time,'String',toc);
end
