%% Homework 3

function [correspondences_robust] = F_ransac(correspondences,varargin)

%% 3.3 RanSaC Input Parameter

q = inputParser;

default_val_epsilon = 0.5;
addParameter(q,'epsilon',default_val_epsilon,@(x) isnumeric(x)&&x>0&&x<1)
default_val_p = 0.5;
addParameter(q,'p',default_val_p,@(x) isnumeric(x)&&x>0&&x<1)
default_val_tolerance = 0.01;
addParameter(q,'tolerance',default_val_tolerance,@(x) isnumeric(x))

q.parse(varargin{:})

epsilon = q.Results.epsilon;
p = q.Results.p;
tolerance = q.Results.tolerance;

%get the coordinates of the correspondece pairs
x1_pixel = correspondences(1:2,:);
x2_pixel = correspondences(3:4,:);

%change the coordinates of correspondences into homogene coordinate
x1_pixel(3,:) = 1;
x2_pixel(3,:) = 1;

%% 3.4 RanSaC Processing

%number of required points
k = 8;
%iteration number
s = log(1-p)/log(1-(1-epsilon)^k);
%initial number of correspondences
largest_set_size = 0;
%initial Sampson-distance
largest_set_dist = inf;
%initial Fundamental-matrix
largest_set_F = zeros(3);

%% 3.6 RanSaC Algorithm

for i=1:s
    
    %create a random array, which indicates which corresponding pair to
    %choose
    %which_column = randi([1,size(correspondences,2)],1,k);
    which_column = randperm(size(correspondences,2));
    which_column = which_column(1:8);
    correspondences_chosen = correspondences(:,which_column);
    %calculate the Fundamental-matrix from the chosen pairs
    F = epa(correspondences_chosen);

    %calculate all Sampson distance with the Fundamental-matrix
    sd = sampson_dist(F,x1_pixel,x2_pixel);
    
    %sort the sd
    %whereby the sorted includes the sorted data in sd,
    %and sorted_index shows the position
    [sorted,sorted_index] = sort(sd);
    sd_sorted = [sorted;sorted_index];
    %cancel the pairs over thereshold
    sd_sorted(:,sd_sorted(1,:)>=tolerance) = [];

    %calculate the number of selected pairs
    num_corr = size(sd_sorted,2);
    %and the absolute Sampson distance
    abs_sam_dist = sum(sd_sorted(1,:));
    if num_corr>largest_set_size
        largest_set_size = num_corr;
        largest_set_F = F;
        correspondences_robust = correspondences(:,sd_sorted(2,:));
    elseif num_corr == largest_set_size && abs_sam_dist<largest_set_dist
        largest_set_dist = abs_sam_dist;
        largest_set_F = F;
        correspondences_robust = correspondences(:,sd_sorted(2,:));
    end
end

end