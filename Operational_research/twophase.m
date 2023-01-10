clc 
clear all
format short
Variables= {'x1','x2','x3','s1','s2','a1','a2','sol'};
OVariables={'x1','x2','x3','s1','s2','sol'};

Origc=[-7.5 3 0 0 0 -1 -1 0]
A=[3 -1 -1 -1 0 1 0 3;
    1 -1 1 0 -1 0 1 2]
bv=[6 7]

%%phase-1
Cost= [0 0 0 0 0 -1 -1 0]
startbv=find(Cost<0);
%calling of function to find optimal table for arbitary z function
[BFS,A]=simp(A,bv,Cost,Variables);


%%phase-2
%dropping the artifical variable in phase 2
A(:,startbv)=[];
Origc(startbv)=[];
%calling of function for optimal sol for original functiom
[optbfs,optA]=simp(A,BFS,Origc,OVariables);

final_bfs=zeros(1,size(A,2));
final_bfs(optbfs)=optA(:,end)
final_bfs(end)=sum(final_bfs.*Origc)
optimalbfs=array2table(final_bfs)
optimalbfs.Properties.VariableNames(1:size(optimalbfs,2))=OVariables