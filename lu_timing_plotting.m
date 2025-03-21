%% MATLAB Project: LU, tic and toc, plots

clc; clearvars;

% time both MATLAB's LU function and how long it takes 
% to solve a system using the factors

% [L,U,P] = lu(A)
% and
% x = U\(L\(P*b));
%
% where b is some random vector of the appropriate size. To get
% a random vector of length n, use
%
% b = randn(n,1);
%
% WARNING: randn(n) will give you a random nxn matrix.
%

ns = 2.^[5:12];
ts = zeros(size(ns));
ntrials = 5;
for i = 1:length(ns)
    start = tic;
    for j = 1:ntrials
        A = randn(ns(i));
        [L,U,P] = lu(A);
    end
    ts(i) = toc(start)/ntrials;
    fprintf('running lu test for %d by %d matrix, time taken = %d\n',ns(i),ns(i),ts(i))
end
figure(2)
clf;
loglog(ns,ts,'b-')
hold on
loglog(ns,ns.^3*ts(end)/ns(end)^3,'r--')
figure(3)
clf;
loglog(ns,ts,'b-')
hold on
loglog(ns,ns.^2*ts(end)/ns(end)^2,'r--')

ns = 2.^[5:12];
ts = zeros(size(ns));
ntrials = 5;
for i = 1:length(ns)
    A = randn(ns(i));
    [L,U,P] = lu(A);
    start = tic;
    for j = 1:ntrials
        b = randn(ns(i),1);
        x = U\(L\(P*b));
    end
    ts(i) = toc(start)/ntrials;
    fprintf('solving for x: %d by %d matrix, time taken = %d\n',ns(i),ns(i),ts(i))
end

% Plot n^3 and n^2 for comparison
figure(4)
clf;
loglog(ns,ts,'b-')
hold on
loglog(ns,ns.^3*ts(end)/ns(end)^3,'r--')
figure(5)
clf;
loglog(ns,ts,'b-')
hold on
loglog(ns,ns.^2*ts(end)/ns(end)^2,'r--')

%% make it pivot
%
% <include>luwpiv.m</include>
A = [2 1 1 0; 4 3 3 1; 8 7 9 5; 6 7 9 8];
[L, U, P] = luwpiv(A)
if P*A == L*U
    fprintf("P*A is equal to L*U\n")
else
    fprintf("Error: P*A is not equal to L*U\n")
end
[L_builtin, U_builtin, P_builtin] = lu(A);
if P_builtin*A == L_builtin*U_builtin
    fprintf("builtin: P*A is equal to L*U\n")
else
    fprintf("Error builtin: P*A is not equal to L*U\n")
end
if P == P_builtin
    fprintf("P matches\n")
    if L == L_builtin
        fprintf("L matches\n")
    end
    if U == U_builtin
        fprintf("U matches\n")
    end
else
    fprintf("Our permutation matrix is different from builtin solution")
end