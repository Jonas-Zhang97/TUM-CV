% Obtain screen coordinates before deformation
function output = getInitialScreenCoordinates(input)
    global R
    global eye
    global estimatedVertex
    global oevminx oevmaxx oevminy oevmaxy oevdiffx oevdiffy    
    global tevminx0 tevmaxx0 tevminy0 tevmaxy0 tevdiffx0 tevdiffy0
    st = 0; ct = 1;
	sp = 0; cp = 1;
    % Obtaining the world coordinates of the viewpoint
    eye(1,1) = R * st * cp + estimatedVertex(1,1);
    eye(2,1) = R * sp + estimatedVertex(2,1);
    eye(3,1) = R * ct * cp + estimatedVertex(3,1);
    inv = zeros(3,3);
    % Obtaining the perspective transformation matrix
    inv(1,1) = ct;          inv(1,2) = 0;       inv(1,3) = st;
    inv(2,1) = st * sp;     inv(2,2) = cp;      inv(2,3) = -ct * sp;
    inv(3,1) = -st * cp;    inv(3,2) = sp;      inv(3,3) = ct * cp;
    N = size(input,2);
    inte = zeros(3,N);
    diff = zeros(3,N);
    diff(1,:) = input(1,:) - ones(1,N) .* estimatedVertex(1,1);
    diff(2,:) = input(2,:) - ones(1,N) .* estimatedVertex(2,1);
    diff(3,:) = input(3,:) - ones(1,N) .* estimatedVertex(3,1);
    inte(1,:) = inv(1,1) .* diff(1,:) + inv(1,2) .* diff(2,:) + inv(1,3) .* diff(3,:);
    inte(2,:) = inv(2,1) .* diff(1,:) + inv(2,2) .* diff(2,:) + inv(2,3) .* diff(3,:);
    inte(3,:) = inv(3,1) .* diff(1,:) + inv(3,2) .* diff(2,:) + inv(3,3) .* diff(3,:);
    output = zeros(2,N);
    output(1,:) = R .* inte(1,:) ./ (R .* ones(1,N) - inte(3,:));
    output(2,:) = R .* inte(2,:) ./ (R .* ones(1,N) - inte(3,:));
    output(1,:) = (output(1,:) - ones(1,N) .* tevminx0) ./ tevdiffx0;
    output(2,:) = (output(2,:) - ones(1,N) .* tevminy0) ./ tevdiffy0;
    output(1,:) = output(1,:) .* oevdiffx;
    output(2,:) = output(2,:) .* oevdiffy;
    output(1,:) = output(1,:) + ones(1,N) .* oevminx;
    output(2,:) = output(2,:) + ones(1,N) .* oevminy;
end