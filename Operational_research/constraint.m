function output = constraint(x)
format rat

%Write first constratint
%all constraint are of less than eqaual to sign
x1 = x(:,1)
x2 = x(:,2)
%write first eq here
const1 = round(-x1 + (3.*x2 ) - 10)
%if the enquality is greater than sign then use const1 < 0
s1 = find(const1 > 0 )
%[] represents delete
x(s1,:) = []

%all constraint are of less than eqaual to sign
x1 = x(:,1)
x2 = x(:,2)
const2 = round((x1+x2) -6)
s2 = find(const2 > 0 )
%[] represents delete
x(s2,:) = []

%Write first constratint
%all constraint are of less than eqaual to sign
x1 = x(:,1)
x2 = x(:,2)
const3 = round((x1-x2)-2)
s3 = find(const3 > 0 )
%[] represents delete
x(s3,:) = []

output = x
end