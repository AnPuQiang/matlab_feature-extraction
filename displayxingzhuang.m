clc;
clear;
namelist  = dir('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\*.xlsx');
l = length(namelist);
numRow = zeros(l,1);
numLength =zeros(1,l);  %存储轨迹点间距
 for i=1:l
    X = xlsread(strcat('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\',namelist(i).name));
    numX = X(:,1:2);
    %计算相邻轨迹点之间的距离
    numRow(i,1) = size(X,1);
    numPoint = size(numX,1);    %计算该图轨迹点的个数
    for j = 2:numPoint
       numLength(j-1,i) = sqrt((numX(j,1)-numX(j-1,1))^2 + (numX(j,2)-numX(j-1,2))^2 );
    end
    
%     figure(i);
%     plot(numX(:,1),numX(:,2),'o-r','linewidth',2,'markerfacecolor','r')
%     numRow(i,1) = size(X,1);
%     scatter(X(500:1000,1,:),X(500:1000,2,:),6,'filled');
%     for j=1:size(X,1)
%         [numX(j,1),numX(j,2)] = BL2XY(X(j,1),X(j,2),6);
%     end
%     numXZ = numX';
%     numXZ=mapminmax(numXZ,-1,1);
%     numXX = numXZ';
%     figure(i);
%     plot(numXX(:,1),numXX(:,2),'o-r','linewidth',3,'markerfacecolor','r')
 end

 xlswrite('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\轨迹点距离\numLength.xlsx',numLength);

