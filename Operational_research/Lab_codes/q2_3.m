 %%M ax. z = 4x1 + 6x2 + 3x3 + x4, 
%%subject to
%%x1 + 4x2 + 8x3 + 6x4 ? 11, 4x1 + x2 + 2x3 + x4 ? 7, 
%%2x1 + 3x2 + x3 + 2x4 ? 2, x1, x2, x3 ? 0.
clc
clear all

format short
noofvariables=4;
c = [4 6 3 1]
a = [1 4 8 6; 4 1 2 1; 2 3 1 2]
b = [11; 7; 2]
s= eye(size(a,1));
A = [a s b]
cost = zeros(1,size(A,2));
cost(1:noofvariables)=c;
bv = noofvariables+1:size(A,2)-1;
zjcj = cost(bv)*A -cost;
zcj = [zjcj; A];
simptable = array2table(zcj)
simptable.Properties.VariableNames(1:size(zcj,2))= {'x_1','x_2','x_3','x_4','s1','s2','s3','b'}
run = true;
while(run)
 zc=zjcj(1:end-1);
 if any(zc<0);
 fprintf('bfs is not optimal')
 [Enter_val,pvt_col]=min(zc)
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
 
 pvt_key = A(pvt_row, pvt_col)
 bv(pvt_row) = pvt_col
 A(pvt_row,:)=A(pvt_row,:)/pvt_key
 for i=1:size(A,1)
 if i~= pvt_row
 A(i,:)= A(i,:)- A(i,pvt_col).*A(pvt_row,:)
 end
 end
 zjcj = zjcj - zjcj(pvt_col).* A(pvt_row,:)
 zcj1=[zjcj;A]

 table = array2table(zcj1)
 table.Properties.VariableNames(1:size(zcj1,2))= {'x_1','x_2','x_3','x_4','s1','s2','s3','b'}
 BFS=zeros(1,size(A,2));
 BFS(bv)=A(:,end);
 BFS(end)=sum(BFS.*cost);
 CurrentBFS=array2table(BFS);
 
CurrentBFS.Properties.VariableNames(1:size(CurrentBFS,2))={'x_1','x_2','x_3','x_4','s1','s2','s3','b'}
 else
 run = false;
 fprintf("the current bfs is optimal")
 end
end