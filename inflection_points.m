%%计算轨迹拐点，求每三个点之间的夹角
%%显示拐点位置，记录进矩阵中
clc;
clear;
namelist  = dir('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\*.xlsx');
name = zeros(1,length(namelist));
for j = 1:length(namelist)
   point = strfind(namelist(j).name,'.');
   str = str2double(namelist(j).name(1:point-1));
   name(1,j) = str;
end
for loop = 1:size(name,2)
namelistINFLECT  = dir(strcat('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\',num2str(name(1,loop)),'\*.xlsx'));
l = length(namelistINFLECT);   %此轨迹分得的地块数
inflectionPoints = [];
 for i=1:l
    X = xlsread(strcat('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\',num2str(name(1,loop)),'\',namelistINFLECT(i).name));
    numX = X;
    numXZ = numX';
    numXZ=mapminmax(numXZ,-1,1);
    numXX = numXZ';
    angleNum = zeros(size(numXX,1),1);
%     figure(i);
%     plot(numXX(:,1),numXX(:,2),'r');
    hold on;
    beginPoint = 1;
    for k = 2:(size(numXX,1)-1)
        angleNum(k,1) = find_angle(numXX(k-1,:),numXX(k,:),numXX(k+1,:));
        if angleNum(k,1)<=100
            inflectionPoints(beginPoint,2*i-1:2*i) = numXX(k,:);
            beginPoint = beginPoint+1;
%             scatter(numXX(k,1),numXX(k,2),20,'filled'); 
%             hold on;
        end
    end  
 end
 xlswrite(strcat('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\','inflection',namelistINFLECT(1).name),inflectionPoints);
end
