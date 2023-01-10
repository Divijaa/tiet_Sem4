clear all
clc 
format short
%taking input
%the z function sholud be max always
c = [12 10 0 0 0 0]
%the info matrix with identity matrix and sol col included
A = [-5 -1 1 0 0 -10; 
     -6 -5 0 1 0 -30;
     -1 -4 0 0 1 -8]
%index of starting basic variables
noofvar = 2
%bv = [3,4,5]
bv = noofvar+1:1:size(A,2)-1
cost = zeros(1, size(A,2));
cost(1:6) = c

zjcj = cost(bv)*A - cost
zcj = [zjcj;A]

%taking end wala col of A matrix
soln = A(:,end)

run = true
while(run == true)

    %because feasibilty disturb hoti toh sol col dekhenge
    %most negative choose krna
    if(any(soln<0))
        %finding the index of all the negative values in sol col
    negIND = find(soln<0)

    %finding leaving variable
    [leaving_var, pivot_row] = min(soln(negIND))

    ratio = []
    for i = 1:size(A,2)-1
        %z row mei se negative enteries ki ratio leni hai
        if A(pivot_row,i) <0
            ratio(i) = abs(zjcj(i)/A(pivot_row,i))
        else
            ratio(i) = inf;
        end
    end
    %row ki jgha col lena yaha
    [entering_var, pivot_col] = min(ratio)

    %updation of pivot key
    pvt_key = A(pivot_row, pivot_col)

    %updating basic variable
    bv(pivot_row) = pivot_col;

    %updation of pivot row
    A(pivot_row,:) = A(pivot_row,:)/pvt_key;

    %updation of other rows
    for i = 1 : size(A,1) 
        % ab isme pivot row nhi leni
        if i ~= pivot_row
              A(i,:) = A(i,:) - (A(i,pivot_col).*A(pivot_row,:));
        end
    end
    %updation of z row 
    zjcj = zjcj - (zjcj(pivot_col).*A(pivot_row,:)) 
    zc = zjcj(1:end-1)
    soln = A(:,end)
    else
        run = false
        fprintf("Current BFS is Optimal")

        zcj = [zjcj;A]
        dual_simpl_table = array2table(zcj);
        dual_simpl_table.Properties.VariableNames(1:size(zcj,2)) = {'x1', 'x2', 's1', 's2', 's3', 'soln'}
        optimal_solution = zjcj(end)
    end
end