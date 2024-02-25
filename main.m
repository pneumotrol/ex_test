close all;
clear;
clc;

% 実験データ相当
K = 10;
wn = 10;
zeta = 0.02;
sysc = tf([K*wn^2],[1,2*zeta*wn,wn^2])*tf([1],[0.3,1]);
sysc2 = tf([-K*wn^2],[1,2*zeta*wn,wn^2])*tf([1],[0.1,1]);

% HPFのカットオフ周波数
fc = 2;
wc = fc*2*pi;

% 1次のHPF
[LPF1_num,LPF1_den] = butter(1,wc,"high",'s');
LPF1 = tf(LPF1_num,LPF1_den);
% 2次のHPF
[LPF2_num,LPF2_den] = butter(2,wc,"high",'s');
LPF2 = tf(LPF2_num,LPF2_den);
% 3次のHPF
[LPF3_num,LPF3_den] = butter(3,wc,"high",'s');
LPF3 = tf(LPF3_num,LPF3_den);

% 2次のHPFの実装用
Ts = 0.01;
A = sqrt(2)*wc;
B = wc^2;

% 周波数特性の確認
figure;
bode(LPF1,LPF2,LPF3);

figure;
bode(LPF2,c2d(LPF2,Ts,"foh"),c2d(LPF2,Ts,"tustin"));

% sim("model.slx");
% writematrix(data,"data.xlsx");