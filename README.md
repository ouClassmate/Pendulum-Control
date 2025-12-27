# 倒立摆动力学建模
建模参考这篇网摘：https://www.cnblogs.com/wanMB/articles/18301917/20240714ZJ26
<img width="860" height="482" alt="image" src="https://github.com/user-attachments/assets/dd8cc451-a640-4d5e-9b97-489e1bf7cf73" />
|符号|含义|符号|含义|
|--|--|--|--|
| $M$ | 小车质量 | $m$ | 摆杆质量 |
|$b_1$| 小车移动阻尼 | $b_2$ | 摆杆转动阻尼 |
|$x$| 小车位置(水平向右为正) | $\theta$ | 摆杆摆动的角度(逆时针转动为正) |
|$F$| 作用到小车的外力(水平向右为正) | $l$ | 转动关节到摆杆质心的长度 |
|$N_车$| 摆杆对小车的力水平分量 | $I$ | 摆杆绕质心的转动惯量 |
|$N_杆$| 小车对摆杆的力水平分量 | $P_杆$ | 小车对摆杆的力竖直分量 |

小车水平方向:
$$F-N_车-b_1\dot{x}=M\ddot{x}$$
摆杆水平方向：
$$N_杆=m\frac{d^2(x-lsin\theta)}{dt^2}=m(\ddot{x}-\ddot{\theta}lcos\theta+\dot{\theta}^2lsin\theta)$$
摆杆竖直方向：
$$P_杆-mg=m\frac{d^2(lcos\theta)}{dt^2}=-m(\ddot{\theta}lsin\theta+\dot{\theta}^2lcos\theta)$$
摆杆转动方向(对质心求矩)：
$$P_杆lsin\theta+N_杆lcos\theta-b_2\dot{\theta}=I\ddot{\theta}$$
牛顿第三定律：
$$N_车=N_杆$$
笔者注：摆杆角度的正负和参考网摘不同，这是为了保证闭环控制设计时为负反馈。
# 倒立摆和简单PID控制器simulink建模
根据上面的公式，可以用simulink搭建出模型：
<img width="1277" height="671" alt="image" src="https://github.com/user-attachments/assets/72283b30-552e-4e44-8e23-f8108144a96c" />
模块Plant：
<img width="1076" height="620" alt="image" src="https://github.com/user-attachments/assets/0fb3c497-4c53-4666-a5b0-a263024e7776" />
Controller（这里PID参数是随手设的）：
<img width="1435" height="466" alt="image" src="https://github.com/user-attachments/assets/af2bd89c-ee76-4d96-966e-6265b3643954" />
simulink可以很方便地搭建出模型和控制器，不过看数据只能用示波器，数据处理的自由度很受限制。在simulink中可以增加To Workspace模块（图中的out.theta和out.x模块）将想要的数据导出工作区，方便我们利用这些数据画图分析，甚至生成倒立摆动画。
另外，m语言中的sim函数也可以很方便地调用simulink模型运行，并获取仿真数据：
```matlab
%% 运行仿真获取数据
simout = sim("pendulum_simplePID", 2);  % 参数为模型名和仿真时间
t = simout.theta.time;
theta = simout.theta.data;  % 摆杆角度
x = simout.x.data;   % 滑块位移
```
关于To Workspace模块和sim函数，可参考这篇博客：https://blog.csdn.net/u014170067/article/details/53355033?spm=1001.2014.3001.5506
根据导出的仿真数据，可以利用代码生成倒立摆动画演示（参考：https://panqiincs.me/2023/12/28/pendulum-animation/）
```matlab
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
```
动画演示效果：
<img width="840" height="630" alt="image" src="https://github.com/user-attachments/assets/c589bad0-cba1-43f9-b744-184bbdfcc7a1" />
<img width="844" height="741" alt="image" src="https://github.com/user-attachments/assets/f34ea201-39b8-4ed6-b4eb-6e8054945e47" />
黄色是目标夹角，蓝色是实际夹角。
PID控制器只控制了摆杆的夹角，没有控制小车的位置，所以小车会一直匀速运动下去，优化方案后续另写一篇文章更新。

仿真包括main.m和pendulum_simplePID.slx两个文件，将这两个文件放到同一路径，用2024a或更高版本的matlab打开，直接运行main.m即可。
