% Speed-of-Approach Algorithm
function [x, y, z, w, v_y, v_z, v_w] = plot_speed_of_approach(K, dt, a_max, d_max, t, u, fig_num)
    [rows, cols] = size(t);
    x = zeros(1, cols);
    y = zeros(1, cols);
    z = zeros(1, cols);
    w = zeros(1, cols);
    v_y = zeros(1, cols);
    v_z = zeros(1, cols);
    v_w = zeros(1, cols);
    a_y = zeros(1, cols);
    a_z = zeros(1, cols);
    a_w = zeros(1, cols);
    x(1) = 120;
    y(1) = 80;
    z(1) = 40;
    w(1) = 0;
    v_y(1) = 10;
    v_z(1) = 5;
    v_w(1) = 0;
    
    for i = 1:cols-1
        x(i + 1) = x(i) + dt*((u(i) + u(i + 1)) / 2);
        % Acceleration for Cab B
        a_y(i) = K*(u(i) - v_y(i));
        if (a_y(i) > a_max)
            a_y(i) = a_max;
        elseif (a_y(i) < d_max)
            a_y(i) = d_max;
        end
        y(i + 1) = y(i) + dt*v_y(i) + 0.5*dt*dt*a_y(i);
        v_y(i + 1) = v_y(i) + dt*a_y(i);
        if (v_y(i + 1) < 0)
            v_y(i + 1) = 0;
        end
        % Collision has occurred
        if (x(i + 1) - y(i + 1) < 0.01)
            v_y(i + 1) = 0;
            y(i + 1) = y(i);
        end
        % Acceleration for Cab C
        a_z(i) = K*(v_y(i) - v_z(i));
        if (a_z(i) > a_max)
            a_z(i) = a_max;
        elseif (a_z(i) < d_max)
            a_z(i) = d_max;
        end
        z(i + 1) = z(i) + dt*v_z(i) + 0.5*dt*dt*a_z(i);
        v_z(i + 1) = v_z(i) + dt*a_z(i);
        if (v_z(i + 1) < 0)
            v_z(i + 1) = 0;
        end
        % Collision has occurred
        if (y(i + 1) - z(i + 1) < 0.01)
            v_z(i + 1) = 0;
            z(i + 1) = z(i);
        end
        % Acceleration for Cab D
        a_w(i) = K*(v_z(i) - v_w(i));
        if (a_w(i) > a_max)
            a_w(i) = a_max;
        elseif (a_w(i) < d_max)
            a_w(i) = d_max;
        end
        w(i + 1) = w(i) + dt*v_w(i) + 0.5*dt*dt*a_w(i);
        v_w(i + 1) = v_w(i) + dt*a_w(i);
        if (v_w(i + 1) < 0)
            v_w(i + 1) = 0;
        end
        % Collision has occurred
        if (z(i + 1) - w(i + 1) < 0.01)
            v_w(i + 1) = 0;
            w(i + 1) = w(i);
        end
    end

    figure(fig_num)
    plot(t, x - y)
    hold on
    plot(t, y - z)
    hold on
    plot(t, z - w)
    title("Distance Between Cabs Over Time")
    xlabel("Time (seconds)")
    ylabel("Distance (meters)")
    legend("A-B", "B-C", "C-D")
    
    figure(fig_num + 1)
    plot(t, v_y)
    hold on
    plot(t, v_z)
    hold on
    plot(t, v_w)
    title("Speed of Cabs B, C, & D Over Time")
    xlabel("Time (seconds)")
    ylabel("Speed (meters/second)")
    legend("B", "C", "D")
end

% Best performance
K = 0.27;
dt = 0.05;
a_max = 3;
d_max = -3;
t = 0:dt:200;
[rows, cols] = size(t);

% Test Case 1: Cab A at constant speed of 15 m/s
u1 = 15 * ones(1, cols);
[x1, y1, z1, w1, v_y1, v_z1, v_w1] = plot_speed_of_approach(K, dt, a_max, d_max, t, u1, 1);

% Test Case 2: Cab A moving at a constant speed and then apply 
% one-half the maximum deceleration until cab A has come to rest
u2 = 15 * ones(1, cols);
for i = 2:cols
    u2(i) = u2(i - 1) + 0.5*d_max*dt;
    if (u2(i) < 0)
        u2(i) = 0;
    end
end
[x2, y2, z2, w2, v_y2, v_z2, v_w2] = plot_speed_of_approach(K, dt, a_max, d_max, t, u2, 3);

% Test Case 3: Add a random component to the speed
u3 = 15 * ones(1, cols);
for i = 2:cols
    a_rand = -2 + (2 - (-2)) * rand();
    u3(i) = u3(i - 1) + a_rand*dt;
    if (u3(i) < 0)
        u3(i) = 0;
    end
end
[x3, y3, z3, w3, v_y3, v_z3, v_w3] = plot_speed_of_approach(K, dt, a_max, d_max, t, u3, 5);