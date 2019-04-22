function [roots, iterationsCount, bVector, cVector] = birgeVieta(polynomial, initialGuess, maxIterations, eps )

    functionCoeff = sym2poly(sym(polynomial));
    x = initialGuess;
    done = false;
    i = 0;
    [~, m] = size(functionCoeff);
    a = functionCoeff;
    bVector = cell(maxIterations);
    cVector = cell(maxIterations);
    while(~done)
        i = i + 1;
        [fx, b] = syntheticDivision(a, m, x);
        a = b;
        bVector{i} = b;
        [fdx, c] = syntheticDivision(a, m - 1, x);
        cVector{i} = c;
        xNew = x - (fx / fdx);
        if abs(x - xNew) < eps || i > maxIterations
            done = true;
        end
        x = xNew;
        a = functionCoeff;
    end
    roots = x;
    iterationsCount = i;
end

function[fx, b] = syntheticDivision(a, m, r)
    b = a;
    for i = 2:m
        b(i) = (b(i - 1) * r) + a(i);
    end
    fx = b(m);
end
