%% Front tire
% pend = 2704.48/(0.01*FzF) % 41.4565
pend = 8192.64/(0.109*FzF) % 11.5214

% K = B*C*D = 
% Bf*Cf*(1.37 - FzF*0.0175/1000);
%Kfx/Kfz Bf*Cf*1.2558
var = -Bf*Cf* 0.0175/1000; %% -3.4289e-04
K_Fznom = 24.6064;

%% Rear tire
Bf*Cf*1.3157
var2 = -Bf*Cf* 0.0112/1000; %