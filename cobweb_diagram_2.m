% part (d)

function [array_a] = cobwebDiagram(N, k, b, a_0, num)
    array_a = zeros(1, N);
    array_a(1) = a_0;
    for i = 2:N
        array_a(i) = array_a(i - 1) * (1 - k) + b;
    end
    figure(num)
    x = 0:0.02:b+3;
    y = x;
    plot(x, y)
    hold on
    y = (1-k) .* x + b;
    plot(x, y)
    for j = 1:N-1
        hold on
        plot([array_a(j) array_a(j)], [array_a(j) array_a(j + 1)])
        plot([array_a(j) array_a(j + 1)], [array_a(j + 1) array_a(j + 1)])    
    end
    xlim([0, b + 3])
    ylim([0, b + 3])
    xlabel("a_n")
    ylabel("a_{n+1}")
    title("Cobweb Diagram of Drug Prescription Model")
end

N = 200;
k = 0.5;
b = 1;
a_0 = 0;
array_a = cobwebDiagram(N, k, b, a_0, 1);

% part (e)
array_a;

% part (f)
N = 200;
k = 0.5;
b = 2;
a_0 = 0;
array_a = cobwebDiagram(N, k, b, a_0, 2);
b = 3;
array_a = cobwebDiagram(N, k, b, a_0, 3);