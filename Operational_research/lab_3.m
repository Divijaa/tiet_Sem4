%basic feasible solution 
%max z = 2x1 + 3x2 +4x3+ 7x4
%subject to condition
%2x1 + 3x2-x3+4x4 = 8
%x1 - 2x2 +6x3 - 7x4 = -3
%x1 , x2 , x3 , x4 >=0
clc
clear all
format short

%phase I: to input parameters
A=[2 3 -1 4;
   1 -2 6 -7 ]
C=[2 3  4 7]
b=[8;-3]

%phase II: to define number of variables and number of constraints
n=size(A,2)
m= size(A,1)

%phase III : to choose nCm basic solutions
if(n > m)
nCm =nchoosek(n,m)
%non basic variable positioning
pair = nchoosek(1:n,m)

%phase IV and V:to construct basis and to find basic feasible solution
sol=[]
for i=1:nCm
    y=zeros(n,1)
    %pair uss i ki value ke corresponding konse non basic hai
    x=A(:,pair(i,:))\b

    %to check bfs
    if all(x >= 0 & x ~= inf & x ~= -inf)
    y(pair(i,:))=x
    sol=[sol,y]
    end
end
else
    error('nCm doesnot exist')
end

%phase VI : to find optimal solution 
%find  z value on sbhi bfs wali values
Z= C*sol
%to find the optimal value
[Zmax , Zindex]=max(Z)
bfs = sol(:,Zindex)

%to print all the solutions
optimal_value=[bfs' Zmax]
optimal_bfs = array2table(optimal_value)
optimal_bfs.Properties.VariableNames(1:size(optimal_bfs , 2)) = {'x1' ,'x2' , 'x3' , 'x4', 'Z'}







