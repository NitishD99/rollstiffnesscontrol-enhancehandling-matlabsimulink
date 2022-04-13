clear
clc

tw_F = 1.685;
tw_R = 1.65;
tw = (tw_F + tw_R)/2;
step = 0.0001;
% speed = [0.02 0.05 0.13 0.26 0.52]; %% m/s
% We define Compression = Z>0
%           Extension = Z<0
speed = [-0.52 -0.26 -0.13 -0.05 -0.02 0 0.02 0.05 0.13 0.26 0.52];
i_z_0 = 6;
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

%% Roll damping front
theta_dot_f = speed*2/tw_F;
M_damp_f = 0*ones(1, length(speed));

for i = 1:1:5
    M_damp_f(i_z_0 + i) = (Force(i_z_0 + i) - Force(i_z_0 - i))*tw_F/2;
    M_damp_f(i_z_0 - i) = -(Force(i_z_0 + i) - Force(i_z_0 - i))*tw_F/2;

end

%% Roll damping rear
theta_dot_r = speed*2/tw_R;
M_damp_r = 0*ones(1, length(speed));

for i = 1:1:5
    M_damp_r(i_z_0 + i) = (Force(i_z_0 + i) - Force(i_z_0 - i))*tw_R/2;
    M_damp_r(i_z_0 - i) = -(Force(i_z_0 + i) - Force(i_z_0 - i))*tw_R/2;

end


% 
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

figure(2)
clf
plot(theta_dot_f, M_damp_f)
title('Damping front roll torque')
xlabel('Roll rate (rad/s)')
ylabel('Damping torque (Nm)')
grid on

figure(3)
clf
plot(theta_dot_r, M_damp_r)
title('Damping rear roll torque')
xlabel('Roll rate (rad/s)')
ylabel('Damping torque (Nm)')
grid on


%% Save
theta_dot_f_damp = theta_dot_f;
theta_dot_r_damp = theta_dot_r;

save roll_damp theta_dot_f_damp theta_dot_r_damp M_damp_f M_damp_r


