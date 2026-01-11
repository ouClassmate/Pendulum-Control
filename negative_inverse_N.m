% 定义振幅范围
a = pi/18;
% 绘制负倒描述函数曲线
figure(1);
for A = a:0.1:20
    x = -pi / (asin(a/A) + (a/A)*sqrt(1 - (a/A)^2)) / 2;
    y = 0;
    z = x + y * 1i;
    plot(x, y, 'k.');
    hold on;
end

num = [-8.85 -59 50.55 339 1.7];%分子
den = [1 6.69 36.87 -4.22 -0.02];%分母
sys = tf(num,den)
nyquist(sys);  % 画奈奎斯特图
% grid on;
figure(2)
margin(sys);  % 画伯德图
% grid on;
% 不画，直接给参数赋值出来
% [Gm,Pm,Wcg,Wcp] = margin(sys);%Gm幅值裕度 Pm相角裕度 Wcg穿越频率 Wcp剪切频率