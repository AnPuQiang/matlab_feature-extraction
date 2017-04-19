clc;
clear;
X = xlsread('D:\gpcs\matlab\test_DTW\2X.xlsx');
A = xlsread('D:\gpcs\matlab\test_DTW\A.xlsx');
B = xlsread('D:\gpcs\matlab\test_DTW\B.xlsx');
C = xlsread('D:\gpcs\matlab\test_DTW\C.xlsx');
D = xlsread('D:\gpcs\matlab\test_DTW\D.xlsx');
numX = X;
numA = A;
numB = B;
numC = C;
numD = D;
for i=1:size(X,1)
[numX(i,1),numX(i,2)] = BL2XY(X(i,1),X(i,2),6);
end
for i=1:size(A,1)
[numA(i,1),numA(i,2)] = BL2XY(A(i,1),A(i,2),6);
end
for i=1:size(B,1)
[numB(i,1),numB(i,2)] = BL2XY(B(i,1),B(i,2),6);
end
for i=1:size(C,1)
[numC(i,1),numC(i,2)] = BL2XY(C(i,1),C(i,2),6);
end
for i=1:size(D,1)
[numD(i,1),numD(i,2)] = BL2XY(D(i,1),D(i,2),6);
end
Y= xlsread('D:\gpcs\matlab\test_DTW\gpcs_clear.xlsx');
sizeY = size(Y,1);
numY=Y(13300:14000,:);   %9000-10000数据反常
numYZ = numY';
numXZ = numX';
numAZ = numA';
numBZ = numB';
numCZ = numC';
numDZ = numD';

numXZ=mapminmax(numXZ,-1,1);
numYZ=mapminmax(numYZ,-1,1);
numAZ=mapminmax(numAZ,-1,1);
numBZ=mapminmax(numBZ,-1,1);
numCZ=mapminmax(numCZ,-1,1);
numDZ=mapminmax(numDZ,-1,1);
numYY = numYZ';
numXX = numXZ';
numAA = numAZ';
numBB = numBZ';
numCC = numCZ';
numDD = numDZ';

P(:,1) = (1:1:size(numXX,1));
P(:,2) = numXX(:,1);
Q(:,1) = (1:1:size(numAA,1));
Q(:,2) = numAA(:,1);
distA=dtw(numXX,numAA);
distB=dtw(numXX,numBB);
distC=dtw(numXX,numCC);
distD=dtw(numXX,numDD);
distAY=dtw(numYY,numAA);
distBY=dtw(numYY,numBB);
distCY=dtw(numYY,numCC);
distDY=dtw(numYY,numDD);
distAD=dtw(numDD,numAA);
display(distAD);


subplot(2,4,1),plot(numXX(:,1),numXX(:,2));
subplot(2,4,2),plot(numYY(:,1),numYY(:,2));
subplot(2,4,5),plot(numAA(:,1),numAA(:,2));
subplot(2,4,6),plot(numBB(:,1),numBB(:,2));
subplot(2,4,7),plot(numCC(:,1),numCC(:,2));
subplot(2,4,8),plot(numDD(:,1),numDD(:,2));

% subplot(2,4,1),plot(numXX(:,1),numXX(:,2));
% subplot(2,4,2),plot(numYY(:,1),numYY(:,2));
% subplot(2,4,5),plot(numAA(:,1),numAA(:,2));
% subplot(2,4,6),plot(numBB(:,1),numBB(:,2));
% subplot(2,4,7),plot(numCC(:,1),numCC(:,2));
% subplot(2,4,8),plot(numDD(:,1),numDD(:,2));
% gpcs = xlsread('C:\Users\an puqiang\Desktop\gpcs_dataset.xlsx');
% scatter(gpcs(40000:45000,1),gpcs(40000:45000,2),6,'filled');
p=polyfit(numAA(1:10,1),numAA(1:10,2),1);
x=-1:0.01:1;
y=p(1,1)*x+p(1,2);
subplot(2,4,4);
plot(numYY(200:500,1),numYY(200:500,2));
hold on;
plot(x,y,'-r');
%%title(['The DTW Distance of curves P and Q: ' num2str(cm)])
% % legend('Q','P','location','best')