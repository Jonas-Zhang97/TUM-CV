 function [ RGB] = screenCoordinates2sourceImageColor(screenCoordinate,image)
% Given the screen coordinates (-1~1) of points, return the color info of the point of the original image. 
% input screenCorrdinate: 2 by 1 matrix. [x;y]
% output CoforInfo : 1 by 1 by 3 matrix. x;y, channel
ColorInfo = zeros(1,1,3);

global_width = size(image,2);
global_height = size(image,1);
    if screenCoordinate(1,1) < -1 || screenCoordinate(1,1) > 1
        ColorInfo(:,:,1:3) = 0;
%         RGB(1,1:3) = 1;
    elseif  screenCoordinate(2,1) < -1 || screenCoordinate(2,1) > 1
              ColorInfo(:,:,1:3) = 0;
%               RGB(1,1:3) = 1;
    else
        % get pixel coordinate of points
        PixelCoordi(1,1) = (screenCoordinate(1,1)+1)*global_width/2; % x 
        PixelCoordi(2,1) = (-screenCoordinate(2,1)+1)*global_height/2; % y
        PixelCoordi = ceil(PixelCoordi); % size(PixelCoordi) = 2 1
        ColorInfo(:,:,1:3) = image(PixelCoordi(2,1),PixelCoordi(1,1),1:3); % size(ColorInfo) = 1x1x3
    end
RGB(1,1) = ColorInfo(:,:,1);
RGB(2,1) = ColorInfo(:,:,2);
RGB(3,1) = ColorInfo(:,:,3);


% ColorInfo = zeros(1,1,3);
% 
% global_width = size(image,2);
% global_height = size(image,1);
%     if screenCoordinate(1,1) < -1 || screenCoordinate(1,1) > 1
%         ColorInfo(:,:,1:3) = 1;
%         RGB(1,1:3) = 1;
%     else if  screenCoordinate(2,1) < -1 || screenCoordinate(2,1) > 1
%               ColorInfo(:,:,1:3) = 1;
%               RGB(1,1:3) = 1;
%     else
%         % get pixel coordinate of points
%         PixelCoordi(1,1) = (screenCoordinate(1,1)+1)*global_width/2; % x 
%         PixelCoordi(2,1) = (-screenCoordinate(2,1)+1)*global_height/2; % y
%         PixelCoordi = ceil(PixelCoordi); % size(PixelCoordi) = 2 1
%         ColorInfo(:,:,1:3) = image(PixelCoordi(2,1),PixelCoordi(1,1),1:3); % size(ColorInfo) = 1x1x3
%     end
% RGB(1,1) = ColorInfo(:,:,1);
% RGB(1,2) = ColorInfo(:,:,2);
% RGB(1,3) = ColorInfo(:,:,3);


 
 end

