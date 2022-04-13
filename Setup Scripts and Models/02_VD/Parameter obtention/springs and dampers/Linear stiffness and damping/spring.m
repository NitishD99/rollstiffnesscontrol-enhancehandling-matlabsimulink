clear
clc

step = 0.01;
Z = -0.11:step:0.11;
i_z_0 = 1/step*(0 + 0.11) + 1; % indez for which Z=0

%% Rear wheel

Kr_spring = 84.4e3; % N/m. 
Rear_spr_vs_z = Z.*(67.5+Z.*(10.2+Z.*(11.6)))/100;%m
Rear_deriv_spr_vs_z = (Z.*((58*Z)/5 + 51/5))/100 + (Z.*((116*Z)/5 + 51/5))/100 + 27/40;
Kr_w = Kr_spring*Rear_deriv_spr_vs_z; %% Spring stiffness as a function of Z

Kr_w_0 = Kr_w(i_z_0);

Fr_w_pos = [0];
for i=i_z_0:1:(length(Z) - 1)
    int = Kr_w(i)*(Z(i+1) - Z(i));
    Fr_w_pos = [Fr_w_pos (Fr_w_pos(length(Fr_w_pos)) + int)];
end
Z_pos = Z(i_z_0:(length(Z)));

Fr_w_neg = [zeros(1, i_z_0)];
Fr_w_prev = 0;
Z_neg = Z(1:i_z_0);
for i=(i_z_0-1):-1:1
    int = Kr_w(i)*(Z(i) - Z(i+1));
    Fr_w_neg(i) = Fr_w_prev + int;
%     Fr_w_neg = [Fr_w_neg (Fr_w_neg(length(Fr_w_neg)) + int)];
    Fr_w_prev = Fr_w_neg(i);
end
Z_neg = Z_neg(1:(length(Z_neg) - 1));
Fr_w_neg = Fr_w_neg(1:(length(Fr_w_neg) - 1));

Fr_w = [Fr_w_neg Fr_w_pos];



figure(1)
clf
subplot(1,2,1)
plot(Z, Rear_spr_vs_z)
% plot(Z, spr_vs_z)
title('Rear')
ylabel('Spring deflection (m)')
xlabel('Vertical displacement of the wheel (m)')
grid on

subplot(1,2,2)
plot(Z, Kr_w)
title('Rear Spring Stiffness')
% plot(Z, spr_vs_z)
ylabel('Spring Stiffness (N/m)')
xlabel('Vertical displacement of the wheel (m)')
grid on

figure(2)
clf
plot(Z, Fr_w)
title('Rear Spring force')
ylabel('Rear spring force (N)')
xlabel('Vertical displacement of the wheel (m)')
grid on

% figure(2)
% clf
% plot(Z_pos, Fr_w_pos)
% title('Rear positive')
% ylabel('Spring deflection (m)')
% xlabel('Vertical displacement of the wheel (m)')
% grid on
% 
% figure(3)
% clf
% plot(Z_neg, Fr_w_neg)
% title('Rear negative')
% ylabel('Spring deflection (m)')
% xlabel('Vertical displacement of the wheel (m)')
% grid on

%% Front wheel

Kf_spring = 62.3e3; % N/m. 
Front_spr_vs_z = Z.*(6.94+1.04*Z)/10;%m
Front_deriv_spr_vs_z = (26*Z)/125 + 347/500;
Kf_w = Kf_spring*Front_deriv_spr_vs_z; %% Spring stiffness as a function of Z

Kf_w_0 = Kf_w(i_z_0);


Ff_w_pos = [0];
for i=i_z_0:1:(length(Z) - 1)
    int = Kf_w(i)*(Z(i+1) - Z(i));
    Ff_w_pos = [Ff_w_pos (Ff_w_pos(length(Ff_w_pos)) + int)];
end
Z_pos = Z(i_z_0:(length(Z)));

Ff_w_neg = [zeros(1, i_z_0)];
Ff_w_prev = 0;
Z_neg = Z(1:i_z_0);
for i=(i_z_0-1):-1:1
    int = Kf_w(i)*(Z(i) - Z(i+1));
    Ff_w_neg(i) = Ff_w_prev + int;
%     Fr_w_neg = [Fr_w_neg (Fr_w_neg(length(Fr_w_neg)) + int)];
    Ff_w_prev = Ff_w_neg(i);
end
Z_neg = Z_neg(1:(length(Z_neg) - 1));
Ff_w_neg = Ff_w_neg(1:(length(Ff_w_neg) - 1));

Ff_w = [Ff_w_neg Ff_w_pos];


figure(3)
clf
subplot(1,2,1)
plot(Z, Front_spr_vs_z)
title('Front')
ylabel('Spring deflection (m)')
xlabel('Vertical displacement of the wheel (m)')
grid on

subplot(1,2,2)
plot(Z, Kf_w)
title('Front Wheel stiffness')
ylabel('Stiffness in front wheel (N/m)')
xlabel('Vertical displacement of the wheel (m)')
grid on

figure(4)
clf
plot(Z, Ff_w)
title('Front Spring force')
ylabel('Front spring force (N)')
xlabel('Vertical displacement of the wheel (m)')
grid on

%% Roll stiffness for Z=0
% w_front = 1.685;
% w_rear = 1.65;
% 
% Kq_front = w_front^2/2 * Kf_w_0;
% Kq_rear = w_rear^2/2 * Kr_w_0;
% Kq = Kq_front + Kq_rear;

Z_spring = Z;
Ff_spring = Ff_w;
Fr_spring = Fr_w;

data =[Z_spring' Ff_spring' Fr_spring'];
save spring Z_spring Kf_w Kr_w Ff_spring Fr_spring