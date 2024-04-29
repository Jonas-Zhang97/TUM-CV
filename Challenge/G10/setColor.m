function [NewImage] = setColor(x,y,height,width,ColorInfo,OrIm)
% creat mask, set RGB to NewImage
% tic
mask = poly2mask(x,y,height,width); 
% toc
% tic
 NewImage = zeros(size(OrIm,1),size(OrIm,2),3);
r = ColorInfo(1,1);
g = ColorInfo(2,1);
b = ColorInfo(3,1);
% toc

%%%%%%%%%%%%%%%%%%%
% tic
[rows,cols] = find(mask);
l = length(rows);
for i = 1:1:l
    NewImage(rows(i),cols(i),1) = r;
    NewImage(rows(i),cols(i),2) = g;
    NewImage(rows(i),cols(i),3) = b;
end

% toc
%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tic
% NewImage(:,:,1) = r;
% NewImage(:,:,2) = g;
% NewImage(:,:,3) = b;
% toc
% tic
% NewImage(:,:,1) = NewImage(:,:,1).*mask; 
% NewImage(:,:,2) = NewImage(:,:,2).*mask;
% NewImage(:,:,3) = NewImage(:,:,3).*mask;
% toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

