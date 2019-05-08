function [result] = LUdecomposition(coeff, b, n)
% coeff.result = b
% n the number of variables
% coeff = L.U

format long;

% indexing starts from 1

L = zeros(n, n);
U = coeff;
y = zeros(n, 1);
x = zeros(n, 1);
for i = 1:n
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






        
    
