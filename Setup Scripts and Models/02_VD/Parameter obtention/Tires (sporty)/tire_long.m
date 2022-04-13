clear
clc

step = 0.001;
%% Weight distribution
m_front_total_ratio = 0.532;
FzT = 2500*9.81;

FzF = FzT*m_front_total_ratio; %% Vertical load at the front, N
FzR = FzT - FzF; %% Vertical load at the rear, N

FzF = FzF/2;
FzR = FzR/2;


% FzF = [0:2000:12000]';
% FzR = [0:2000:12000]';

FzF = [2000:2500:12000]';
FzR = [2000:2500:12000]';

%% Pacejka magic formula. Front

mu_peak_f = 1.37 - FzF*0.0175/1000;
mu_inf_f = 0.75*mu_peak_f;

Bf = 13; %% stiffness factor. Gives maximum mu for alpha = 6º for the static front tyre load.
Cf = 1.5072; % Shape factor. Makes mu_max/mu_inf=0.75 for static front tyre load
Df = mu_peak_f; %% peak value. If Df<Dr understeer
Ef = -0.64; %% Curvature factor. 
sx_f = -1:step:1;
mu_x_f = Df.*sin(Cf.*atan(Bf*sx_f - Ef*(Bf*sx_f - atan(Bf*sx_f))));
dmu_x_f = (Cf.*Df.*cos(Cf.*atan(Bf.*sx_f + Ef.*(atan(Bf.*sx_f) - Bf.*sx_f))).*(Bf - Ef.*(Bf - Bf./(Bf.^2.*sx_f.^2 + 1))))./((Bf.*sx_f + Ef.*(atan(Bf.*sx_f) - Bf.*sx_f)).^2 + 1);


percentage_f = mu_x_f(:,length(sx_f))./mu_inf_f % mu(90º)/mu(90º)desired

%% Plots. Front

% figure(1)
% clf
% hold
% for i = 1:length(FzF)
%     plot(sx_f, mu_x_f(i,:))
% %     if i == 1
% %         legend('0 KN')        
% %     end
% %     
% %     if i == length(FzF)
% %         legend('12 KN')
% %     end
%     
% end
% title('mu_x Front')
% xlabel('long slip (sx)')
% ylabel('mu_X Front')
% % legend('0 KN','','',,,,'12 KN')
% grid on

% figure(3)
% clf
% hold
% for i = 1:length(FzF)
%     plot(sx_f, mu_x_f(i,:)*FzF(i))
%     
% end
% title('Fx front (N)')
% xlabel('long slip (sx)')
% ylabel('Fx front (N)')
% xlim([-0.2 0.5])
% ylim([-15000 15000])
% grid on



%% Pacejka magic formula. Rear

mu_peak_r = 1.38 - FzR*0.0112/1000;
mu_inf_r = 0.75*mu_peak_r;

Br = 13; %% stiffness factor. Gives maximum mu for alpha = 6º for the static front tyre load.
Cr = 1.5072; % Shape factor. Makes mu_max/mu_inf=0.75 for static front tyre load
Dr = mu_peak_r; %% peak value. If Df<Dr understeer
Er = -0.64; %% Curvature factor. 
sx_r = -1:step:1;
mu_x_r = Dr.*sin(Cr.*atan(Br*sx_r - Er*(Br*sx_r - atan(Br*sx_r))));

percentage_r = mu_x_r(:,length(sx_r))./mu_inf_r % mu(90º)/mu(90º)desired

%% Plots. Rear
% 
% figure(2)
% clf
% hold
% for i = 1:length(FzR)
%     plot(sx_r, mu_x_r(i,:))
%     
% end
% title('mu_y Rear')
% xlabel('long slip (sx)')
% ylabel('mu_x Rear')
% grid on
% 

figure(4)
clf
hold
for i = 1:length(FzR)
    plot(sx_r, mu_x_r(i,:)*FzR(i))
    
end
title('Fx rear (N)')
xlabel('long slip (sx)')
ylabel('Fx Rear (N)')
xlim([-0.2 0.5])
ylim([-15000 15000])
grid on