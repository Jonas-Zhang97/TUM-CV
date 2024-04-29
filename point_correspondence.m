%% Homework 2
%I1 and I2 are the input images
%Fpt1 and Fpt2 are the extracted features from image1 and image2
function cor = point_correspondence(I1,I2,Ftp1,Ftp2,varargin)
%% 2.1 input parser

%create a input paser
p = inputParser;
%side length for the window
default_val_window_length = 25;
addParameter(p,'window_length',default_val_window_length,@(x) isnumeric(x)&&mod(x,2)==1&&x>1)
%lower thereshold for the intensity
default_val_min_corr = 0.95;
addParameter(p,'min_corr',default_val_min_corr,@(x) isnumeric(x)&&x>0&&x<1)
%plot control
default_val_do_plot = false;
addParameter(p,'do_plot',default_val_do_plot,@(x) islogical(x))
%read the inputs
p.parse(varargin{:})
%update the values
window_length = p.Results.window_length;
min_corr = p.Results.min_corr;
do_plot = p.Results.do_plot;

%change the input images to double
Im1 = double(I1);
Im2 = double(I2);

%% 2.2 Frature Preparation

%determination of the distance between feature and window-edge
dist_fea_win = fix(window_length/2);

%determination of the maximal range of the images in x- and y-direction
edge1_right = size(Im1,2)-dist_fea_win;
edge1_down = size(Im1,1)-dist_fea_win;
edge2_right = size(Im2,2)-dist_fea_win;
edge2_down = size(Im2,1)-dist_fea_win;

%examine all features, which of them are outside of the range
%set all the features outside to (0,0)

%for image1
for i=1:size(Ftp1,2)
    %x-direction
    if Ftp1(1,i)<=dist_fea_win || Ftp1(1,i)>edge1_right
        Ftp1(:,i) = 0;
    end
    %y-direction
    if Ftp1(2,i)<=dist_fea_win || Ftp1(2,i)>edge1_down
        Ftp1(:,i) = 0;
    end
end

%for image2
for i=1:size(Ftp2,2)
    %x-direction
    if Ftp2(1,i)<=dist_fea_win || Ftp2(1,i)>edge2_right
        Ftp2(:,i) = 0;
    end
    %y-direction
    if Ftp2(2,i)<=dist_fea_win || Ftp2(2,i)>edge2_down
        Ftp2(:,i) = 0;
    end
end

%delete all the points at (0,0)
Ftp1(:,all(Ftp1==0)) = [];
Ftp2(:,all(Ftp2==0)) = [];
%the position of those features are saved in these matrices

%calculate number of the rest features
no_pts1 = size(Ftp1,2);
no_pts2 = size(Ftp2,2);

%% 2.3 Normalization of the Windows

%create two 0-matrices, which stand for the initial Mat_fea_1 & Mat_fea_2
Mat_feat_1 = zeros(window_length^2,no_pts1);
Mat_feat_2 = zeros(window_length^2,no_pts2);
one = ones(window_length,1);

%calaulate W for all features and fill up the Mat_fea_1 & Mat_fea_2
for i=1:no_pts1
    W1 = Im1(Ftp1(2,i)-dist_fea_win:Ftp1(2,i)+dist_fea_win,Ftp1(1,i)-dist_fea_win:Ftp1(1,i)+dist_fea_win);
    dash_W1 = (1/(window_length^2))*(one*one'*W1*one*one');
    diff_W1 = W1-dash_W1;
    delta_W1 = std(W1(:));
    W1_n = (1/delta_W1)*(diff_W1);
    Mat_feat_1(:,i) = reshape(W1_n,[window_length^2,1]);
end
for i=1:no_pts2
    W2 = Im2(Ftp2(2,i)-dist_fea_win:Ftp2(2,i)+dist_fea_win,Ftp2(1,i)-dist_fea_win:Ftp2(1,i)+dist_fea_win);
    dash_W2 = (1/(window_length^2))*(one*one'*W2*one*one');
    diff_W2 = W2-dash_W2;
    delta_W2 = std(W2(:));
    W2_n = (1/delta_W2)*(diff_W2);
    Mat_feat_2(:,i) = reshape(W2_n,[window_length^2,1]);
end

%% 2.4 Normalized Cross Correlation

%calculate the NCC_matrix using the fomula on Matlab-Grader
%the element NCC_matrix(i,j) indicats the correspondence between i-th window in Im2 and j-th window in Im1 
NCC_matrix = (Mat_feat_2'*Mat_feat_1)/((window_length^2)-1);

%set all NCC_matrix (<min_corr) to 0
NCC_matrix(NCC_matrix<min_corr) = 0;

%sort the NCC_matrix and delete all the 0
%the higher value of sorted_index indicates that the correspondence of
%those two feature is higher
%sorted is the intensity of the corrspondence
%sorted_ index is the position of those correspondences
[sorted,sorted_index] = sort(NCC_matrix(:),'descend');
sorted_index(sorted==0) = [];

%% 2.5 Correspondence Matrix

%find all non-zero correspondence in NCC-Matrix
for i=1:size(sorted_index,1)
    %calculate the position
    if mod(sorted_index(i),size(NCC_matrix,1)) == 0
        %if sorted_index(i)/size(NCC_matrix,1) has no reminder
        %that means that this one is on the last column of NCC_matrix
        NCC_array(i) = size(NCC_matrix,1); %#ok<*AGROW> 
        NCC_column(i) = sorted_index(i)/size(NCC_matrix,1);
    else
        NCC_array(i) = mod(sorted_index(i),size(NCC_matrix,1));
        NCC_column(i) = fix(sorted_index(i)/size(NCC_matrix,1))+1;
    end
end

%pre-allocation for cor
cor = zeros(4,size(sorted_index,1));

%find corresponding features in two images
%how many corresponding features can be found at maximum?
for i=1:size(sorted_index,1)
    %we only examine those non-zero points
    if NCC_matrix(NCC_array(i),NCC_column(i))~=0
        %extract NCC_colunmn(i)-th feature's coordinates from Ftp1&Ftp2
        cor(1:2,i) = Ftp1(:,NCC_column(i));
        cor(3:4,i) = Ftp2(:,NCC_array(i));
        %set all values at the same column to 0
        %we don't exam them to make sure that only one feature in image 2
        %can be matched with the current point in image 1
        NCC_matrix(:,NCC_column(i)) = 0;
    end
end

%delete all the zero-column
cor(:,all(cor==0)) = [];

%% Plot

if do_plot
    Image = I1*0.5+I2*0.5;
    figure(1)
    imshow(Image)
    hold on
    plot(cor(1,:),cor(2,:),'og',cor(3,:),cor(4,:),'oy');
    hold on
    for i=1:size(cor,2)
        point_im1 = [cor(1,i),cor(3,i)];
        point_im2 = [cor(2,i),cor(4,i)];
        line(point_im1,point_im2,'b')
    end
end

end