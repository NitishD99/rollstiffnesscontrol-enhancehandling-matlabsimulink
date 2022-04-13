clear
clc

load RC
% rc_front
% rc_rear
% save RC.mat RC_z_f RC_z_r

%% CoG Position
distr = (53.2/(100 - 53.2)); % = Zf/Zr   weigth distribution
L = 3.06; % wheelbase
b = distr*L/(1 + distr); % lr
a = L - b; % lf

%% RC height at the CoG
m = (RC_z_f - RC_z_r)/(a + b);
RC_z_CoG = m*b + RC_z_r; % Position of the roll centre in respect to the ground

%% Roll distance. Distance between CoG and roll centre
hs = 0.642 - RC_z_CoG;