%every balanced problem has feasible sol
%basic m+n-1
format short
clear all
clc

%obtain the intital bfs
cost = [3 11 4 14 15;
        6 16 18 2 28 ;
        10 13 15 19 17;
        7 12 5 8 9];
%supply 
A = [ 15 25 10 15];
%demad
B = [20 10 15 15 5];

%check if balanced or not
if sum(A) == sum(B)
    fprintf('given transportation problem is balanced\n');
else
    fprintf('given transportation problem is not balanced\n');
    if sum(A) < sum(B)
        %ek row add krenge
        cost(end + 1,:) = zeros(1,size(cost,2));
        A(end+1) = sum(B) - sum(A);
    elseif sum (B) < sum(A)
        %column add krenge
        cost(:,end + 1) = zeros(size(cost,1),1);
        B(end+1) = sum(A) - sum(B);
    end
end

Icost = cost;
%initial allocation
X = zeros(size(cost));
%finding no of rows and cols
[m , n] = size(cost);
Bfs = m+n-1;

%finding the cell with min cost
for i = 1: size(cost , 1)
    for j = 1:size(cost,2)
hh = min(cost(:));
[rowind , colind] = find(hh==cost);

%to give allocations 

x11 = min(A(rowind) , B(colind));
%find max allocation
[val , ind] = max(x11);
%identify the row and col position
ii = rowind(ind);
jj = colind(ind);

y11 = min(A(ii) , B(jj));
%assign allocation
X(ii , jj) = y11;
%reducing the values
A(ii) = A(ii) - y11;
B(jj) = B(jj) -y11;

cost(ii, jj) = Inf;
    end
end
%print inital bfs
fprintf('Intial bfs = \n')
ib = array2table(X);
disp(ib);

%check for degenerate
totalbfs = length(nonzeros(X));
if totalbfs == Bfs
    fprintf('intial bfs is non degenerate\n');
else
    fprintf('degenerate');
end
%computing the cost
initialcost = sum(sum(Icost.*X));
fprintf('intial bfs cost %d\n' , initialcost);