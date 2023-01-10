%code for big M
clc
clear
format short
x_1 = 10000
cost=[-12 -10 0 0 0 -x_1 -x_1 -x_1 0]
b=[10;
 30;
 8]
a= [5 1 -1 0 0 1 0 0;
 6 5 0 -1 0 0 1 0;
 1 4 0 0 -1 0 0 1 ]
A=[a b]

noofvar=5;
%bv are index of starting basic variables
%starting basic variable n + 1 se start hokr size -1 wale honge 
bv=noofvar+1:1:size(A,2)-1

%cost(bv) gives cost of basic variables
zjcj=cost(bv)*A-cost; 
zcj = [zjcj; A]

simptable = array2table(zcj)
simptable.Properties.VariableNames(1:size(zcj,2))= {'x_1','x_2','s1','s2','s3','A1','A2','A3','b'}
run= true
while run
    zc=zjcj(1:end-1)
if any(zc<0);
    fprintf('bfs is not optimal')
    %to find minimum with its position(most negative entering variable)
    [Enter_val,pvt_col]=min(zc)
    fprintf('the most neagtive element in Zrow is %d corresponding to column %d',Enter_val,pvt_col)
    
    if all(A(:,pvt_col)<=0)
        error('lpp is unbounded')
    else
        %to find leaving variable 
        sol = A(:,end)
        col= A(:,pvt_col)

        %now we will find the minimum ratio between pivot col and sol col
        for i=1:size(A,1)
            if(col(i)>0)
                ratio(i)=sol(i)/col(i)
            else
                %inf stands for infinity (MAX)
                ratio(i) = inf 
            end
        end
        [leaving_variable,pvt_row]=min(ratio)
    end
        %to display new basic variables in next iteration
        bv(pvt_row) = pvt_col;
        disp(bv)
        % to indentify pivot element
        pvt_key = A(pvt_row, pvt_col)
        %updating table for next iteration
        %updating pivot row first
        A(pvt_row,:)=A(pvt_row,:)./pvt_key
            
        % for updation of other rows
         for i=1:size(A,1)
             % ab isme pivot row nhi leni
            if i~= pvt_row
                A(i,:)= A(i,:)- A(i,pvt_col).*A(pvt_row,:)
            end
         end
         %now updating the z row
         zjcj = zjcj - zjcj(pvt_col).* A(pvt_row,:)
         zcj1=[zjcj;A]
         % to print the table
        table = array2table(zcj1)
        table.Properties.VariableNames(1:size(zcj1,2))={'x_1','x_2','s1','s2','s3','A1','A2','A3','b'}
       
        BFS = zeros(1,size(A,2));
        BFS(bv) = A(:,end)
        % to find objective func wala sol
        BFS(end) = sum(BFS.*cost)

        curr_Bfs = array2table(BFS);
        curr_Bfs.Properties.VariableNames(1:size(curr_Bfs,2)) = {'x_1','x_2','s1','s2','s3','A1','A2','A3','b'}
else
    run = false;
end
end