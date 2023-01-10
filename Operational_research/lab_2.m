%standard form of lpp
clc
clear all
format short
%Max z=x1+2x2-x3
%Subject to x1-2x2-3x3<=4
%2x1+3x2-4x3>=5
%x1+x2+x3=2
%x1,x2,x3>=0
%phase I : to input parameters
A=[1 -2 -3; 
    2 3 -4;
    1 1 1 ]

C=[1 2 -1]

b=[ 4;
    5;
    2 ]
%0 for <= and 1 for >= sign
% I will be decided on the basis of linear inequalities
I=[0 1]
%phase II : to introduce slack and surplus variable
%size(A,1) tells number of rows in A
% I ke columns
s=eye(size(A,1) , size(I,2))

index=find(I > 0)
s(index , index )=-s(index,index)

%phase 3 : to write the standard form
mat =[A s b]

%to convert it in the table form
cons = array2table(mat)
cons.Properties.VariableNames(1:size(mat , 2)) = {'x1' ,'x2' , 'x3' , 's1', 's2', 'b'}
