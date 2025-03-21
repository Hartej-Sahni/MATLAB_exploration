function [L,U,P] = luwpiv(A)
%LUWPIV LU decomposition with pivoting
[m,n] = size(A);
assert(m==n);
P = eye(n);
L = eye(n);
U = A;
for i = 1:(n-1)
    %find max index in ith column
    max = abs(U(i,i));
    max_index = i;
    for k = i+1:n
        if abs(U(k,i)) > max
            max = abs(U(k,i));
            max_index = k;
        end
    end
    %interchange ith and max row in matrix U
    temp = U(i,:);
    U(i,:) = U(max_index,:);
    U(max_index,:) = temp;
    %interchange ith and max row in matrix L
    temp = L(i, 1:i-1);
    L(i, 1:i-1) = L(max_index, 1:i-1);
    L(max_index, 1:i-1) = temp;
    %interchange ith and max row in matrix P
    temp = P(i,:);
    P(i,:) = P(max_index,:);
    P(max_index,:) = temp;
    for j = i+1:n
        L(j,i) = U(j,i)/U(i,i);
        U(j,i:n) = U(j,i:n)-L(j,i)*U(i,i:n);
    end
end
U = triu(U);
L = tril(L);