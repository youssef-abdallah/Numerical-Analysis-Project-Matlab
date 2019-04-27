function [ xi ] = Fixed_Point( x,max,error,equationString , handles)
tic;
format long;
equation = strcat('@(x)', equationString);
f = str2func(equation);
%g 
equa = strcat(equationString,'+x');
equation2 = strcat('@(x)', equa);
g = str2func(equation2);

equation3 = strcat('@(x)', 'x');
y = str2func(equation3);

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
xi(1)=x;
for i=2:max;
    xi(i)=g(xi(i-1));
    ea=abs(xi(i)-xi(i-1));
     %   xi, f(xi), xi+1,f'(xi), ea
    row = {xi(i-1), g(xi(i-1)), xi(i), g(xi(i)), ea};
    
    oldData = get(handles.table,'Data');
    newData = [oldData; row];
    set(handles.table,'Data',newData)
    if(ea < error)
        break;
    end
set(handles.answer, 'String' ,xi(end));
set(handles.time,'String',toc);
    
end

