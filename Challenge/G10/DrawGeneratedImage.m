function [GeIm] = DrawGeneratedImage(estimatedVertex,foreObj,Realimage,OrIm, rough_coefficient, foreObj_flag)

global invisCe %#ok<*GVMIS> 
global invisFl 
global invisRw
global invisLw
 
GeIm1 = zeros(size(OrIm,1),size(OrIm,2),size(OrIm,3));
GeIm2 = zeros(size(OrIm,1),size(OrIm,2),size(OrIm,3));
GeIm3 = zeros(size(OrIm,1),size(OrIm,2),size(OrIm,3));
GeIm4 = zeros(size(OrIm,1),size(OrIm,2),size(OrIm,3));
GeIm5 = zeros(size(OrIm,1),size(OrIm,2),size(OrIm,3)); %#ok<*PREALL> 
GeIm6 = zeros(size(OrIm,1),size(OrIm,2),size(OrIm,3)); %#ok<*NASGU> 

% Draw generated image after R,T.

% Variables



%     rough_coefficient ; % Resolution（preview: 0.05, lowresolution: 0.01, normal:0.005, highresolution: 0.001）(global variable 的可能性)
% OrIm % Should be a rows by cols by 3 matrix. ouble format.

%     worldVertex;             % 3D coordinate of mesh vertices after transform. [x,y,z]     
                               % local variable independent in every single
                               % mesh
                               % anticlockwise counting the points
%     screenVertex;              % 2D coordinate of mesh vertices.[sx,sy]
%     EstimatedVertex;          % 5D coordinate of Vertices from 5 planes (1-13), before RT.[sx;sy;x;y;z] % global
%     GravityPoint3D;           % Gravity point of every mesh in 3D, after RT. local
%     GravityPoint2D;           % transform Gravity Point from 3D to 2D. local
%     ColorofGravityPoint;      % get color of the Gravity Point. local


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

EstimatedVertex1(3:5,:) = estimatedVertex(1:3,:);
EstimatedVertex1(1:2,:) = estimatedVertex(4:5,:);
EstimatedVertex = EstimatedVertex1;



if invisFl == 0
GeIm1 = drawfloor(EstimatedVertex,rough_coefficient,OrIm);
end
if invisCe == 0
GeIm2 = drawceiling(EstimatedVertex,rough_coefficient,OrIm);
end
if invisLw == 0
GeIm3 = drawleftwall(EstimatedVertex,rough_coefficient,OrIm);
end
if invisRw == 0
GeIm4 = drawrightwall(EstimatedVertex,rough_coefficient,OrIm);
end


GeIm5 = drawrearwall(EstimatedVertex,rough_coefficient,OrIm);
if foreObj_flag

GeIm6 = drawforeobj(foreObj,rough_coefficient,Realimage);

k = find(GeIm6);

GeIm = GeIm1+GeIm2+GeIm3+GeIm4+GeIm5;
GeIm(k) = 0; %#ok<FNDSB> 

GeIm = GeIm+GeIm6;

  
else 
    GeIm = GeIm1+GeIm2+GeIm3+GeIm4+GeIm5;
end
            

    imshow(GeIm)
end

