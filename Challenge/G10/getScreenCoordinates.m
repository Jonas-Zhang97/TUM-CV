% Obtaining screen coordinates
function output = getScreenCoordinates(input)
    global mat
    global R
    global estimatedVertex
    global oevminx oevmaxx oevminy oevmaxy oevdiffx oevdiffy
    global tevminx tevmaxx tevminy tevmaxy tevdiffx tevdiffy
    N = size(input,2);
    inte = zeros(3,N);
    diff = zeros(3,N);
    diff(1,:) = input(1,:) - ones(1,N) .* estimatedVertex(1,1);
    diff(2,:) = input(2,:) - ones(1,N) .* estimatedVertex(2,1);
    diff(3,:) = input(3,:) - ones(1,N) .* estimatedVertex(3,1);
    inte(1,:) = mat(1,1) .* diff(1,:) + mat(1,2) .* diff(2,:) + mat(1,3) .* diff(3,:);
    inte(2,:) = mat(2,1) .* diff(1,:) + mat(2,2) .* diff(2,:) + mat(2,3) .* diff(3,:);
    inte(3,:) = mat(3,1) .* diff(1,:) + mat(3,2) .* diff(2,:) + mat(3,3) .* diff(3,:);
    output = zeros(2,N);
    output(1,:) = R .* inte(1,:) ./ (R .* ones(1,N) - inte(3,:));
    output(2,:) = R .* inte(2,:) ./ (R .* ones(1,N) - inte(3,:));
    output(1,:) = (output(1,:) - ones(1,N) .* tevminx) ./ tevdiffx;
    output(2,:) = (output(2,:) - ones(1,N) .* tevminy) ./ tevdiffy;
    output(1,:) = output(1,:) .* oevdiffx;
    output(2,:) = output(2,:) .* oevdiffy;
    output(1,:) = output(1,:) + ones(1,N) .* oevminx;
    output(2,:) = output(2,:) + ones(1,N) .* oevminy;
end
