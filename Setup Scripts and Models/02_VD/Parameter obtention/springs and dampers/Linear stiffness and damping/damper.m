clear
clc

step = 0.0001;
% speed = [0.02 0.05 0.13 0.26 0.52]; %% m/s
% We define Compression = Z>0
%           Extension = Z<0
speed = [-0.52 -0.26 -0.13 -0.05 -0.02 0 0.02 0.05 0.13 0.26 0.52];
%% Front and rear

Force = [-2018 -1498 -1198 -898 -530 0 305 552 734 942 1306];
speed2 = [];

for i=1:1:(length(speed)-1)
    speed2 = [speed2 speed(i):step:(speed(i+1)-step)];
end
speed2 = [speed2 (speed2(length(speed2))+step)];
d_Force = [];
for i=1:1:(length(speed)-1)
    L = (speed(i+1)-speed(i))/step;
    slope = (Force(i+1) - Force(i))/(speed(i+1) - speed(i));
    d_Force = [d_Force ones(1, L)*slope];
end
d_Force = [d_Force d_Force(length(d_Force))];
d_Force = abs(d_Force);

c_damp = d_Force;
speed_damp = speed2;

% Comp_Force = [305 552 734 942 1306]; %% N
% Ext_Force = [530 898 1198 1498 2018];
% c_comp = Comp_Force(5)/speed(5);
% c_ext = Ext_Force(5)/speed(5);
% c = (c_comp + c_ext)/2;

figure(1)
clf
subplot(2,1,1)
plot(speed, Force)
title('Damper force')
xlabel('Speed (m/s)')
ylabel('Spring Force (N)')
grid on

subplot(2,1,2)
plot(speed_damp, c_damp)
title('damping coefficient (Ns/m)')
xlabel('Speed (m/s)')
ylabel('c (Ns/m)')
grid on



%% Save
F_damper = Force;
v_damper = speed;

Viraj = [speed' Force'];

save damper F_damper v_damper


