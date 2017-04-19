%%����켣�յ㣬��ÿ������֮��ļн�
%%��ʾ�յ�λ�ã���¼��������
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
    

% xlswrite(strcat('G:\˶ʿ����\�켣ʶ��\matlab\test_DTW\tracing_points\tracing_points\�ֿ��켣\','inflection',namelist(1).name),inflectionPoints);

