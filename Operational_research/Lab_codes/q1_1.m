clc
clear all
format short
%Phase I: To input Parameter
A = [-1,3;
    1,1;
    1,-1];
B = [10;
    6;
    2];
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
 fn(i,:)= (sum(P(i,:).*c))
end
values = [P fn]
%phase 8 : to find optimal sol
[Optval Optposition] = max(fn)
Optval = values(Optposition,:)
OPTIMAL_BFS = array2table(Optval);
OPTIMAL_BFS.Properties.VariableNames(1:size(Optval,2))={'x1', 'x2', 'z' }


