
% syms Z_m
step = 0.001; % Simulation step
%% Parameters
W_TR = 1.65; % Rear track width

%% Tyre radius
r = 22*0.0254/2 + 0.35*0.325;

%% Suspension travel
Z_m = -0.05:step:0.05; %% meters
Z_inch = Z_m/0.0254;

%% Camber change

gamma = Z_m.*(-19+Z_m*(-68.2)); %% Camber (degree). Z (m)
gamma_change = - (682*Z_m)/5 - 19; %% (º/m)

gamma_inch = Z_inch*0.0254.*(-19+Z_inch*0.0254*(-68.2)); %% Camber (degrees). Z (inch)
gamma_inch_change = - (5499989*Z_inch)/62500000 - 2413/5000; %% camber change, (º/inch)

fvsa_inch = 1./tan(gamma_inch_change*pi/180);
fvsa_m = fvsa_inch*0.0254; % For Z=0, fsva is approximately -3m
i_z_0 = 0.05/step + 1;
fvsa = fvsa_m(i_z_0); % fvsa for z=0m

%% Lateral precesion
Y = Z_m.*(2.13 + Z_m*(-132))/100; %% meters

Y_slope =@(Z_m) 213/10000 - (66*Z_m)/25; % dY/dZ_m
Z_slope =@(Z_m) 1/Y_slope(Z_m); % dZ_m/dY
slope_z_0 = Z_slope(0); % dZ_m/dY(Z=0)
slope_arm = -1/slope_z_0; % slope of the line that defines the direction of
% the front view swing arm. It is perpendicular to the curve at Z=0
line_arm = slope_arm.*[-2:step:0]; % Equation of the direction of the swing
% arm. Just necessary to plot it

%% Plots

figure (1)
clf
subplot(2,2,1)
plot(Z_m, gamma)
xlabel('Z(m)')
ylabel('gamma(º)')
title('camber angle vs suspension travel')
grid on

subplot(2,2,2)
plot(Z_m, fvsa_m)
xlabel('Z(m)')
ylabel('fvsa(m)')
title('fv swing arm length')
grid on

subplot(2,2,3)
plot(Y, Z_m)
hold
plot([-2:step:0], line_arm)
xlabel('Y(m)')
ylabel('Z(m)')
xlim([-0.05 0.05])
ylim([-0.05 0.05])
legend('Trajectory of the wheel','Swing arm direction')
% xlim([-0.004 0.0002])
% % ylim([-0.05 0.05])
grid on

%% Roll centre position

% Intersection of the perpendicular line to the curve and a circle with R
% equal to 3m (fvsa(Z=0)):
IC_y = -sqrt((fvsa)^2/(1+slope_arm^2));
IC_z = slope_arm*IC_y;

m_line = (-r - IC_z)/(-IC_y); % equation of the line passing through the
% instant centre of the wheel and the contact patch of the tyre

RC_z_rel = m_line*(-W_TR)/2 - r; % vertical position of the roll centre (intersecting 
% the line with the middle plane 
RC_z = RC_z_rel + r; % vertical position of the roll centre from the ground

RC_z_r = RC_z;
% save RC.mat RC_z_r

