% Question 1

r = 1.5;
generations = 0:199;
pop_sizes = zeros(1, 200);
pop_sizes(1) = 0.2;
for i = 2:200
    pop_sizes(i) = r * pop_sizes(i - 1) * (1 - pop_sizes(i - 1));
end
figure(1)
plot(generations, pop_sizes)
xlabel("generation #")
ylabel("population size")
title("Population Size of Species for 200 Generations when r = 1.5")

r = 3.2;
generations = 0:199;
pop_sizes = zeros(1, 200);
pop_sizes(1) = 0.2;
for i = 2:200
    pop_sizes(i) = r * pop_sizes(i - 1) * (1 - pop_sizes(i - 1));
end
figure(2)
plot(generations, pop_sizes)
xlabel("generation #")
ylabel("population size")
title("Population Size of Species for 200 Generations when r = 3.2")

r = 4;
generations = 0:199;
pop_sizes = zeros(1, 200);
pop_sizes(1) = 0.2;
for i = 2:200
    pop_sizes(i) = r * pop_sizes(i - 1) * (1 - pop_sizes(i - 1));
end
figure(3)
plot(generations, pop_sizes)
xlabel("generation #")
ylabel("population size")
title("Population Size of Species for 200 Generations when r = 4")

% Question 3

function [] = cobwebDiagram(N, r, x_0, num)
    array_x = zeros(1, N);
    array_x(1) = x_0;
    for i = 2:N
        array_x(i) = r * array_x(i - 1) * (1 - array_x(i - 1));
    end
    figure(num)
    subplot(2, 1, 1)
    generations = 0:N-1;
    set(gcf, 'Position', [50, 50, 1000, 1000]);
    plot(generations, array_x)
    xlabel("n")
    ylabel("x_{n}")
    title("Population Size by Generation")
    subplot(2, 1, 2);
    x = 0:0.02:1;
    y = x;
    plot(x, y)
    hold on
    y = r .* x .* (1-x);
    plot(x, y)
    for j = 1:N-1
        hold on
        plot([array_x(j) array_x(j)], [array_x(j) array_x(j + 1)])
        plot([array_x(j) array_x(j + 1)], [array_x(j + 1) array_x(j + 1)])    
    end
    xlim([0, 1])
    ylim([0, 1])
    xlabel("x_n")
    ylabel("x_{n+1}")
    
end

N = 200;

% part (a)
r = 0.5;
x_0 = 0.5;
cobwebDiagram(N, r, x_0, 4);
title("Cobweb Diagram for Population Decreasing and Eventually Going Extinct")

% part (b)
r = 2.5;
x_0 = 0.5;
cobwebDiagram(N, r, x_0, 5);
title("Cobweb Diagram for Population Reaching a Nonzero Steady State")

% part (c)
r = 3.2;
x_0 = 0.5;
cobwebDiagram(N, r, x_0, 6);
title("Cobweb Diagram for Population Oscillating Between Two Values")

% part (d)
r = 3.54;
x_0 = 0.5;
cobwebDiagram(N, r, x_0, 7);
title("Cobweb Diagram for Population Oscillating Between Four Values")

% part (e)
r = 3.56;
x_0 = 0.5;
cobwebDiagram(N, r, x_0, 8);
title("Cobweb Diagram for Population Oscillating Between Eight Values")

% part (f)
r = 3.8;
x_0 = 0.5;
cobwebDiagram(N, r, x_0, 9);
title("Cobweb Diagram for Population Exhibiting Chaotic Behavior")