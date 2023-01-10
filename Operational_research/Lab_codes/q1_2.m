clc
clear all
format short
c=[1,2]
a = [-1 1; 1 1]
b = [1; 2]
 
s = eye (size(a,1))
I = [0,0]
index= find(I==1)
s(index,index)= -s(index,index)
mat=[a s b]
obj=array2table(c);
obj.Properties.VariableNames(1:size(c,2))={'x_1','x_2'}
cons=array2table(mat);
cons.Properties.VariableNames(1:size(mat,2))={'x_1','x_2','s1','s2','b'}
n=size(a,2)
m=size(a,1)
if(n<m)
 disp("invalid")
else
 ans = nchoosek(n,m)
 pairs= nchoosek(1:n,m)
 sol = []
 for i = 1:ans
 y = zeros(n,1)
 X = a(:,pairs(i,:))\b
 if all(X>=0 & X ~= inf)
 
 Y(pairs(i,:))= X
 sol = [sol, y]
 end
 end
end
