# 说明

本仓库仅提供相关仿真与代码，不对其原理进行解释，具体理论请参考下列博客

[倒立摆自动控制学习笔记（一）：倒立摆建模及简单PID控制](https://blog.csdn.net/fakecoder/article/details/156310123?spm=1001.2014.3001.5502)

[倒立摆自动控制学习笔记（二）：增加空气阻力的倒立摆建模及简单PID控制](https://blog.csdn.net/fakecoder/article/details/156341015?sharetype=blogdetail&sharerId=156341015&sharerefer=PC&sharesource=fakecoder&spm=1011.2480.3001.8118)

仿真包括main.m和一系列以pendulum_为前缀的模型文件文件，将这些文件放到同一路径，用2024a或更高版本的matlab打开main.m，将代码中的语句：
```matlab
simout = sim("pendulum_friction_PID", 2);  % 参数为模型名和仿真时间
```
中的模型名称改为你想要运行的，修改仿真时间，然后运行main.m即可。
