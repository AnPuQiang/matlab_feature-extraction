%%将原始的经纬度和mpu6050的txt数据提取出来，合并到一个excel文件中
clc;
clear;
namelist  = dir('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\*.txt');
[m1,m2,m3,m4,m5,m6,m7,m8,m9,m10]=textread('D:\gpcs\matlab\mpu6050\mpu6050\20170414.txt','%n%n%n%n%n%n%n%n%n%n','delimiter', ',');
m = [m1,m2,m3,m4,m5,m6,m7,m8,m9,m10];
l = length(namelist);
 for i=1:l
   % %n是读取一个数据并且转换为double类型
   [data1,data2,data3]=textread(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\',namelist(i).name),'%n%n%n','delimiter', ',');
   data = [data1,data2,data3];
   dataRow = size(data,1); %%data行数
   
   %%去除掉data中的NAN行
   [m,n] = find(isnan(data)==1);
   data(m,:) = [];
   %将txt文件的文件名提取出来
   point = strfind(namelist(i).name,'.');
   str = namelist(i).name(1:point-1);
   xlswrite(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\',str,'.xlsx'),data);
 end