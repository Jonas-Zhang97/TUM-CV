%Harris Detector Input Parameters

function [features,acc_array] = harris_detector(input_image,varargin)
%extracting features from image for the Harris detector.

%% 1.3 Input Parser

%creat a parser
p = inputParser;

%add parameters to the parser
%segment length for the size of the windows
DefVal_segment_length = 15;
addParameter(p,'segment_length',DefVal_segment_length,@(x) isnumeric(x)&&mod(x,2)==1&&x>1)
%k for the calculation of H
DefVal_k = 0.05;
addParameter(p,'k',DefVal_k,@(x) isnumeric(x)&&x>=0&&x<=1)
%tau as thereshold
DefVal_tau = 10^6;
addParameter(p,'tau',DefVal_tau,@(x) isnumeric(x)&&x>0)
%do plot controls wether the processed image should be ploted
DefVal_do_plot = false;
addParameter(p,'do_plot',DefVal_do_plot,@(x) islogical(x))
%min_dist to avoid too many features in a small rigion
DefVal_min_dist = 20;
addParameter(p,'min_dist',DefVal_min_dist,@(x) isnumeric(x)&&x>=1)
%tile size
DefVal_tile_size = 200;
addParameter(p,'tile_size',DefVal_tile_size,@(x) isnumeric(x))
%N
DefVal_N = 5;
addParameter(p,'N',DefVal_N,@(x) isnumeric(x)&&x>=1)

%update values
p.parse(varargin{:})

%write the updated values
segment_length = p.Results.segment_length;
k = p.Results.k;
tau = p.Results.tau;
do_plot = p.Results.do_plot;
min_dist = p.Results.min_dist;
tile_size = p.Results.tile_size;
N = p.Results.N;

%make sure that the tile_size is always a 1x2-Matrix
%which indicates the length and width
if size(tile_size,2)==1
    tile_size = [tile_size,tile_size];
elseif size(tile_size,2)>2
    error("please enter [hight,width]")
end

%% 1.4 Preparation of the image gradient

%1.4.1 check if it is a grayscale gradient
Size_Img = size(input_image);
Dimension_Img = size(Size_Img);

%if Dimension_Img(1,2)=3, then the image is a colored image
if Dimension_Img(1,2)==3
    error('Image format has to be NxMx1')
%if Dimension_Img(1,2)=2, then it is a grayscale image
else
end

%1.4.2 convert the grayscale image to double
input_image = double(input_image);

%1.4.3 Determine the image gradient in x- & y-direction
[Ix,Iy] = sobel_xy(input_image);

%1.4.4 Wighting
%generize a 3x3 gaussian filter
%sigma must be segment_length/5, why?
w = fspecial('gaussian',[segment_length,1],segment_length/5);

%1.4.5 Harris Matrix G
%for more details: Visual Navigation note "VN" page 4
Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy = Ix.*Iy;
%why should it be like conv2(w,w,Ix2,"same")
G11 = conv2(w,w,Ix2,"same");
G22 = conv2(w,w,Iy2,"same");
G12 = conv2(w,w,Ixy,"same");

%% 1.5 Harris Detector Feature Extraction

%calculation follows the fomula: H = det(G)-k \cdot tr^{2}(G)
H = zeros(size(input_image));
for i=1:size(input_image,1)
    for j=1:size(input_image,2)
        G = [G11(i,j),G12(i,j);G12(i,j),G22(i,j)];
        H(i,j) = det(G)-k.*trace(G).^2;
    end
end

%set the feature on the rim to 0
H(1:ceil(segment_length/2),:) = 0;
H(size(H,1)-ceil(segment_length/2)+1:size(H,1),:) = 0;
H(:,1:ceil(segment_length/2)) = 0;
H(:,size(H,2)-ceil(segment_length/2)+1:size(H,2)) = 0;

%comparision with the thereshold
H(H<=tau)=0;

corners = H;
% [row,column] = find(corners~=0);
% features(1,:) = column';   %indicate that, in which column lies the feature (x-coordinate)
% features(2,:) = row';   %indicate that, in which array lies the feature (y-coordinate)

%% 1.9 Harris Detector Feature Preparation

%add border
corners_border = [zeros(min_dist,size(corners,2));corners];
corners_border = [corners_border;zeros(min_dist,size(corners_border,2))];
corners_border = [zeros(size(corners_border,1),min_dist),corners_border];
corners_border = [corners_border,zeros(size(corners_border,1),min_dist)];
corners = corners_border;

%extract the non-zero elements in corners with border, why is it like this?
[sorted_intensity,sorted_index] = sort(corners(:),'descend');
sorted_index(sorted_intensity==0)=[];

%% 1.10 Harris Detector Tiles

%the input image should be splitted up into tiles
acc_array = zeros(ceil(size(input_image,1)/tile_size(1,2)),ceil(size(input_image,2)/tile_size(1,1)));

%how many tiles may exist:
num_Tile = size(acc_array,1)*size(acc_array,2);

%only N features in each tile will be saved 
%which means maximum number of features is:
max_num_fea = N*num_Tile;

%there might be some tiles containing less than N or no feature
%so the number of features in the image CAN be smaller than max_num_fea
%sum of all features:
sum_fea = size(sorted_index,1);
%prepare Merkmale
features = zeros(2,min(sum_fea,max_num_fea));

%% 1.11 Harris Detector

%the coordinates are following the order from strongest to weakest
%eliminate the corners that don't meet the requirment of distance

%eliminate the redundant corners
for i=1:sum_fea   %we check every CORNER from strongest to weakest
    column_corners = floor(sorted_index(i)/size(corners,1));
    row_corners = sorted_index(i)-(column_corners)*size(corners,1);
    column_corners = column_corners+1;
    if corners(row_corners,column_corners)==0
        %do nothing, these one has already been cancelled
    else
        %these one is the strongest corner of the remaining corners

        %first of all we should check this corner lies in which tile

        %the tiles are next to each other
        %together they CAN be larger than the input image
          column_corners_noborder = column_corners-min_dist;
          row_corners_noborder = row_corners-min_dist;
        

        %determine the associated tile
        column_acc_array = floor((column_corners_noborder-1)/tile_size(2))+1;
        row_acc_array = floor((row_corners_noborder-1)/tile_size(1))+1;

        %check if this tile has already N corners
        if acc_array(row_acc_array,column_acc_array)>=N
            %this tile is fully taken
            corners(row_corners,column_corners) = 0;
        else
            %there is still place in this tile
            
            %set all corners in the circle around this one to 0
            selected_region = corners(row_corners-min_dist:row_corners+min_dist,column_corners-min_dist:column_corners+min_dist);
            corners(row_corners-min_dist:row_corners+min_dist,column_corners-min_dist:column_corners+min_dist) = selected_region.*cake(min_dist);
            
            %record the coordinate of this corner
            %x-coordinate
            features(1,i) = column_corners_noborder;
            %y-coordinate
            features(2,i) = row_corners_noborder;

            %einen Arbeitzplatz bitte!
            acc_array(row_acc_array,column_acc_array) = acc_array(row_acc_array,column_acc_array)+1;
        end
    end
end
features(:,all(features==0,1))=[];

%% 1.6 Harris Detector Plot

if do_plot
    figure ()
    imshow(input_image)
    hold on
    plot(features(1,:),features(2,:),'yx')
    hold off
end
end