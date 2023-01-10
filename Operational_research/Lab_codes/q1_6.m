clear all
clc 
format short
%taking input
%the z function
c = [-3 -5 0 0 0]
%the info matrix with identity matrix and sol col included
A = [-1 -3 1 0 -3;
    -1 -1 0 1 -2]
%index of starting basic variables
bv = [3,4]

cost = zeros(1, size(A,2));
cost(1:5) = c

z=cost(bv)*A
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
        dual_simpl_table.Properties.VariableNames(1:size(zcj,2)) = {'x1', 'x2', 's1', 's2', 'soln'}
        optimal_solution = zjcj(end)
    end
end