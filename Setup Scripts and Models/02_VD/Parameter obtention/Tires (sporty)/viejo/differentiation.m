clear
clc

syms B C D E alpha
mu_y = D.*sin(C.*atan(B*alpha - E*(B*alpha - atan(B*alpha))));
deriv_mu_y = diff(mu_y,alpha);


