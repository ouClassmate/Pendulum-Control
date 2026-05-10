% 画出内环（带控制器）开环传递函数的奈奎斯特图、伯德图
clear
clc
T = 1;
f1 = [-0.01 0];%分子
f2 = [4.45 22.25 -65.47 -327.37];%分子
f3 = [T 1];%分母
f4 = [1 6.65 13.67 0.02 0];%分母
%conv的用处是把                                                                                                                                          他们求成多项式的形式
num = conv(f1,f2);%求多项式
den = conv(f3,f4);%求多项式
sys = tf(num,den)
%画出所有参数
figure(1)
margin(sys);
% grid on;
%不画，直接给参数赋值出来
%[Gm,Pm,Wcg,Wcp] = margin(sys);%Gm幅值裕度 Pm相角裕度 Wcg穿越频率 Wcp剪切频率
figure(2)
nyquist(sys);  % 画奈奎斯特图
% grid on;