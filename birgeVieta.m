function [max,err] = birgeVieta(polynomial, initialGuess, maxIterations, eps, handles)

    tic;
    try
        functionCoeff = sym2poly(sym(polynomial));
    catch
        max = 0;
        err =[];
        return;
    end
    x = initialGuess;
    
    equations = strcat('@(x)',polynomial);
    equ = str2func(equations);
    %Need to Zoom
    xplot = [-10 10 10 -10];
    fplot(equ,xplot);
    hold on
    xx = -10:10;
    yy = 0;
    plot(xx,yy*ones(size(xx)), 'k');
    hold on
    
    set(handles.table, 'Data', {'-','-','-',initialGuess,'-'})
    
    done = false;
    i = 0;
    [~, m] = size(functionCoeff);
    a = functionCoeff;
    while(~done)
        i = i + 1;
        [fx, b] = syntheticDivision(a, m, x);
        a = b;
        [fdx, c] = syntheticDivision(a, m - 1, x);
        max= length(functionCoeff);
        for z=1:max
        %A     B     C   Xi+1   Ea 
            if (z == max)
                row = {functionCoeff(z),b(z),'','' ,''};
            else
                row = {functionCoeff(z),b(z),c(z),'' ,''};
            end
            oldData = get(handles.table,'Data');
            newData = [oldData; row];
            set(handles.table,'Data',newData)
        end
        if fx ~= 0
            xNew = x - (fx / fdx);
        else
            xNew = x;
        end
        err(i)=abs(xNew - x);
        if  err(i) < eps || i > maxIterations
            done = true;
        end
        row = {'-','-','-',xNew,err(end)};
        oldData = get(handles.table,'Data');
        newData = [oldData; row];
        set(handles.table,'Data',newData)
        x = xNew;
        a = functionCoeff;
    end
    set(handles.answer, 'String' ,x(end));
    set(handles.time,'String',toc);
end

function[fx, b] = syntheticDivision(a, m, r)
    b = a;
    for i = 2:m
        b(i) = (b(i - 1) * r) + a(i);
    end
    fx = b(m);
end
