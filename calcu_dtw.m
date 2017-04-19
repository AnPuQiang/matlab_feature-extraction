clc;
clear;
A = xlsread('D:\gpcs\matlab\test_DTW\A.xlsx');
numA = A;
for K=1:size(A,1)
        [numA(K,1),numA(K,2)] = BL2XY(A(K,1),A(K,2),6);
end
numAZ = numA';
numAZ=mapminmax(numAZ,-1,1);
numAA = numAZ';
distDTW = [];
namelist  = dir('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\*.xlsx');
l = length(namelist); 
for i = 1:l
    X = xlsread(strcat('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\',namelist(i).name));
    rowX = size(X,2);
    XX = [];
    for j = 1:2:rowX
       XX = X(:,j:j+1);
       idA = find(XX(:,1) == 0);
       XX(idA,:) = []; 
       numXXZ = XX';
       numXXZ=mapminmax(numXXZ,-1,1);
       numXXX = numXXZ';
       idA = find( numXXX(:,1) == 0);
            numXXX(idA,:) = []; 
       
       if  ~isempty(numXXX)
           if dtw(numAA,numXXX)<10000
           distDTW(i,j) = dtw(numAA,numXXX);
           end
       end
%        if  isempty(numXXX)
%            break;
%        end
       
       
    end
    
end
dtw = sum(distDTW,2);
xlswrite('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\distDTW\distDTW.xlsx',distDTW)