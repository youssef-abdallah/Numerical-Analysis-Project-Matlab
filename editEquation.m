function [ newEquation ] = editEquation(Equation)
    temp = 1;
    newEquation = '';
    maxSize = max(size(Equation));
    for i = 1 : maxSize
        if (Equation(i:i)) == 'e'
            newEquation = strcat(newEquation, Equation(temp,(i - 1)));
            newEquation = strcat(newEquation, 'exp(');
            temp = i + 1;
            newEquation = strcat(newEquation, extractBetween(Equation,temp, max(size(Equation))));
            i = i + 1;
        end
    end