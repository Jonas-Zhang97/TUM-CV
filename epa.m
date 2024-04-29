%% Homework 3

function [EF] = epa(correspondences,varargin)

%% 3.1 Eight-Point Algorithm Part 1

%get the coordinates of the correspondece pairs
x1 = correspondences(1:2,:);
x2 = correspondences(3:4,:);

%change the coordinates of correspondences into homogene coordinate
x1(3,:) = 1;
x2(3,:) = 1;

if exist('K','var')
    %if calibrating matrix is given, calibrate the correspondences
    x1 = K^(-1)*x1;
    x2 = K^(-1)*x2;
end

%calculating a with the kroneck product
%it is wrong with a = kron(x1,x2);
%another approch
a(1:3,:) = [x1(1,:).*x2];
a(4:6,:) = [x1(2,:).*x2];
a(7:9,:) = [x1(3,:).*x2];

%pre-allocation for A
size_a = size(a);   %which definitly has 9 arrays
A = zeros(size_a(2),size_a(1));
for i=1:size_a(2)
    %filling A
    A(i,:) = a(:,i)';
end

%singular value decomposition
[~,~,V] = svd(A);

%% 3.2 Eight-Point Algorithm Part 2

%build the G matrix
Gs = V(:,9);
G(:,1) = Gs(1:3);
G(:,2) = Gs(4:6);
G(:,3) = Gs(7:9);

%singular value decomposition
[U_G,S_G,V_G] = svd(G);
S_G_diag = diag(S_G);

%calculate the Essential-Matrix or Fundamanetal-Matrix
if exist('K','var')
    %for case that K is given, calculate the Essential-Matrix
    EF = U_G*[1 0 0;0 1 0;0 0 0]*V_G';
else
    %for case that K is not given, calculate the Fundamental-Matrix
    EF = U_G*diag([S_G_diag(1);S_G_diag(2);0])*V_G';
end
end