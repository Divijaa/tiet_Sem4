%least cost method
%every balanced problem has feasible sol
%basic m+n-1
format short
clear all
clc


cost = [2 10 4 5 ;
        6 12 8 11 ;
        3 9 5 7];

A = [ 12 25 20];

B = [ 25 10 15 5];


if sum(A) == sum(B)
    fprintf('given transportation problem is balanced\n');
else
    fprintf('given transportation problem is not balanced\n');
    if sum(A) < sum(B)
 
        cost(end + 1,:) = zeros(1,size(cost,2));
        A(end+1) = sum(B) - sum(A);
    elseif sum (B) < sum(A)
      
        cost(:,end + 1) = zeros(size(cost,1),1);
        B(end+1) = sum(A) - sum(B);
    end
end

Icost = cost;

X = zeros(size(cost));

[m , n] = size(cost);
Bfs = m+n-1;


for i = 1: size(cost , 1)
    for j = 1:size(cost,2)
hh = min(cost(:));
[rowind , colind] = find(hh==cost)

 

x11 = min(A(rowind) , B(colind))

[val , ind] = max(x11);

ii = rowind(ind);
jj = colind(ind);

y11 = min(A(ii) , B(jj));

X(ii , jj) = y11;

A(ii) = A(ii) - y11;
B(jj) = B(jj) -y11;

cost(ii, jj) = Inf;
    end
end
%print inital bfs
fprintf('Intial bfs = \n')
ib = array2table(X);
disp(ib);


totalbfs = length(nonzeros(X));
if totalbfs == Bfs
    fprintf('intial bfs is non degenerate\n');
else
    fprintf('degenerate');
end

initialcost = sum(sum(Icost.*X));
fprintf('intial bfs cost %d\n' , initialcost);