function x = gaussJordan(a, b)

%constructing the augmented matrix
[~, cols] = size(a);
a(:, cols + 1) = b;
[rows , cols] = size(a);
x = zeros(rows, 1);

for i = 1 : rows - 1
    %partial pivoting
    for j = i + 1 : rows
        if a(i, i) == 0
            temp = a(1, :);
            a(1, :) = a(j, :);
            a(j, :) = temp;
        end
    end
    %forward elimination
    for j = i + 1 : rows
        a(j, :) = a(j, :) - a(i, :) * (a(j, i) / a(i, i));
    end
end

%getting the unnormalized identity matrix
for i = rows: -1: 2
    for j = i - 1: -1 : 1
        a(j, :) = a(j, :) - a(i, :) * (a(j,  i) / a(i, i));
    end
end

%getting the actual identity matrix and the solution of the system
for i = 1 : rows
    a(i, :) = a(i, :) / a(i, i);
    x(i) = a(i, cols);
end
    
    
    
    