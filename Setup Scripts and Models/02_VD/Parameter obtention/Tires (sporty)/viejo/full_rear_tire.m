clear
clc

step = 0.001;
%% Weight distribution
m_front_total_ratio = 0.532;
FzT = 2500*9.81;

FzF_0 = (FzT*m_front_total_ratio); %% Static Vertical load at the front axle
FzR_0 = (FzT - FzF_0); %% Static Vertical load at the rear axle

FzF_0 = FzF_0/2;
FzR_0 = FzR_0/2;


FzF = [0:2000:12000]';
FzR = [0:2000:12000]';

dfzF = (FzF - FzF_0)/FzF_0;

%% Pacejka magic formula. Pure sideslip. Rear wheel.



mu_y_peak_r = 1.38 - FzR*0.0232/1000;
mu_y_90_deg_r = 0.723*mu_y_peak_r;

By_r = 13; %% stiffness factor. Gives maximum mu for alpha = 6º for the static front tyre load.
Cy_r = 1.51253; % Makes mu_max/mu_90_deg=0.723 for static front tyre load
Dy_r = mu_y_peak_r; %% peak value. If Df<Dr understeer
Ey_r = FzR*(0.5+2)/12000 - 2; %% Curvature factor. Linear variation from Fz = 0KN to 12KN
% alpha_r = 0:0.001:0.2;
alpha_r = 0:step:1.571;
alpha_r_deg = alpha_r*180/pi;
mu_y_r = Dy_r.*sin(Cy_r.*atan(By_r*alpha_r - Ey_r*(By_r*alpha_r - atan(By_r*alpha_r))));
n_r = (Cy_r.*Dy_r.*cos(Cy_r.*atan(By_r.*alpha_r + Ey_r.*(atan(By_r.*alpha_r) - By_r.*alpha_r))).*(By_r - Ey_r.*(By_r - By_r./(By_r.^2.*alpha_r.^2 + 1))))./((By_r.*alpha_r + Ey_r.*(atan(By_r.*alpha_r) - By_r.*alpha_r)).^2 + 1);
C_r = n_r.*FzR;

percentage_r = mu_y_r(:,length(alpha_r))./mu_y_90_deg_r % mu(90º)/mu(90º)desired

%% Plots. Rear

figure(2)
clf
subplot(3,1,1)
hold
for i = 1:length(FzR)
    plot(alpha_r, mu_y_r(i,:))
    
end
title('mu_y Rear')
xlabel('slip angle (rad)')
ylabel('mu_y Rear')
grid on




subplot(3,1,2)
hold
for i = 1:length(FzR)
    plot(alpha_r, n_r(i,:))
    
end
title('nr')
xlabel('slip angle (rad)')
ylabel('nr (1/rad)')
grid on

subplot(3,1,3)
hold
for i = 1:length(FzR)
    plot(alpha_r, C_r(i,:))
    
end
title('Cr')
xlabel('slip angle (rad)')
ylabel('Cr (N/rad)')
grid on

%% Approximate values of Cf and Cr (for the linear bicycle model)

% Cf_lin = C_f(0.03/0.001 + 1);
% Cr_lin = C_r(0.03/0.001 + 1); %% Stiffnesses at 0.03 rad (1.7º) slip angle

Cf_lin = 1.205984111859764e+05;
Cr_lin = 1.117631261866039e+05;

