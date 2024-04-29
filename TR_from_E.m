%% Euclidean Movement
function [T1,R1,T2,R2] = TR_from_E(E)

%singular value decomposition of E
[U,S,V] = svd(E);

%check if U and V have a positive determinante
%if not change them
if det(U) == -1
    U = U*[1 0 0;0 1 0;0 0 -1];
elseif det(V) == -1
    V = V*[1 0 0;0 1 0;0 0 -1];
end

%set R_Z
R_Z1 = [0 -1 0;1 0 0;0 0 1];
R_Z2 = [0 1 0;-1 0 0;0 0 1];

%calculate rotation matrices
R1 = U*R_Z1'*V';
R2 = U*R_Z2'*V';

%calculate screw symmetric matrices of T
hat_T_1 = U*R_Z1*S*U';
hat_T_2 = U*R_Z2*S*U';

%reconstruct the
T1 = [-hat_T_1(2,3);hat_T_1(1,3);-hat_T_1(1,2)];
T2 = [-hat_T_2(2,3);hat_T_2(1,3);-hat_T_2(1,2)];

end