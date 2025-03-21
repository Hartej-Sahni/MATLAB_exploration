warning('off')

figure(1)
fplot(@(x) 0.25*x*sin(x), [0, 50])
title("Graph of y = (1/4)tsin(t)")

figure(2)
fplot(@(x) (50/19)*sin(1.9*x)*sin(0.1*x), [0, 50])
title("Graph of y = (50/19)sin(0.1t)sin(1.9t)")

figure(3)
y_prime = @(x) cos(2*x);
y = @(x) 0.5*sin(2*x);
fplot(y, y_prime)
title("Graph of y' vs y for 3c")
xlabel("y")
ylabel("y'")
figure(4)
y_prime = @(x) (0.25*sin(2*x))+((0.5)*x*cos(2*x));
y = @(x) 0.25*x*sin(2*x);
fplot(y, y_prime)
title("Graph of y' vs y for 3a")
xlabel("y")
ylabel("y'")
figure(5)
y = @(x) (50/19)*sin(0.1*x)*sin(1.9*x);
y_prime = @(x) 5*cos(1.9*x)*sin(0.1*x)+(5/19)*sin(1.9*x)*cos(0.1*x);
fplot(y, y_prime)
title("Graph of y' vs y for 3b")
xlabel("y")
ylabel("y'")