clear
clc
r_F = 22*0.0254/2 + 0.4*0.285;
r_R = 22*0.0254/2 + 0.35*0.325;
step = 0.001;
%% Weight distribution
m_front_total_ratio = 0.532;
FzT = 2500*9.81;

FzF = FzT*m_front_total_ratio; %% Vertical load at the front, N
FzR = FzT - FzF; %% Vertical load at the rear, N

FzF = FzF/2;
FzR = FzR/2;


% FzF = [2000:2000:12000]';
% FzR = [2000:2000:12000]';

FzF = [2000:2500:12000]';
FzR = [2000:2500:12000]';


%% Pacejka magic formula. Front

mu_peak_f = 1.37 - FzF*0.026/1000;
mu_90_deg_f = 0.723*mu_peak_f;

Bf = 13; %% stiffness factor. Gives maximum mu for alpha = 6º for the static front tyre load.
Cf = 1.515; % Makes mu_max/mu_90_deg=0.723 for static front tyre load
Df = mu_peak_f; %% peak value. If Df<Dr understeer
Ef = FzF*(-2-0.2)/12000 +0.2; %% Sporty tire. Curvature factor. Linear variation from Fz = 0KN to 12KN
% Ef = FzF*(0.5+2)/12000 - 2; %% Before.Curvature factor. Linear variation from Fz = 0KN to 12KN
% alpha_f = 0:0.001:0.2;
alpha_f = -1.571:step:1.571;
alpha_f_deg = alpha_f*180/pi;
mu_y_f = Df.*sin(Cf.*atan(Bf*alpha_f - Ef*(Bf*alpha_f - atan(Bf*alpha_f))));

n_f = (Cf.*Df.*cos(Cf.*atan(Bf.*alpha_f + Ef.*(atan(Bf.*alpha_f) - Bf.*alpha_f))).*(Bf - Ef.*(Bf - Bf./(Bf.^2.*alpha_f.^2 + 1))))./((Bf.*alpha_f + Ef.*(atan(Bf.*alpha_f) - Bf.*alpha_f)).^2 + 1);
C_f = n_f.*FzF;

percentage_f = mu_y_f(:,length(alpha_f))./mu_90_deg_f % mu(90º)/mu(90º)desired

%% Plots. Front

% figure(1)
% clf
% subplot(3,1,1)
% hold
% for i = 1:length(FzF)
%     plot(alpha_f, mu_y_f(i,:))
%     
% end
% title('mu_y Front')
% xlabel('slip angle (rad)')
% ylabel('mu_y Front')
% grid on
% 
% 
% 
% 
% subplot(3,1,2)
% hold
% for i = 1:length(FzF)
%     plot(alpha_f, n_f(i,:))
%     
% end
% title('nf')
% xlabel('slip angle (rad)')
% ylabel('nf (1/rad)')
% grid on
% 
% subplot(3,1,3)
% hold
% for i = 1:length(FzF)
%     plot(alpha_f, C_f(i,:))
%     
% end
% title('Cf')
% xlabel('slip angle (rad)')
% ylabel('Cf (N/rad)')
% grid on

% figure(1)
% clf
% hold
% for i = 1:length(FzF)
%     plot(alpha_f_deg, mu_y_f(i,:))
%     
% end
% title('mu_y Front')
% xlabel('slip angle (º)')
% ylabel('mu_y Front')
% xlim([0 60])
% grid on

% figure(3)
% clf
% hold
% for i = 1:length(FzF)
%     plot(alpha_f_deg, mu_y_f(i,:)*FzF(i))
%     
% end
% title('Fy Front')
% xlabel('slip angle (º)')
% ylabel('Fy Front (N)')
% xlim([-30 30])
% ylim([-15000 15000])
% grid on




%% Pacejka magic formula. Rear



mu_peak_r = 1.38 - FzR*0.0232/1000;
mu_90_deg_r = 0.723*mu_peak_r;

Br = 13; %% stiffness factor. Gives maximum mu for alpha = 6º for the static front tyre load.
Cr = 1.51253; % Makes mu_max/mu_90_deg=0.723 for static front tyre load
Dr = mu_peak_r; %% peak value. If Df<Dr understeer
Er = FzR*(-2-0.2)/12000 +0.2; %% Sporty tire
% Er = FzR*(0.5+2)/12000 - 2; %% Curvature factor. Linear variation from Fz = 0KN to 12KN
% alpha_r = 0:0.001:0.2;
alpha_r = -1.571:step:1.571;
alpha_r_deg = alpha_r*180/pi;
mu_y_r = Dr.*sin(Cr.*atan(Br*alpha_r - Er*(Br*alpha_r - atan(Br*alpha_r))));
n_r = (Cr.*Dr.*cos(Cr.*atan(Br.*alpha_r + Er.*(atan(Br.*alpha_r) - Br.*alpha_r))).*(Br - Er.*(Br - Br./(Br.^2.*alpha_r.^2 + 1))))./((Br.*alpha_r + Er.*(atan(Br.*alpha_r) - Br.*alpha_r)).^2 + 1);
C_r = n_r.*FzR;

percentage_r = mu_y_r(:,length(alpha_r))./mu_90_deg_r % mu(90º)/mu(90º)desired

%% Plots. Rear

% figure(2)
% clf
% subplot(3,1,1)
% hold
% for i = 1:length(FzR)
%     plot(alpha_r, mu_y_r(i,:))
%     
% end
% title('mu_y Rear')
% xlabel('slip angle (rad)')
% ylabel('mu_y Rear')
% grid on
% 
% 
% 
% 
% subplot(3,1,2)
% hold
% for i = 1:length(FzR)
%     plot(alpha_r, n_r(i,:))
%     
% end
% title('nr')
% xlabel('slip angle (rad)')
% ylabel('nr (1/rad)')
% grid on
% 
% subplot(3,1,3)
% hold
% for i = 1:length(FzR)
%     plot(alpha_r, C_r(i,:))
%     
% end
% title('Cr')
% xlabel('slip angle (rad)')
% ylabel('Cr (N/rad)')
% grid on

% 
% figure(2)
% clf
% hold
% for i = 1:length(FzR)
%     plot(alpha_r_deg, mu_y_r(i,:))
%     
% end
% title('mu_y Rear')
% xlabel('slip angle (º)')
% ylabel('mu_y Rear')
% xlim([0 60])
% grid on

figure(4)
clf
hold
for i = 1:length(FzR)
    plot(alpha_r_deg, mu_y_r(i,:)*FzR(i))
    
end
title('Fy Rear')
xlabel('slip angle (º)')
ylabel('Fy Rear (N)')
xlim([-30 30])
ylim([-15000 15000])
grid on

%% Approximate values of Cf and Cr (for the linear bicycle model)

% Cf_lin = C_f(0.03/0.001 + 1);
% Cr_lin = C_r(0.03/0.001 + 1); %% Stiffnesses at 0.03 rad (1.7º) slip angle

Cf_lin = 1.205984111859764e+05;
Cr_lin = 1.117631261866039e+05;

