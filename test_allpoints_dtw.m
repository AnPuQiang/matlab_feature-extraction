clc;
clear;
namelist  = dir('D:\gpcs\matlab\test_DTW\test\*.xlsx');
l = length(namelist); 
inflectionPoints= [];
for i=1:l-1
    X = xlsread(strcat('D:\gpcs\matlab\test_DTW\test\',namelist(i).name));
    numX = X;
    for j=1:size(X,1)
        [numX(j,1),numX(j,2)] = BL2XY(X(j,1),X(j,2),6);
    end
    numXZ = numX';
    numXZ=mapminmax(numXZ,-1,1);
    numXX = numXZ';
    figure(i)
    plot(numXX(:,1),numXX(:,2),'o-r','linewidth',3,'markerfacecolor','r')
    hold on;
    
    A = xlsread(strcat('D:\gpcs\matlab\test_DTW\test\',namelist(i+1).name));
    numA = A;
    for k=1:size(A,1)
        [numA(k,1),numA(k,2)] = BL2XY(A(k,1),A(k,2),6);
    end
    numAZ = numA';
    numAZ=mapminmax(numAZ,-1,1);
    numAA = numAZ';
    plot(numAA(:,1),numAA(:,2),'o-b','linewidth',3,'markerfacecolor','b')
    hold on;
    
    
    dist(i,1)=dtw(numXX,numAA);
    title(['The DTW Distance of curves dtwA and dtwB: ' num2str(dist(i,1))])
    legend('dtwA','dtwB','location','best')
end
