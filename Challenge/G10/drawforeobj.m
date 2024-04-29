function [GeIm] = drawforeobj(foreObj,rough_coefficient,OrIm)

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
%% foreobj
    % vertices 1,2,7,8
    worldVertex(3,:) = foreObj(3,1); % Z same;

    for k = foreObj(2,4):rough_coefficient:foreObj(2,1) % from y4 to y1

        worldVertex(2,[1,2]) = k; % y of 1. and 2. point of the mesh equals to k  (1,2)
        worldVertex(2,[3,4]) = k + rough_coefficient; % y coordinate of 3. and 4. should be k + Coeff. (3,4)

        for l = foreObj(1,4):rough_coefficient:foreObj(1,3) % from x4 to x3

            worldVertex(1,[1,4]) = l; % x of 1. and 4. is l. (1,7)
            worldVertex(1,[2,3]) = l+rough_coefficient; % x of 2. and 3. is l + Coeff. (2,8)

%             for i = 1:1:4   % get post 2D mesh coordi.
                screenVertex = getScreenCoordinates(worldVertex);
%             end

            % get gravitypoint in 3D of every unit
            GravityPoint3D(1,1) = (worldVertex(1,1)+worldVertex(1,3))/2; % x
            GravityPoint3D(2,1) = (worldVertex(2,1)+worldVertex(2,3))/2; % y
            GravityPoint3D(3,1) = (worldVertex(3,1)+worldVertex(3,3))/2; % z

            % convert gravitypoint from post 3D to pre 2D
            GravityPoint2D = getInitialScreenCoordinates(GravityPoint3D);

            % Get color from original image of the GravityPoint, 1x1x3
            ColorGravityPoint = screenCoordinates2sourceImageColor(GravityPoint2D,OrIm);

%             for j = 1:1:4
                screenPixelVertex = getPixelCoordinate(screenVertex,OrIm); % [x;y]
%             end
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

