clear
clc
%% 初始化参数
M = 1;  % 小车质量（kg）
m = 0.5;  % 摆杆质量（kg）
l = 0.5;   % 转动关节到摆杆质心的长度（m）
b1 = 0.3;  % 小车移动阻尼
b2 = 0;   % 摆杆转动阻尼
I = (m*l^2) / 3;   % 摆杆转动惯量
g = 9.8;  % 重力加速度
theta0 = 30 * pi/180;   % 摆杆初始角度（rad）
theta_d = 0 * pi/180;   % 摆杆目标角度（rad）
%% 运行仿真获取数据
simout = sim("pendulum_simplePID", 2);  % 参数为模型名和仿真时间
t = simout.theta.time;
theta = simout.theta.data;  % 摆杆角度
x = simout.x.data;   % 滑块位移
%% 倒立摆动画演示
im = cell(length(t), 1);
h = figure(1);
for k = 1:length(t)
    bot_x = x(k); bot_y = 0;                           % 杆底坐标
    top_x = x(k) - 2*l*sin(theta(k)); top_y = 2*l*cos(theta(k)); % 杆顶坐标
    plot(bot_x, bot_y, 'o', 'LineWidth', 1.5); hold on;
    plot([bot_x, top_x], [bot_y, top_y], 'LineWidth', 2); 
    hold off;
    axis equal; 
    axis([-3, 0.5, -0.10, 1.2]); grid on;
    title('Pendulum Animation')
    drawnow;
    frame = getframe(h);      % 记录该帧
    im{k} = frame2im(frame);
    % pause(0.01);
end
%% GIF图片制作
filename = 'pendulum_animation.gif';
for idx = 1:length(t)
    [A, map] = rgb2ind(im{idx}, 256);
    if idx == 1
        imwrite(A, map, filename, 'gif', 'LoopCount', Inf, 'DelayTime', 1.00);
    else
        imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.01);
    end
end