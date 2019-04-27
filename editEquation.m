function [ newEquation ] = editEquation(Equation)
    temp = 1;
    tempE = 0;
    newEquation = '';
    maxSize = max(size(Equation));
    for i = 1 : maxSize
        if (Equation(i:i)) == 'e'
            str = Equation(temp :(i - 1));
            newEquation = strcat(newEquation, str);
            newEquation = strcat(newEquation, 'exp(');
            temp = i + 1;
            tempE = 1;
%             newEquation = strcat(newEquation, extractBetween(Equation,temp, max(size(Equation))));
%             i = i + 1;
        else if (tempE == 1)
                if (Equation(i:i)) == '+' || (Equation(i:i)) == '-' || (Equation(i:i)) == '*' || (Equation(i:i)) == '/' || (Equation(i:i)) == ' '
                    str = Equation((temp + 1) : (i - 1));
                    newEquation = strcat(newEquation, str);
                    temp = i;
                    tempE = 0;
                    newEquation = strcat(newEquation, ')');
                end
            end 
        end
    end
    str = Equation(temp : end);
    newEquation = strcat(newEquation, str);