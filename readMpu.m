clc;
clear;
A= xlsread('D:\gpcs\matlab\mpu6050\mpu20170327.xlsx');
% meanAccx = mean(A(:,4));
% meanAccy = mean(A(:,5));
% meanAccz = mean(A(:,6));
% meanGyrox = mean(A(:,7));
% meanGyroy = mean(A(:,8));
% meanGyroz = mean(A(:,9));
%%4 5 10 11��ΪУ��ǰ��ļ��ٶ�ֵ
plot(210:1200,A(210:1200,4),'r');
hold on;
plot(210:1200,A(210:1200,10),'y');
hold on;
plot(210:1200,A(210:1200,5),'b');
hold on;
plot(210:1200,A(210:1200,11),'g');
title('X/Y����ٶ�У��ǰ����ͼ');
xlabel('ʱ�� t');
ylabel('���ٶ� m/s^2');
legend('δУ��X����ٶ�','У��X����ٶ�','δУ��Y����ٶ�','У��Y����ٶ�')