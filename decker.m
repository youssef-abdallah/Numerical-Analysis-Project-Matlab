function root = decker(f, eps, maxIterations)
[a, b] = getInitialGuess(f, maxIterations);
fa = f(a);
fb = f(b);
if sign(fa) == sign(fb)
      error('f(x) must change sign on the interval [a,b].');
end
c = a;
fc = fa;
i = 0;
while true
    i = i + 1;
    if sign(fb) == sign(fc)
        c = a;
        fc = fa;
    end
    if abs(b - a) < eps
        root = b;
        return
    end
    if abs(fc) < abs(fb)
        a = b;
        fa = fb;
        b = c;
        fb = fc;
        c = a;
        fc = fa;
    end
    m = (b + c) / 2;
    if (fb - fa) ~= 0
        s = b - fb * (b - a) /(fb - fa);
    else
        s = m;
    end
    a = b;
    fa = fb;
    if (s > m && s < b) || (s > b && s < m)
        b = s;
        fb = f(s);
    else
        b = m;
        fb = f(m);
    end
end

