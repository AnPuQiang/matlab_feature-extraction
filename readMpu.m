clc;
clear;
A= xlsread('D:\gpcs\matlab\mpu6050\mpu20170327.xlsx');
% meanAccx = mean(A(:,4));
% meanAccy = mean(A(:,5));
% meanAccz = mean(A(:,6));
% meanGyrox = mean(A(:,7));
% meanGyroy = mean(A(:,8));
% meanGyroz = mean(A(:,9));
%%4 5 10 11列为校正前后的加速度值
plot(210:1200,A(210:1200,4),'r');
hold on;
plot(210:1200,A(210:1200,10),'y');
hold on;
plot(210:1200,A(210:1200,5),'b');
hold on;
plot(210:1200,A(210:1200,11),'g');
title('X/Y轴加速度校正前后结果图');
xlabel('时间 t');
ylabel('加速度 m/s^2');
legend('未校正X轴加速度','校正X轴加速度','未校正Y轴加速度','校正Y轴加速度')