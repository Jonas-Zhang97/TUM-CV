%% Homework 3

%% 3.5 Sampson Distance
function sd = sampson_dist(F,x1_pixel,x2_pixel)
%definition of the screw matrix of e_3
hat_e_3 = [0 -1 0;1 0 0;0 0 0];

%calculate the sd
pseudo_sd_numerator = x2_pixel'*F*x1_pixel;
sd_numerator = diag(pseudo_sd_numerator).^2;
sd_denominator_I = sum((hat_e_3*F*x1_pixel).^2)';
sd_denominator_II = sum((x2_pixel'*F*hat_e_3).^2,2);
sd_denominator = sd_denominator_I+sd_denominator_II;
sd = sd_numerator./sd_denominator;
end