function [GeIm] = drawrightwall(EstimatedVertex,rough_coefficient,OrIm)

% Variables

% rough_coefficient % Resolution（preview: 0.05, lowresolution: 0.01, normal:0.005, highresolution: 0.001）(global variable 的可能性)
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
worldVertex = zeros(3,4);
GravityPoint3D = zeros(3,1);
NewImage = zeros(size(OrIm,1),size(OrIm,2),size(OrIm,3));
GeIm = NewImage;
screenVertex = zeros(2,4);
screenPixelVertex = zeros(2,4);
    %% right wall (y:2~8, z:2~6)
    % vertices 2,6,12,8
    worldVertex(1,:) = EstimatedVertex(3,3); % Vertices of the mesh on the same plane (X = 1);

    for k = EstimatedVertex(4,3):rough_coefficient:EstimatedVertex(4,9) % from y2 to y8

        worldVertex(2,[1,2]) = k; % y of 1. and 2. point of the mesh equals to k (2,6)
        worldVertex(2,[3,4]) = k + rough_coefficient; % y coordinate of 3. and 4. should be k + Coeff. (12,8)

        for l = EstimatedVertex(5,3):rough_coefficient:EstimatedVertex(5,7) % from z2 to z6

            worldVertex(3,[1,4]) = l; % z of 1. and 4. is l. (2,8)
            worldVertex(3,[2,3]) = l+rough_coefficient; % z of 2. and 3. is l + Coeff. (6,12)

            for i = 1:1:4   % get post 2D mesh coordi.
                screenVertex(:,i) = getScreenCoordinates(worldVertex(:,i));
            end

            % get gravitypoint in 3D of every unit
            GravityPoint3D(1,1) = (worldVertex(1,1)+worldVertex(1,3))/2; % x
            GravityPoint3D(2,1) = (worldVertex(2,1)+worldVertex(2,3))/2; % y
            GravityPoint3D(3,1) = (worldVertex(3,1)+worldVertex(3,3))/2; % z

            % convert gravitypoint from post 3D to pre 2D
            GravityPoint2D = getInitialScreenCoordinates(GravityPoint3D);

            % Get color from original image of the GravityPoint, 1x1x3
            ColorGravityPoint = screenCoordinates2sourceImageColor(GravityPoint2D,OrIm);

            for j = 1:1:4
                screenPixelVertex(:,j) = getPixelCoordinate(screenVertex(:,j),OrIm); % [x;y]
            end
                screenPixelx = screenPixelVertex(1,:);
                screenPixely = screenPixelVertex(2,:);
            % set color to the new image
                NewImage = setColor(screenPixelx,screenPixely,size(OrIm,1),size(OrIm,2),ColorGravityPoint,OrIm);
                GeIm = GeIm+NewImage;
%                 imshow(GeIm)
%             NewImage(screenPixelVertex(2,1):screenPixelVertex(2,2),screenPixelVertex(1,1):screenPixelVertex(1,4),1) = ColorGravityPoint(:,:,1);
%             NewImage(screenPixelVertex(2,1):screenPixelVertex(2,2),screenPixelVertex(1,1):screenPixelVertex(1,4),2) = ColorGravityPoint(:,:,2);
%             NewImage(screenPixelVertex(2,1):screenPixelVertex(2,2),screenPixelVertex(1,1):screenPixelVertex(1,4),3) = ColorGravityPoint(:,:,3);
        end
    end
            
end

