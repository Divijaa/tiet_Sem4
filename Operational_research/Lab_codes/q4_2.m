clc
clear all
format short
c = [1,3,7]
a = [1 1 0; 0 -1 1]
b = [1;0]
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
