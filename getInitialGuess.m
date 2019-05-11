function[low, high] = getInitialGuess(f, maxIterations)

h = 0.5;
iterations = 0;
x1 = 0; x2 = 0;
low = 0; high = 0;
first = false(1);
second = false(1);
while(iterations < maxIterations && ((~first) || (~second)))
    iterations = iterations + 1;
    if (iterations > maxIterations / 2)
        h = h * 10;
    end
    x1 = x1 + h;
    x2 = x2 - h;
    if (f(x1) > 0 && ~first)
        high = x1;
        first = true(1);
    elseif (f(x1) < 0 && ~second)
        low = x1;
        second = true(1);
    end
    if (f(x2) > 0 && ~first)
        high = x2;
        first = true(1);
    elseif(f(x2) < 0 && ~second)
        low = x2;
        second = true(1);
    end
end