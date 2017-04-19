%%1.显示所有分段轨迹，选出合理轨迹
%%2.轨迹同加速度数据结合
%%3.根据速度和加速度大小对不良驾驶路段分颜色标注
% clc;
% clear;
% name = [2059,2217,5019,5065,5087,5166,5183,5207,5261,5497,5523];
% number = [];
% n =1;
% 
% for loop = 2:2
% namelist  = dir(strcat('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\',num2str(name(1,loop)),'\*.xlsx'));
% l = length(namelist);   %此轨迹分得的地块数
%  for i=1:l
%     X = xlsread(strcat('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\',num2str(name(1,loop)),'\',namelist(i).name));
%     figure(n)
%     plot(X(:,1),X(:,2));
%     n = n+1;
%     
%     title(['The curves of: ' num2str(name(1,loop)),' ',i])
%     number(i,loop) = size(X,1);
%  end
% end

X = xlsread('G:\硕士论文\MPU6050\matlab\6050.xlsx');
Y = xlsread('G:\硕士论文\MPU6050\matlab\2+2217.xlsx');
A = Y;
A(:,3:4) = X(1:size(Y,1),1:5:6);
xlswrite('G:\硕士论文\MPU6050\matlab\2217+2+6050.xlsx',A);
figure(1)
plot(A(:,1),A(:,2),'--k')
hold on;
for i =1:size(A,1)
   if A(i,3)*9.8 > 2.5
       plot(A(i,1),A(i,2),'pb')
       hold on;
   end
   if A(i,3)*9.8 > 4
       plot(A(i,1),A(i,2),'pr')
       hold on;
   end
   if A(i,4)*2*pi/360 > 0.45
       plot(A(i,1),A(i,2),'oy')
       hold on;
   end
end




