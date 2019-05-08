function [result] = LUdecomposition(coeff, b, handles)
tic;
% coeff.result = b
% n the number of variables
% coeff = L.U

format long;
[n, ~] = size(coeff);

% indexing starts from 1

L = zeros(n, n);
U = coeff;
y = zeros(n, 1);
x = zeros(n, 1);
for i = 1:n
    %partial pivoting
    for j = i + 1 : n
        if U(i, i) == 0
            temp = U(1, :);
            U(1, :) = U(j, :);
            U(j, :) = temp;
            temp2 = b(1);
            b(1) = b(j);
            b(j) = temp2;
        end
    end
    
    % constructing L & U
    
    for j = 1:i
        l = U(i, j) / U(j, j);
        L(i, j) = l;
        if (i > j)
            for k = 1:n
                U(i, k) = U(i, k) - ( U(j, k) * l );
            end
        end
    end
end

% forward substitution
for i = 1:n
    sum = b(i);
    for j = (i-1) : -1 : 1
        sum = sum - ( y(j) * L(i, j) );
    end
    y(i) = sum / L(i, i);
end

% backward substitution
for i = n : -1 : 1
    sum = y(i);
    for j = n : -1 : (i+1) 
        sum = sum - ( x(j) * U(i, j) );
    end
    x(i) = sum / U(i, i);
end

result = x; 
set(handles.time,'String',toc);






        
    
