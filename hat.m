%Hat over your head
%w = [1;2;3;4];
function [W] = hat(w)
%This function implements the ^-operater
%It convers a 3x1-vector into a skew symmetric matrix
s = size(w);
if s(1)==3 && s(2)==1   %3x1-vector
    W = [0 -w(3,1) w(2,1);w(3,1) 0 -w(1,1);-w(2,1) w(1,1) 0];
else   %the rest, cant't handle
    error('Variable w has to be a 3-component vector!')
end
end