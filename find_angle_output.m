%%计算轨迹拐点，求每三个点之间的夹角
%%显示拐点位置，记录进矩阵中
clc;
clear;

inflectionPoints = [];
 
    X = xlsread('D:\gpcs\matlab\test_DTW\A.xlsx');
    A = xlsread('D:\gpcs\matlab\test_DTW\1X.xlsx');
    numX = X;
    numXZ = numX';
    numXZ=mapminmax(numXZ,-1,1);
    numXX = numXZ';
    angleNum = zeros(size(numXX,1),1);
    
   
    plot(numXX(:,1),numXX(:,2),'o-r','linewidth',3,'markerfacecolor','r');
    hold on;
    beginPoint = 1;
    for k = 2:(size(numXX,1)-1)
        angleNum(k,1) = find_angle(numXX(k-1,:),numXX(k,:),numXX(k+1,:));
        if angleNum(k,1)<=120
            inflectionPoints(beginPoint,:) = numXX(k,:);
            beginPoint = beginPoint+1;
            scatter(numXX(k,1),numXX(k,2),200,'filled'); 
            hold on;
        end
    end
    

% xlswrite(strcat('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\','inflection',namelist(1).name),inflectionPoints);

