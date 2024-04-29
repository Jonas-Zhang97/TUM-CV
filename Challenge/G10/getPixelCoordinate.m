function [PixelCoordi] = getPixelCoordinate(screenCoordinate,image)
%GETPIXELCOORDINATE 此处显示有关此函数的摘要
%   此处显示详细说明
        global_width = size(image,2);
        global_height = size(image,1);
        PixelCoordi(1,:) = ceil((screenCoordinate(1,:)+1)*global_width/2); % x
        PixelCoordi(2,:) = ceil((-screenCoordinate(2,:)+1)*global_height/2); % y
        

end

