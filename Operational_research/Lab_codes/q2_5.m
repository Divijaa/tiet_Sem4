clc
clear all
max = 0;
Variables = {'x1', 'x2', 's1', 's2', 's3', 'A1', 'A2', 'A3', 'sol'}
OVariables = {'x1', 'x2', 's1', 's2', 's3', 'sol'}
info = [5 1 -1 0 0 1 0 0 10;
 6 5 0 -1 0 0 1 0 30;
 1 4 0 0 -1 0 0 1 8]
origC = [-12 -10 0 0 0 -1 -1 -1 0]
bv4 = [6 7 8]
A = info
cost = [0 0 0 0 0 -1 -1 -1 0]
zjcj = (cost(bv4)*A) - cost
[bv2,A] = simp(A,bv4,cost,Variables)
if bv2==0
 fprintf('\n UNBOUNDED SOLUTION ')
else
%PHASE2
 A(:,bv4) = []
 origC(:,bv4)=[]
 [ opt_bfs,optA] = simp(A,bv2,origC,OVariables)
 if (opt_bfs == 0)
 fprintf('\n UNBOUNDED SOLUTION ')
 else
 bfss = zeros(1,size(A,2))
 bfss(opt_bfs) = A(:,end)
 %bfss(end) = sum(bfss.*origC)
 if max==1
 bfss(end) = sum(bfss.*origC)
 else
 bfss(end) = -sum(bfss.*origC)
 end
 currentbfs = array2table(bfss)

 currentbfs.Properties.VariableNames(1:size(currentbfs,2)) = OVariables
 end
end
