% Obtaining the screen coordinates of the estimated vertex after perspective transformation
function transferedEstimatedVertex = getTransferedEstimatedVerticesScreenCoordinates()
        
    global transferedEstimatedVertex
    global estimatedVertex
    global oevminx  oevminy oevdiffx oevdiffy
    global tevminx tevmaxx tevminy tevmaxy tevdiffx tevdiffy
    global tevminx0 tevmaxx0 tevminy0 tevmaxy0 tevdiffx0 tevdiffy0
    global mat
    global R
    global deduceFlag
    global given_foreobj    
    global foreObj
    global transferedForeObj
    
    %deduceFlag = 0;
    inte = zeros(3,1);
    diff = zeros(3,1);
    for i = 1 : 12
        diff(1,1) = estimatedVertex(1,i+1) - estimatedVertex(1,1);
        diff(2,1) = estimatedVertex(2,i+1) - estimatedVertex(2,1);
        diff(3,1) = estimatedVertex(3,i+1) - estimatedVertex(3,1);
        inte = mat * diff;
        transferedEstimatedVertex(1,i+1) = R * inte(1,1) / (R - inte(3,1));
        transferedEstimatedVertex(2,i+1) = R * inte(2,1) / (R - inte(3,1));
    end
    transferedEstimatedVertex(2,9) = 1;
    transferedEstimatedVertex(2,8) = 1;
    if given_foreobj == true
        for i = 1 : 4
            diff(1,1) = foreObj(1,i) - estimatedVertex(1,1);
            diff(2,1) = foreObj(2,i) - estimatedVertex(2,1);
            diff(3,1) = foreObj(3,i) - estimatedVertex(3,1);
            inte = mat * diff;
            transferedForeObj(1,i) = R * inte(1,1) / (R - inte(3,1));
            transferedForeObj(2,i) = R * inte(2,1) / (R - inte(3,1));
        end
    end
    % Obtaining variables for consistency of perspective transformations
    tevminx = 1.0; tevmaxx = -1.0; tevminy = 1.0; tevmaxy = -1.0;
    for i = 1 : 12
        if transferedEstimatedVertex(1,i+1) < tevminx
            tevminx = transferedEstimatedVertex(1,i+1);
        elseif transferedEstimatedVertex(1,i+1) > tevmaxx
            tevmaxx = transferedEstimatedVertex(1,i+1);
        end
        if transferedEstimatedVertex(2,i+1) < tevminy
            tevminy = transferedEstimatedVertex(2,i+1);
        elseif transferedEstimatedVertex(2,i+1) > tevmaxy
            tevmaxy = transferedEstimatedVertex(2,i+1);
        end
    end
    tevdiffx = tevmaxx - tevminx; tevdiffy = tevmaxy - tevminy;
    if deduceFlag ~= 1
        tevminx0 = 1.0; tevmaxx0 = -1.0; tevminy0 = 1.0; tevmaxy0 = -1.0;
        for i = 1 : 12
            if transferedEstimatedVertex(1,i+1) < tevminx0
                tevminx0 = transferedEstimatedVertex(1,i+1);
            elseif transferedEstimatedVertex(1,i+1) > tevmaxx0
                tevmaxx0 = transferedEstimatedVertex(1,i+1);
            end
            if transferedEstimatedVertex(2,i+1) < tevminy0
                tevminy0 = transferedEstimatedVertex(2,i+1);
            elseif transferedEstimatedVertex(2,i+1) > tevmaxy0
                tevmaxy0 = transferedEstimatedVertex(2,i+1);
            end
        end
        tevdiffx0 = tevmaxx0 - tevminx0; tevdiffy0 = tevmaxy0 - tevminy0;
    end

    % Consistency of perspective transformation
    for i = 1 : 12
        transferedEstimatedVertex(1,i+1) = (transferedEstimatedVertex(1,i+1) - tevminx) / tevdiffx;
        transferedEstimatedVertex(2,i+1) = (transferedEstimatedVertex(2,i+1) - tevminy) / tevdiffy;
        transferedEstimatedVertex(1,i+1) = transferedEstimatedVertex(1,i+1) * oevdiffx;
        transferedEstimatedVertex(2,i+1) = transferedEstimatedVertex(2,i+1) * oevdiffy;
        transferedEstimatedVertex(1,i+1) = transferedEstimatedVertex(1,i+1) + oevminx;
        transferedEstimatedVertex(2,i+1) = transferedEstimatedVertex(2,i+1) + oevminy;
    end
    if given_foreobj == true
        for i = 1 : 4
            transferedForeObj(1,i) = (transferedForeObj(1,i) - tevminx) / tevdiffx;
            transferedForeObj(2,i) = (transferedForeObj(2,i) - tevminy) / tevdiffy;
            transferedForeObj(1,i) = transferedForeObj(1,i) * oevdiffx;
            transferedForeObj(2,i) = transferedForeObj(2,i) * oevdiffy;
            transferedForeObj(1,i) = transferedForeObj(1,i) + oevminx;
            transferedForeObj(2,i) = transferedForeObj(2,i) + oevminy;
        end
    end
end