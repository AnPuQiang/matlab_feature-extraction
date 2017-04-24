%%����켣�յ㣬��ÿ������֮��ļн�
%%��ʾ�յ�λ�ã���¼��������
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
namelistINFLECT  = dir(strcat('G:\˶ʿ����\�켣ʶ��\matlab\test_DTW\tracing_points\tracing_points\�ֿ��켣\',num2str(name(1,loop)),'\*.xlsx'));
l = length(namelistINFLECT);   %�˹켣�ֵõĵؿ���
inflectionPoints = [];
 for i=1:l
    X = xlsread(strcat('G:\˶ʿ����\�켣ʶ��\matlab\test_DTW\tracing_points\tracing_points\�ֿ��켣\',num2str(name(1,loop)),'\',namelistINFLECT(i).name));
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
 xlswrite(strcat('G:\˶ʿ����\�켣ʶ��\matlab\test_DTW\tracing_points\tracing_points\�ֿ��켣\','inflection',namelistINFLECT(1).name),inflectionPoints);
end
