clear
clc

syms Z

y = Z.*(6.94+1.04*Z)/10;
yprim = diff(y)