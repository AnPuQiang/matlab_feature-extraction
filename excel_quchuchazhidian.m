%%ȥ����ֵ�ĵ�
% X = xlsread('D:\gpcs\matlab\test_DTW\gpcs_dataset.xlsx');
% XX=X(1:3:end,:);
% xlswrite('D:\gpcs\matlab\test_DTW\gpcs_clear.xlsx',XX);
% Y= xlsread('D:\gpcs\matlab\test_DTW\gpcs_clear.xlsx');
% scatter(Y(1:2000,1),Y(1:2000,2),6,'filled');
%%ȥ����Ч���������
clc;
clear;
namelist  = dir('E:\˶ʿ����\�켣ʶ��\matlab\test_DTW\tracing_points\tracing_points\*.xlsx');
l = length(namelist);
 for i=1:l
   data=xlsread(strcat('E:\˶ʿ����\�켣ʶ��\matlab\test_DTW\tracing_points\tracing_points\',namelist(i).name));
   %xlswrite(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\',namelist(i).name,'.xlsx'),data);
   XX=data(1:3:end,:);
   xlswrite(strcat('E:\˶ʿ����\�켣ʶ��\matlab\test_DTW\tracing_points\tracing_points\',namelist(i).name,'+2','.xlsx'),XX);
 end