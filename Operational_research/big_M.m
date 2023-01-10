%code for big M  
clc
clear
format short
x_1 = 10000
cost=[-2 -1 0 0 -x_1 -x_1 0]
b=[3;
   6;
   3]
a= [3 1 0 0 1 0;
    4 3 -1 0 0 1 ;
    1 2 0 1 0 0]
A=[a b]
noofvar=2;

bv=noofvar+2:size(A,2)-1


zjcj=cost(bv)*A-cost; 
zcj = [zjcj; A]

simptable = array2table(zcj)
simptable.Properties.VariableNames(1:size(zcj,2))= {'x_1','x_2','s1','s2','A1','A2','b'}
run= true
while run
    zc=zjcj(1:end-1)
if any(zc<0);
    fprintf('bfs is not optimal')
   
    [Enter_val,pvt_col]=min(zc)
    fprintf('the most neagtive element in Zrow is %d corresponding to column %d',Enter_val,pvt_col)
    
    if all(A(:,pvt_col)<=0)
        error('lpp is unbounded')
    else
       
        sol = A(:,end)
        col= A(:,pvt_col)

        for i=1:size(A,1)
            if(col(i)>0)
                ratio(i)=sol(i)/col(i)
            else
               
                ratio(i) = inf 
            end
        end
        [leaving_variable,pvt_row]=min(ratio)
    end
       
        bv(pvt_row) = pvt_col;
        disp(bv)
       
        pvt_key = A(pvt_row, pvt_col)
       
        A(pvt_row,:)=A(pvt_row,:)/pvt_key
            
        
         for i=1:size(A,1)
            
            if i~= pvt_row
                A(i,:)= A(i,:)- A(i,pvt_col).*A(pvt_row,:)
            end
         end
         zjcj = zjcj - zjcj(pvt_col).* A(pvt_row,:)
         zcj1=[zjcj;A]
       
        table = array2table(zcj1)
        table.Properties.VariableNames(1:size(zcj1,2))= {'x_1','x_2','s1','s2','A1','A2','b'}
       
        BFS = zeros(1,size(A,2));
        BFS(bv) = A(:,end)
       
        BFS(end) = sum(BFS.*cost)

        curr_Bfs = array2table(BFS);
        curr_Bfs.Properties.VariableNames(1:size(curr_Bfs,2)) = {'x_1','x_2','s1','s2','A1','A2','b'}
else
    run = false;
end
end