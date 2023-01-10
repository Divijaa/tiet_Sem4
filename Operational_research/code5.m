clc
clear all
format short
noofvar=2;
M=10000
%%a=[1 -3;
% 1 2;
% 3 1;
% 1 0]
%%s=[0 -1 0 0;
    % M 1 0 0; 
    % 0 0 1 0; 
    % 0 0 0 1]
%%b=[0; 2; 3; 4]

%%A = [a s b]

a=[1 2 -1 1 0 0;
    3 1 0 0 1 0;
    1 0 0 0 0 1]
b=[2; 3 ; 4]
c=[-13 0 -M 0 0 0]
%%A(1,:)=A(1,:)- M*A(2,:)
A=[a b]
bv=noofvar+2:1:size(A,2)-1
zjcj=c(bv)*A-c;
zcj=[zjcj;A]

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
        table.Properties.VariableNames(1:size(zcj1,2))= {'x_1','x_2','x_3','s1','s2','s3','b'}


    else
        run = false;
    end
 end

