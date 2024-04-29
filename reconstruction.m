function [T,R,lambda,P1] = reconstruction(T1,T2,R1,R2,correspondences,K)

%% 4.2 Preparation of Reconstruction

% create two cell arrays
T_cell = {T1,T2,T1,T2};
R_cell = {R1,R1,R2,R2};

% transform the correspondences into homogene coordinates
num_corr = size(correspondences,2);
x1 = correspondences(1:2,:);
x1(3,:) = ones(1,num_corr);
x2 = correspondences(3:4,:);
x2(3,:) = ones(1,num_corr);

% calibration of the correspondences
x1 = K\x1;
x2 = K\x2;

% initialize d_cell with zeros
d_cell = {zerod(num_corr,2),zeros(num_corr,2),zeros(num_corr,2),zeros(num_corr,2)};

%% 4.3 Reconstruction System of Equation

% how many correspondeces paars are there?
num_corr = size(correspondences,2);

%pre-allocation for all varible needed to

M1 = zeros(3*num_corr,num_corr+1,4);
M2 = M1;

for i=1:4
    % compute all the elements in M1
    M1_diag = M1_diagonal(R_cell{i},x1,x2,num_corr);
    M1_lc = M1_last_column(T_cell{i},x2,num_corr);
    % build M1 and save it in i-th layer of M1
    M1(:,:,i) = build_M(M1_diag,M1_lc,num_corr);

    % compute all the elements in M2
    M2_diag = M2_diagonal(R_cell{i},x1,x2,num_corr);
    M2_lc = M2_last_column(x1,R_cell{i},T_cell{i},num_corr);
    % build M2 and save it in i-th layer of M2
    M2(:,:,i) = build_M(M2_diag,M2_lc,num_corr);

    % find d1 & d2 for M1 & M2
    d1 = build_d(M1(:,:,i));
    d2 = build_d(M2(:,:,i));
    % save them in d_cell
    d_cell{i}=[d1,d2];
end

selected = find_most_positive(d_cell);

M1 = M1(:,:,selected);
M2 = M2(:,:,selected);
R = R_cell{selected};
T = T_cell{selected};
lambda = d_cell{selected};

%% 4.4 Visualiztion

num_corr = size(x1,2);

% extract lambda1 from lambda
lambda1 = lambda(:,1);
% pre-allocation for P1
P1 = zeros(3,num_corr);
% calculate P1 from lambda1 and x1
for i=1:num_corr
    P1(:,i) = lambda1(i,1).*x1(:,i);
end

% plot the world coordinates
figure(1)
for i=1:num_corr
    q = num2str(i);
    scatter3(P1(1,i),P1(2,i),P1(3,i));
    hold on
    text(P1(1,i),P1(2,i),P1(3,i),q);
    hold on
end

% four corners of the first camera
camC1 = [-0.2 0.2 0.2 -0.2;0.2 0.2 -0.2 -0.2;1 1 1 1];
% using euklidean movment to find the second camera
camC2 = R\(camC1-T);
% plot the cameras
figure(1)
plot3(camC1(1,:),camC1(2,:),camC1(3,:),'b');
hold on
text(camC1(1,:),camC1(2,:),camC1(3,:),'Cam1','Color','blue');
hold on
plot3(camC2(1,:),camC2(2,:),camC2(3,:),'r');
hold on
text(camC2(1,:),camC2(2,:),camC2(3,:),'Cam2','Color','red');
campos([43 -22 -87]);
camup([0 -1 0]);
hold on
xlabel('X')
hold on
ylabel('Y')
hold on
zlabel('Z')
hold on
grid on
end

%% Assistance Functions

function M1_diag = M1_diagonal(R,x1,x2,num_corr)
% calculate all elements on the diagonal of M1 matrix
% return as a 3xN matrix
M1_diag = zeros(3,num_corr);
for i=1:num_corr
    M1_diag(:,i) = hat(x2(:,i))*R*x1(:,i);
end
end

function M1_lc = M1_last_column(T,x2,num_corr)
% calculate the last column of M1
M1_lc = zeros(3,num_corr);
for i=1:num_corr
    M1_lc(:,i) = hat(x2(:,i))*T;
end
M1_lc = reshape(M1_lc,[3*num_corr,1]);
end

function M2_diag = M2_diagonal(R,x1,x2,num_corr)
%calculate the diagonal elements on M2 as a 3xN matrix
M2_diag = zeros(3,num_corr);
for i=1:num_corr
    M2_diag(:,i) = hat(x1(:,i))*R'*x2(:,i);
end
end

function M2_lc = M2_last_column(x1,R,T,num_corr)
M2_lc = zeros(3,num_corr);
for i=1:num_corr
    M2_lc(:,i) = -hat(x1(:,i))*R'*T;
end
M2_lc = reshape(M2_lc,[3*num_corr,1]);
end

function M = build_M(M_diag,M_lc,num_corr)
% build M matrix from computed data
% firstly arrange the elements on the semi-diagonal
M = zeros(3*num_corr,num_corr+1);
for i=1:num_corr
    M(i*3-2:i*3,i) = M_diag(:,i);
end
% add the last column
M(:,num_corr+1) = M_lc;
end

function hat_x = hat(x)
% change a column vector to a skew-symmetric matrix
s = size(x);
if s(1)==3 && s(2)==1   %3x1-vector
    hat_x = [0 -x(3,1) x(2,1);x(3,1) 0 -x(1,1);-x(2,1) x(1,1) 0];
else   %the rest, cant't handle
    error('Variable w has to be a 3-component vector!')
end
end

function d = build_d(M)
% calculate normalized d without the last element gamma
% solve the minimization problem using SVD
[~,~,V] = svd(M);
% the last column of V shall be the solution
n = size(V,2);
d = V(:,n);
% determine the position of gamma
size_d = size(d,1);
% normalize the d
d = (1/d(size_d,1)).*d;
% delete gamma
d(size_d) = [];
end

function most_positive = find_most_positive(d_cell)
% determine the most positive layer
num_pos = zeros(1:4);
for i=1:4
    % count positive elements
    positive_position = find(d_cell{i}>0);
    num_pos(i) = length(positive_position);
end
% which combination has the most positive elements
[~,most_positive] = max(num_pos);
end