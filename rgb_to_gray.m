%%1.1 Color image conversion

%with a MATLAB function that converts a passed image to a grayscale image
function gray_image = rgb_to_gray(input_image)
%the datatype should be firstly convert to Double to calculation
input_image = double(input_image);
s = size(input_image);
s1 = size(s);
if s1(1,2)==2
    gray_image = input_image;
else
gray_image = 0.299.*input_image(:,:,1)+0.587.*input_image(:,:,2)+0.114.*input_image(:,:,3);
%the first, second and third layer of the img coresponds to R, G and B
end
%the datatype will be transformed back to 8uint
gray_image = uint8(gray_image);
end