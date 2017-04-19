%%计算轨迹拐点，求每三个点之间的夹角
%%显示拐点位置，记录进矩阵中
clc;
clear;
name = [2059,2217,5019,5065,5087,5166,5183,5207,5261,5497,5523];
for loop = 1:size(name,2)
namelist  = dir(strcat('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\',num2str(name(1,loop)),'\*.xlsx'));
l = length(namelist);   %此轨迹分得的地块数
inflectionPoints = [];
 for i=1:l
    X = xlsread(strcat('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\',num2str(name(1,loop)),'\',namelist(i).name));
    numX = X;
    numXZ = numX';
    numXZ=mapminmax(numXZ,-1,1);
    numXX = numXZ';
    angleNum = zeros(size(numXX,1),1);
    figure(i);
    plot(numXX(:,1),numXX(:,2),'r');
    hold on;
    beginPoint = 1;
    for k = 2:(size(numXX,1)-1)
        angleNum(k,1) = find_angle(numXX(k-1,:),numXX(k,:),numXX(k+1,:));
        if angleNum(k,1)<=100
            inflectionPoints(beginPoint,2*i-1:2*i) = numXX(k,:);
            beginPoint = beginPoint+1;
            scatter(numXX(k,1),numXX(k,2),20,'filled'); 
            hold on;
        end
    end  
 end
 xlswrite(strcat('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\','inflection',namelist(1).name),inflectionPoints);
end
