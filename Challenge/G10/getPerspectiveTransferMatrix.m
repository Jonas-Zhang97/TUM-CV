% Obtaining the viewpoint and perspective transformation matrices
function [eye,mat] = getPerspectiveTransferMatrix()
    %load("BspRes_Build3DModel3.mat");     
    global R
    global eye
    global mat
    global estimatedVertex
    global theta phi
    %global theta1 phi1
    global invisLw
    global invisRw
    global invisCe
    global invisFl
    invisLw = 0;
    invisRw = 0;
    invisCe = 0;
    invisFl = 0;
    %theta = 0;
    %phi = 0;
    eye = zeros(3,1);
    theta1 = theta / 360 * 2 * pi;
    phi1 = phi / 360 * 2 * pi;
    st = sin(theta1); ct = cos(theta1);
    sp = sin(phi1); cp = cos(phi1);
    % Obtaining the world coordinates of the viewpoint
    eye(1,1) = R * st * cp + estimatedVertex(1,1);
    eye(2,1) = R * sp + estimatedVertex(2,1);
    eye(3,1) = R * ct * cp + estimatedVertex(3,1);
    % if Lw Rw Ce Fl invisible or not
    if eye(1,1) <= estimatedVertex(1,6)
        invisRw = 1;
    elseif eye(1,1) >= estimatedVertex(1,7)
        invisLw = 1;
    end
    if eye(2,1) >= estimatedVertex(2,10)
        invisCe = 1;
    elseif eye(2,1) <= estimatedVertex(2,4)
        invisFl = 1;
    end
    % Obtaining the perspective transformation matrix
    mat(1,1) = ct;          mat(1,2) = 0;       mat(1,3) = st;
    mat(2,1) = st * sp;     mat(2,2) = cp;      mat(2,3) = -ct * sp;
    mat(3,1) = -st * cp;    mat(3,2) = sp;      mat(3,3) = ct * cp;
end