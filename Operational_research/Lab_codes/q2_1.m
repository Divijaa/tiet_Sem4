clc
clear all
format short
%Phase I: To input Parameter
A=[2 4;3 5];
B=[8; 15];
c = [3 2];
%Phage II: To Plot the lines on the graph
x1= 0:max (B)
x21= (B(1)-A(1,1).*x1)./A(1,2)
x22= (B(2)-A(2,1).*x1)./A(2,2)
x21=max(0,x21)
x22=max(0,x22)
plot (x1, x21, 'r' ,x1,x22,'b' )
title('xl vs x2')
xlabel ('value of x11');
ylabel ('value of x21');
legend('2x1+4x2=8', '3x1+5x2=15');
grid on
%Phase 3
cx1 = find(x1==0)
c1 = find(x21==0)
line1 = [x1(:,[c1 cx1]); x21(:,[c1 cx1]);]';
c2 = find(x22==0)
line2 = [x1(:,[c2 cx1]); x22(:,[c2 cx1]);]';
corpt = unique([line1;line2],'rows')
%phase 4
 pt = [0;0]
for i=1:size(A,1)
 A1 = A(i,:)
 B1 = B(i,:)
 for j=i+1:size(A,1)
 A2 = A(j,:);
 B2 = B(j,:);
 A4 = [A1;A2];
 B4 = [B1;B2];
 X = A4\B4;
 pt = [pt X]
 end
end
ptt = pt'
%phase 5
allpt = [ptt;corpt];
points = unique(allpt,"rows")
%phase 6
%find the feasible region
PT = constraint1(points)
P = unique(PT,"rows")
%phase 7 : find value of objective func
%max z = x1+5x2
for i=1:size(P,1)
 fn(i,:)= (sum(P(i,:).*c))format rat
c = [3,2];
a = [2 4;3 5];
b = [8; 15];
p=max(b);
x1 = 0:1:max(b)
x12 = (b(1)
-a(1,1).*x1)./a(1,2)
x22 = (b(2)
-a(2,1).*x1)./a(2,2)
x12 = max(0,x12)
x22 = max(0,x22)
%%x32 = max(0,x32)
plot( x1,x12,'r',x1,x22,'b')
cx1=find(x1==0)
c1=find(x12==0)
line1 = [x1(:,[c1 cx1]); x12(:,[c1 cx1])]'
c2=find(x22==0);
line2= [x1(:,[c2 cx1]); x22(:,[c2 cx1])]'
corpt = unique([line1;line2],'rows')
pt =[0;0];
for i=1:size(a,1)
 a1 = a(i,:);
 b1 = b(i,:);
 for j =i+1:size(a,1)
 a2 = a(j,:);
 b2 = b(j,:);
 a4 = [a1;a2];
 b4 = [b1;b2];
 x = a4
\b4;
 pt = [pt x];
 end
end
pt = [pt x] 
ptt = pt'
allpt=[ptt;corpt]
points=unique(allpt,'rows')clear all
clc 
format short
c = [3 5 0 0 0]
A = [-1 -3 1 0 -3;
 -1 -1 0 1 -2;]
 
bv = [3,4]
cost = zeros(1, size(A,2))
cost(1:5) = c
zjcj = cost(bv)*A - cost
zcj = [zjcj;A]
soln = A(:,end)
run = true
while(run == true)
 if(any(soln<0))
 negIND = find(soln<0)
 [leaving_var, pivot_row] = min(soln(negIND))
 ratio = []
 for i = 1:size(A,2)-1
 if A(pivot_row,i) <0
 ratio(i) = abs(zjcj(i)/A(pivot_row,i))
 else
 ratio(i) = inf;
 end
 end
 [entering_var, pivot_col] = min(ratio)
 pvt_key = A(pivot_row, pivot_col)
 bv(pivot_row) = pivot_col;
 A(pivot_row,:) = A(pivot_row,:)/pvt_key;
 for i = 1 : size(A,1)
 if i ~= pivot_row
 A(i,:) = A(i,:) - (A(i,pivot_col).*A(pivot_row,:));
 end
 end
 zjcj = zjcj - (zjcj(pivot_col).*A(pivot_row,:)) 
 zc = zjcj(1:end-1)
 soln = A(:,end)
 else
 run = false
 fprintf("Current BFS is Optimal")
 zcj = [zjcj;A]
 optimum_simplex_table = array2table(zcj)
P a g e | 27
 optimum_simplex_table.Properties.VariableNames(1:size(zcj,2)) = {'x1', 'x2', 's1', 's2', 'soln'}
 optimal_solution = zjcj(end)
 solns = [bv' A(:,end)]
 end
end
PT = constraint(points)
p=unique(PT,'rows')
for i=1:size(PT,1)
 fx(i,:)=sum(PT(i,:).*c)
end
P a g e | 4
vert_fns=[PT fx];
[fxval,indfx] = max(fx)
optval=vert_fns(indfx,:)
optimalbfs=array2table(optval)
optimalbfs.Properties.VariableNames(1:3) = {'x1', 'x2','z'}
end
values = [P fn]
%phase 8 : to find optimal sol
[Optval Optposition] = max(fn)
Optval = values(Optposition,:)
OPTIMAL_BFS = array2table(Optval);
OPTIMAL_BFS.Properties.VariableNames(1:size(Optval,2))={'x1', 'x2', 'z' }
