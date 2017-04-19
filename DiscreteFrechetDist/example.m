% t = 0:pi/8:2*pi;
% y = linspace(1,3,6);
% P = [(2:7)' y']+0.3.*randn(6,2);
% Q = [t' sin(t')]+2+0.3.*randn(length(t),2);

clc;
clear;
X = xlsread('D:\gpcs\matlab\test_DTW\A.xlsx');
A = xlsread('D:\gpcs\matlab\test_DTW\2X.xlsx');
% clc;
% clear;
% namelist  = dir('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\*.xlsx');
% l = length(namelist);
% X = xlsread(strcat('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\',namelist(1).name));
% A = xlsread(strcat('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\',namelist(2).name));

XX = X(:,1:2);  %取出前两列
AA = A(:,1:2);

numX = XX;   %取出前n行
numA = AA;
for i=1:size(numX,1)
[numX(i,1),numX(i,2)] = BL2XY(X(i,1),X(i,2),6);
end
for i=1:size(numA,1)
[numA(i,1),numA(i,2)] = BL2XY(A(i,1),A(i,2),6);
end


numXZ = numX';
numAZ = numA';

numXZ=mapminmax(numXZ,-1,1);
numAZ=mapminmax(numAZ,-1,1);
numXX = numXZ';
numAA = numAZ';

P = numXX;
Q = numAA;
[cm, cSq] = DiscreteFrechetDist(P(:,:),Q(:,:));
% plot result
figure
plot(Q(:,1),Q(:,2),'o-r','linewidth',3,'markerfacecolor','r')
hold on
plot(P(:,1),P(:,2),'o-b','linewidth',3,'markerfacecolor','b')
title(['The DTW Distance of curves P and Q: ' num2str(cm)])
legend('Q','P','location','best')
% line([2 cm+2],[0.5 0.5],'color','m','linewidth',2)
% text(2,0.4,'dFD length')
for i=1:length(cSq)
  line([P(cSq(i,1),1) Q(cSq(i,2),1)],...
       [P(cSq(i,1),2) Q(cSq(i,2),2)],...
       'color',[0 0 0]+(i/length(cSq)/1.35));
end
axis equal
% display the coupling sequence along with each distance between points
%disp([cSq sqrt(sum((P(cSq(:,1),:) - Q(cSq(:,2),:)).^2,2))])