clc
clear all
format short
%for commenting use percent sign like this
% how to draw and plot lines in matlab
%-x1+3x2-10
%x1+x2=6
%x1-x2=2

A = [-1,3;
    1,1;
    1,-1];
B = [10;
    6;
    2];

%PHASE II :  plotting the lines on graph
%y1 represents x axis
y1 = 0:max(B);
x11 = (B(1)-A(1,1).*y1)./A(1,2);
x21 = (B(2)-A(2,1).*y1)./A(2,2);
x31 = (B(3)-A(3,1).*y1)./A(3,2);

%to remove the negative values
x11 = max(0,x11);
x21 = max(0,x21);
x31 = max(0,x31);

plot(y1,x11 ,'r' , y1 , x21 , 'b',y1 , x31 , 'g')
title('Lines ploting')
xlabel('x axis')
ylabel('y axis')
legend('-x1+3x2-10','x1+x2=6','x1-x2=2')
grid on

%PHASE III : to find the corner points (cutting on axis)

cx1 = find(y1==0)
c1 = find(x11 == 0)
% ax =b and x = a^-1 b
line1 = [y1(:,[c1 cx1]);x11(:,[c1 cx1])]'

c2 = find(x21==0)
line2 = [y1(:,[c2 cx1]);x21(:,[c2 cx1])]'

c3 = find(x31 ==0)
line3 = [y1(:,[c3, cx1]);x31(:,[c3 cx1])]'

corpt = unique([line1 ; line2 ; line3] ,'rows')

%PHASE IV : to find point of intersection

pt=[0;0]
for i = 1:size(A,1)
    a1 = A(i,:)
    b1 = B(i,:)
    for j = i+1 : size(A,1)
        a2 = A(j , :)
        b2 = B(j , :)
        a4 = [a1;a2]
        b4 = [b1;b2]
        %to calculate the inverse \ is used
        x = a4\b4
        pt= [pt x]
    end
end
ptt = pt'

%PHASE V: write all the corner points
allpt = [ptt ;corpt]
points = unique(allpt , 'rows')

%PHASE VI : Find the feasible regin
PT = constraint (points)
PT = unique(PT , "rows")






