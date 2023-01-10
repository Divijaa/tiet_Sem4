clc
clear all
format short

c=[-1 3 -2]
a=[3 -1 2 ; -2 4 0 ; -4 3 8]
b=[7;12;10]

s= eye(size(a,1));
A=[a s b];

noofvariables = size(c,2);
bv = noofvariables + 1 :size(A,2)-1;

cost = zeros(1,size(A,2));
cost(1:noofvariables) = c

zjcj = cost(bv)*A - cost
zcj = [zjcj;A]

run = true
while run
    zc = zjcj(1:end-1)
    if any(zc < 0)
        fprintf('lpp is not optimal')

        [enter_val , pvt_col] = min(zc)
        fprintf('entering ele is %d and pvt col is %d' , enter_val,pvt_col)

        if all(A(:,pvt_col) <= 0)
            error('lpp is unbounded')
        else
            sol = A(:,end)
            col = A(:,pvt_col)

            for i = 1: size(A,1)
                if(col(i) > 0)
                    ratio(i) = sol(i)/col(i)
                else
                    ratio(i) = inf
                end
            end
            [leav_val , pvt_row]= min(ratio)
        end

        bv(pvt_row) = pvt_col;
        disp(bv)

        pvt_key = A(pvt_row , pvt_col)
        
        A(pvt_row , :) = A(pvt_row,:)./pvt_key

        for i = 1: size(A,1)
            if i ~= pvt_row
                A(i,:) = A(i ,:) -A(i,pvt_col).*A(pvt_row ,:)
            end
        end
        
        zjcj = zjcj - zjcj(pvt_col).*A(pvt_row , :)
        zcj1 = [zjcj: A]

        table = array2table(zcj1)
        
        BFS = zeros(1, size(A,2))
        BFS(bv) = A(:, end)

        BFS(end) = sum(BFS.*cost)

        curr_bfs = array2table(BFS)
    else
        run = false
    end
end



 
