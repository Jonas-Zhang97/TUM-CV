%Recycling 
%a = [];
%b = [];
function axb = cp(a,b)
%this function calculates the cross product of two input vectors a and b
a = hat(a);   %change a to \hat{a}
axb = a*b;   %calculate the product
end