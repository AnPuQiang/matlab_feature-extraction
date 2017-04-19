clc;
clear;
data = xlsread('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\distDTW\dist.xlsx');
% data = [data1,data2,data3,data4,data5,data6];
fid = fopen('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\distDTW\gpcs_qid_2_101','w');
%%归一化
numX = data;
    numXZ = numX';
    numXZ=mapminmax(numXZ,0,1);
    numXX = numXZ';
    data = numXX;
% for i =1:size(data,1)
%    data(i,6) = 10-(data(i,2)*3+data(i,3)*2+data(i,4)*3)+data(i,5)*2 
% end
for i =1:size(data,1)
fprintf(fid,'%f %s%d %d%s%f %d%s%f %d%s%f %d%s%f\r\n',data(i,6),'qid:',data(i,1),1,':',data(i,2),2,':',data(i,3),3,':',data(i,4),4,':',data(i,5));
end
fclose(fid);