%%��ԭʼ�ľ�γ�Ⱥ�mpu6050��txt������ȡ�������ϲ���һ��excel�ļ���
clc;
clear;
namelist  = dir('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\*.txt');
[m1,m2,m3,m4,m5,m6,m7,m8,m9,m10]=textread('D:\gpcs\matlab\mpu6050\mpu6050\20170414.txt','%n%n%n%n%n%n%n%n%n%n','delimiter', ',');
m = [m1,m2,m3,m4,m5,m6,m7,m8,m9,m10];
l = length(namelist);
 for i=1:l
   % %n�Ƕ�ȡһ�����ݲ���ת��Ϊdouble����
   [data1,data2,data3]=textread(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\',namelist(i).name),'%n%n%n','delimiter', ',');
   data = [data1,data2,data3];
   dataRow = size(data,1); %%data����
   
   %%ȥ����data�е�NAN��
   [m,n] = find(isnan(data)==1);
   data(m,:) = [];
   %��txt�ļ����ļ�����ȡ����
   point = strfind(namelist(i).name,'.');
   str = namelist(i).name(1:point-1);
   xlswrite(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\',str,'.xlsx'),data);
 end