function [ea] = Bisection(xl,xu,maxIter,error,equationString, handles)
equation = strcat('@(x)', equationString);
tic;
format long;
f = str2func(equation);
if f(xl)*f(xu) >= 0
    set(handles.extraInfo, 'String', 'no bracket');
    return;
end
set(handles.table, 'Data', {})
maxIterations=maxIter;
i=0;
xr(1)=0;
set(handles.extra, 'String','MaxI');
MaxI = ceil((log10((xu - xl)) - log10(error)) / log10(2));
set(handles.extraInfo, 'String', int2str(MaxI));
x = [-10 10 10 -10];
fplot(f,x);
hold on;
zoom on;
xx = -10:10;
yy = 0;
plot(xx,yy*ones(size(xx)), 'k');
hold on

while(i~=maxIterations)
    i=i+1;
    xr(i+1)=(xl+xu)/2;
    ea(i) = abs(xr(i+1)-xr(i));
    % xl   xu   xr   er    f(xr)
    row = {xl,xu,xr(i+1),f(xr(i+1)),ea(end)};
    if (f(xr(end)) == 0)
        break;
    end
    if f(xu)*f(xr(i+1))<0
        xl=xr(i+1);
    else
        xu=xr(i+1);
    end

    oldData = get(handles.table,'Data');
    newData = [oldData; row];
    set(handles.table,'Data',newData)
    if (ea(end) < error)
        break;
    end

end
set(handles.answer, 'String' ,xr(end));
set(handles.time,'String',toc);
end

