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
    beginPoint = 1;
    for k = 2:(size(numXX,1)-1)
        angleNum(k,1) = find_angle(numXX(k-1,:),numXX(k,:),numXX(k+1,:));
        if angleNum(k,1)<=100
            inflectionPoints(beginPoint,2*i-1:2*i) = numXX(k,:);
            beginPoint = beginPoint+1;
            scatter(numXX(k,1),numXX(k,2),200,'k','filled'); 
            hold on;
        end
    end
    
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
    beginPoint = 1;
    for k = 2:(size(numAA,1)-1)
        angleNum(k,1) = find_angle(numAA(k-1,:),numAA(k,:),numAA(k+1,:));
        if angleNum(k,1)<=100
            inflectionPoints(beginPoint,2*i+1:2*i+2) = numXX(k,:);
            beginPoint = beginPoint+1;
            scatter(numAA(k,1),numAA(k,2),200,'g','filled'); 
            hold on;
        end
    end
    dtwA = inflectionPoints(:,2*i-1:2*i);
    idA = find( dtwA(:,1) == 0);
    dtwA(idA,:) = []; 
    dtwB = inflectionPoints(:,2*i+1:2*i+2);
    idB = find( dtwB(:,1) == 0);
    dtwB(idB,:) = []; 
    dist(i,1)=dtw(dtwA,dtwB);
    title(['The DTW Distance of curves dtwA and dtwB: ' num2str(dist(i,1))])
    legend('dtwA','dtwB','location','best')
end


% plot(numAA(:,1),numAA(:,2),'o-b','linewidth',3,'markerfacecolor','b')
% title(['The DTW Distance of curves P and Q: ' num2str(distA)])
% legend('P','Q','location','best')
% figure(2)
% plot(numXX(:,1),numXX(:,2),'o-r','linewidth',3,'markerfacecolor','r')
% hold on
% plot(numBB(:,1),numBB(:,2),'o-b','linewidth',3,'markerfacecolor','b')
% title(['The DTW Distance of curves P and Q: ' num2str(distB)])
% legend('P','Q','location','best')
