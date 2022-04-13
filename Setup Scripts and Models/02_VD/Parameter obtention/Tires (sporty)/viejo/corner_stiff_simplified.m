clear
clc

%% Weight distribution
m_front_total_ratio = 0.532;
FzT = 2500*9.81;

FzF = FzT*m_front_total_ratio; %% Vertical load at the front, N
FzR = FzT - FzF; %% Vertical load at the rear, N


%% Pacejka magic formula. Front

% B = 7; %% stiffness factor
% C = 1.5; %% shape factor
% D = 9; %% peak value

mu_peak_f = 1.37 - FzF*0.026/1000;
mu_90_deg_f = 0.723*mu_peak_f;

Bf = 20; %% stiffness factor
Cf = 1.515; %% shape factor
Df = mu_peak_f; %% peak value
% if Df<Dr understeer

Ef = 0.8; %% Curvature factor
% syms alpha_f
alpha_f = 0:0.001:0.2;
% alpha_f = 0:0.001:1.571;
% mu_y_f = Df.*sin(Cf.*atan(Bf*alpha_f - Ef*(Bf*alpha_f - atan(Bf*alpha_f))));
mu_y_f = Df*sin(Cf*atan(Bf*alpha_f));
% nf = diff(mu_y_f)
n_f = (351644853863314359.*cos((303.*atan(20.*alpha_f))./200))./(11258999068426240.*(400.*alpha_f.^2 + 1));
C_f = n_f*FzF;

%% Plots. Front

figure(1)
clf
subplot(1,3,1)
plot(alpha_f, mu_y_f)
title('mu_y Front')
xlabel('slip angle (rad)')
ylabel('mu_y Front')
grid on

subplot(1,3,2)
plot(alpha_f, n_f)
title('nf')
xlabel('slip angle (rad)')
ylabel('nf (1/rad)')
grid on

subplot(1,3,3)
plot(alpha_f, C_f)
title('Cf')
xlabel('slip angle (rad)')
ylabel('Cf (N/rad)')
grid on




%% Pacejka magic formula. Rear



mu_peak_r = 1.38 - FzR*0.0232/1000;
mu_90_deg_r = 0.723*mu_peak_r;

Br = 20; %% stiffness factor
Cr = 1.515; %% shape factor
Dr = mu_peak_r; %% peak value
% if Df<Dr understeer

Ef = 0.8; %% Curvature factor
% syms alpha_r
alpha_r = 0:0.001:0.2;
% alpha_r = 0:0.001:1.571;
% mu_y_f = Df.*sin(Cf.*atan(Bf*alpha_f - Ef*(Bf*alpha_f - atan(Bf*alpha_f))));
mu_y_r = Dr*sin(Cr*atan(Br*alpha_r));
% nf = diff(mu_y_r)
n_r = (379942084377522939.*cos((303.*atan(20.*alpha_r))./200))./(11258999068426240.*(400.*alpha_r.^2 + 1));
C_r = n_r*FzF;

%% Plots. Rear

figure(2)
clf
subplot(1,3,1)
plot(alpha_r, mu_y_r)
title('mu_y Rear')
xlabel('slip angle (rad)')
ylabel('mu_y Rear')
grid on

subplot(1,3,2)
plot(alpha_r, n_r)
title('nr')
xlabel('slip angle (rad)')
ylabel('nr (1/rad)')
grid on

subplot(1,3,3)
plot(alpha_r, C_r)
title('Cr')
xlabel('slip angle (rad)')
ylabel('Cr (N/rad)')
grid on

%% Approximate values of Cf and Cr (for the linear bicycle model)

Cf_lin = C_f(0.03/0.001 + 1);
Cr_lin = C_r(0.03/0.001 + 1); %% Stiffnesses at 0.03 rad (1.7º) slip angle

