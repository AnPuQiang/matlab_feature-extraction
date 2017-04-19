%%去除插值的点
% X = xlsread('D:\gpcs\matlab\test_DTW\gpcs_dataset.xlsx');
% XX=X(1:3:end,:);
% xlswrite('D:\gpcs\matlab\test_DTW\gpcs_clear.xlsx',XX);
% Y= xlsread('D:\gpcs\matlab\test_DTW\gpcs_clear.xlsx');
% scatter(Y(1:2000,1),Y(1:2000,2),6,'filled');
%%去除无效的坐标点行
clc;
clear;
namelist  = dir('E:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\*.xlsx');
l = length(namelist);
 for i=1:l
   data=xlsread(strcat('E:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\',namelist(i).name));
   %xlswrite(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\',namelist(i).name,'.xlsx'),data);
   XX=data(1:3:end,:);
   xlswrite(strcat('E:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\',namelist(i).name,'+2','.xlsx'),XX);
 end