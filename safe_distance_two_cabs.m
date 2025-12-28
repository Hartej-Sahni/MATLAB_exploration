% Safe-Distance Algorithm
function [x, y, v, a, j] = plot_safe_distance(D, k, dt, a_max, d_max, t, u, fig_num)
   [rows, cols] = size(t);
   x = zeros(1, cols);
   y = zeros(1, cols);
   v = zeros(1, cols);
   a = zeros(1, cols);
   j = zeros(1, cols);
   x(1) = 40;
   y(1) = 0;
   v(1) = 10;
   
   for i = 1:cols-1
       x(i + 1) = x(i) + dt*((u(i) + u(i + 1)) / 2);
       a(i) = k*((x(i) - y(i)) - D);
       if (a(i) > a_max)
           a(i) = a_max;
       elseif (a(i) < d_max)
           a(i) = d_max;
       end
       if (i ~= 1)
           j(i) = (a(i) - a(i - 1)) / dt;
       end
       y(i + 1) = y(i) + dt*v(i) + 0.5*dt*dt*a(i);
       v(i + 1) = v(i) + dt*a(i);
       if (v(i + 1) < 0)
           v(i + 1) = 0;
       end
       % Collision has occurred
       if (x(i + 1) - y(i + 1) < 0.01)
           v(i + 1) = 0;
           y(i + 1) = y(i);
           break;
       end
   end

   figure(fig_num)
   plot(t, x - y)
   title("Distance Between Cabs Over Time")
   xlabel("Time (seconds)")
   ylabel("Distance (meters)")
  
   figure(fig_num + 1)
   plot(t, v)
   title("Speed of Cab B Over Time")
   xlabel("Time (seconds)")
   ylabel("Speed (meters/second)")
end

% Best performance
D = 30;
k = 0.04;
dt = 0.05;
a_max = 3;
d_max = -3;
t = 0:dt:200;
[rows, cols] = size(t);

% Test Case 1: Cab A at constant speed of 15 m/s
u1 = 15 * ones(1, cols);
[x1, y1, v1, a1, j1] = plot_safe_distance(D, k, dt, a_max, d_max, t, u1, 1);
x1 - y1;
u1;
v1;
a1;
j1;

% Test Case 2: Cab A moving at a constant speed and then apply
% one-half the maximum deceleration until cab A has come to rest
u2 = 15 * ones(1, cols);
for i = 2:cols
   u2(i) = u2(i - 1) + 0.5*d_max*dt;
   if (u2(i) < 0)
       u2(i) = 0;
   end
end
[x2, y2, v2, a2, j2] = plot_safe_distance(D, k, dt, a_max, d_max, t, u2, 3);
x2 - y2;
u2;
v2;
a2;
j2;

% Test Case 3: Add a random component to the speed
u3 = 15 * ones(1, cols);
for i = 2:cols
   a_rand = -2 + (2 - (-2)) * rand();
   u3(i) = u3(i - 1) + a_rand*dt;
   if (u3(i) < 0)
       u3(i) = 0;
   end
end
[x3, y3, v3, a3, j3] = plot_safe_distance(D, k, dt, a_max, d_max, t, u3, 5);
x3 - y3;
u3;
v3;
a3;
j3;

% Worst performance
D = 30;
k = 0.125;
dt = 0.4;
a_max = 3;
d_max = -3;
t = 0:dt:200;
[rows, cols] = size(t);

% Test Case 1: Cab A at constant speed of 15 m/s
u1 = 15 * ones(1, cols);
[x1, y1, v1, a1, j1] = plot_safe_distance(D, k, dt, a_max, d_max, t, u1, 7);
x1 - y1;
u1;
v1;
a1;
j1;

% Test Case 2: Cab A moving at a constant speed and then apply
% one-half the maximum deceleration until cab A has come to rest
u2 = 15 * ones(1, cols);
for i = 2:cols
   u2(i) = u2(i - 1) + 0.5*d_max*dt;
   if (u2(i) < 0)
       u2(i) = 0;
   end
end
[x2, y2, v2, a2, j2] = plot_safe_distance(D, k, dt, a_max, d_max, t, u2, 9);
x2 - y2;
u2;
v2;
a2;
j2;

% Test Case 3: Add a random component to the speed
u3 = 15 * ones(1, cols);
for i = 2:cols
   a_rand = -2 + (2 - (-2)) * rand();
   u3(i) = u3(i - 1) + a_rand*dt;
   if (u3(i) < 0)
       u3(i) = 0;
   end
end
[x3, y3, v3, a3, j3] = plot_safe_distance(D, k, dt, a_max, d_max, t, u3, 11);
x3 - y3;
u3;
v3;
a3;
j3;