%%1.2 Image Gradient

%with a Matlab function to approximate the first derivative of the passed
%image in x- and y- direction with the help of the Sobel filter
function [Fx,Fy] = sobel_xy(input_image)
%definetion of Sobel filter in horizontal and vertical direction
Gx = [1 0 -1;2 0 -2;1 0 -1];
Gy = [1 2 1;0 0 0;-1 -2 -1];
%using 2 dimensional convolution conv2(G,A) to calculate:
%1) Gradient in horizontal direction
Fx = conv2(Gx,input_image);
%2) Gradient in vertical direction
Fy = conv2(Gy,input_image);
%with the convolution there will be 2 extra arries and 2 extra columns on
%the eage of the outcome
%the extra 2 arries and 2 colums should be deleted
sx1 = size(Fx);   %determination: how many arrays and columns dose Fx and Fy have
Fx(1,:) = [];
Fx(sx1(1)-1,:) = [];
Fx(:,1) = [];
Fx(:,sx1(2)-1) = [];
sy1 = size(Fy);   %determination: how many arrays and colums do Fx and Fy have
Fy(1,:) = [];   %delete the first array
Fy(sy1(1)-1,:) = [];   %delete the last array
Fy(:,1) = [];   %delete the first column
Fy(:,sy1(2)-1) = [];   %delete the last column
end