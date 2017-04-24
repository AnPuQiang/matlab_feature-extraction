%%以下均采用D盘路径
%%将原始的经纬度和mpu6050的txt数据提取出来，合并到一个excel文件中（还未完成）
clc;
clear;
namelist  = dir('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\*.txt');
[m1,m2,m3,m4,m5,m6,m7,m8,m9,m10]=textread('D:\gpcs\matlab\mpu6050\mpu6050\20170414.txt','%n%n%n%n%n%n%n%n%n%n','delimiter', ',');
m = [m1,m2,m3,m4,m5,m6,m7,m8,m9,m10];
l = length(namelist);
%深度特征值
feature_depth = zeros(l,1);
 for i=1:l
   % %n是读取一个数据并且转换为double类型
   [data1,data2,data3]=textread(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\',namelist(i).name),'%n%n%n','delimiter', ',');
   data = [data1,data2,data3];
   dataRow = size(data,1); %%data行数
   
   %%去除掉data中的NAN行
   [m,~] = find(isnan(data)==1);
   data(m,:) = [];
   %%去除插值点
   data=data(1:3:end,:);
   %%深度特征值的计算
   %%std:计算标准差，计算矩阵中每列的标准差
   %%mean:平均值，计算矩阵中每列的平均值
   X = data(:,3);
   a = std(X);
   b = mean(X);
   feature_depth(i,1) = a/b;
   %将txt文件的文件名提取出来
   point = strfind(namelist(i).name,'.');
   str = namelist(i).name(1:point-1);
   xlswrite(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\',str,'.xlsx'),data);
 end
%%对上述各地块的数据进行显示
%%同时计算轨迹点之间的距离存储到numLength中
namelistXLSX  = dir('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\*.xlsx');
l_XLSX = length(namelistXLSX);
numRow = zeros(l,l_XLSX);
numLength =zeros(1,l_XLSX);  %存储轨迹点间距
 for i=1:l_XLSX
    X = xlsread(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\',namelistXLSX(i).name));
    numX = X(:,1:2);
    %计算相邻轨迹点之间的距离
    numRow(i,1) = size(X,1);
    numPoint = size(numX,1);    %计算该图轨迹点的个数
    for j = 2:numPoint
       numLength(j-1,i) = sqrt((numX(j,1)-numX(j-1,1))^2 + (numX(j,2)-numX(j-1,2))^2 );
    end
    %%将轨迹点保存成图片
%     figure(i);
%     plot(numX(:,1),numX(:,2),'o-r','linewidth',2,'markerfacecolor','r')
%     saveas(i,['D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\图片\',int2str(i),'.jpg']);
 end
xlswrite('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\轨迹点距离\numLength.xlsx',numLength);
%%
%%对轨迹进行分块，并将每块轨迹单独存储
%%计算间距的分布情况
l = size(numLength,2);  %计算轨迹的列数，即农机的数量
numRow = size(numLength,1); %计算轨迹间距的行数
maxBlock = 36;  %预设每天耕作的地块数最多为36
numBlock = zeros(maxBlock,l);    %保存地块分界点位置，保存值为地块分界点所属行的行数
for i = 1:l
    y = numLength(:,i);
    ymin=min(y);
    ymax=max(y);
    x=linspace(ymin,ymax,20); %将最大最小区间分成20个等分点(19等分),然后分别计算各个区间的个数
%     figure(i);
%     yy=hist(y,x); %计算各个区间的个数
%     yyPercent=yy/length(y)*100; %计算各个区间所占百分比
%     bar(x,yyPercent) %画出间距点分布直方图
%     for j = 1:length(x)
%         if yyPercent(j)>0.01
%             text(x(j)-(length(x)/10),yyPercent(j)+yyPercent(1)/30,num2str(yyPercent(j)));
%         end
%     end
    %%找出地块分界点，分界阈值为最大距离的1/10
    numBlockRow = 2;    %%从第二行开始记录分界点
    for h = 1:numRow    
        if(numLength(h,i)>(ymax/10))
            numBlock(numBlockRow,i) = h;    %%获取超过间距阈值的前一点的位置
            numBlockRow = numBlockRow+1;
        end
    end
end
xlswrite('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\轨迹点距离\numBlock.xlsx',numBlock);
%%
%%绘制散点图，同时将属于同一地块的路径连接起来
%将分块后的各部分轨迹保存到\分块后轨迹\对应的各自编号的文件夹中
namelist  = dir('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\*.xlsx');
numList = length(namelist);
numBlockLength = size(numBlock,1);  %计算numBlock的行数
name = zeros(1,length(namelist));
for j = 1:length(namelist)
        point = strfind(namelist(j).name,'.');
        str = str2double(namelist(j).name(1:point-1));
        name(1,j) = str;
end
cd('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\'); %设置当前文件夹
mkdir('分块后轨迹');
 for k=1:l
    X = xlsread(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\',namelist(k).name));
    numX = X(:,1:2);
%     figure(k);
%     subplot(1,2,1);plot(numX(:,1),numX(:,2),'o-b')
%     subplot(1,2,2);
    hold on;
    cd('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹'); %设置当前文件夹
     mkdir(num2str(name(1,k)));
    for p = 1:numBlockLength-1    %地块序号
        AA = numBlock(p,k);     %第一个分界点
        BB = numBlock(p+1,k);   %第二个分界点
        if BB>0     %%此处是分界点
%             plot(numX(AA+1:BB,1),numX(AA+1:BB,2),'o-r','linewidth',3,'markerfacecolor','r')
%             plot(numX(AA+1:BB,1),numX(AA+1:BB,2),'o-r')
            hold on;
            xlswrite(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\',num2str(name(1,k)),'\',num2str(p),'+',namelist(k).name),numX(AA+1:BB,:));
        end
        if BB==0
%             plot(numX(AA+1:size(numX,1),1),numX(AA+1:size(numX,1),2),'o-r','linewidth',3,'markerfacecolor','r')
            hold on;
            break;
        end
    end  
%     saveas(k,['D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\图片\',strcat('分块',int2str(k)),'.jpg']);
 end
% clc;
% clear;
%%提取各地块轨迹中的拐点
namelist  = dir('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\*.xlsx');
name = zeros(1,length(namelist));
for j = 1:length(namelist)
   point = strfind(namelist(j).name,'.');
   str = str2double(namelist(j).name(1:point-1));
   name(1,j) = str;
end
for loop = 1:size(name,2)
namelistINFLECT  = dir(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\',num2str(name(1,loop)),'\*.xlsx'));
l = length(namelistINFLECT);   %此轨迹分得的地块数
inflectionPoints = [];
 for i=1:l
    XINFLECT = xlsread(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\',num2str(name(1,loop)),'\',namelistINFLECT(i).name));
    numXINFLECT = XINFLECT;
    numXZINFLECT = numXINFLECT';
    numXZINFLECT=mapminmax(numXZINFLECT,-1,1);
    numXXINFLECT = numXZINFLECT';
    angleNum = zeros(size(numXXINFLECT,1),1);
%     figure(i);
%     plot(numXX(:,1),numXX(:,2),'r');
    hold on;
    beginPoint = 1;
    for k = 2:(size(numXXINFLECT,1)-1)
        angleNum(k,1) = find_angle(numXXINFLECT(k-1,:),numXXINFLECT(k,:),numXXINFLECT(k+1,:));
        if angleNum(k,1)<=120
            inflectionPoints(beginPoint,2*i-1:2*i) = numXXINFLECT(k,:);
            beginPoint = beginPoint+1;
%             scatter(numXXINFLECT(k,1),numXXINFLECT(k,2),20,'filled'); 
%             hold on;
        end
    end  
 end
 xlswrite(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\','inflection',namelistINFLECT(1).name),inflectionPoints);
end
%%
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
namelistDTW  = dir('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\*.xlsx');
l = length(namelistDTW); 
for i = 1:l
    X = xlsread(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\',namelistDTW(i).name));
    rowX = size(X,2);
    XX = [];
    for j = 1:2:rowX
       XX = X(:,j:j+1);
       idA = XX(:,1) == 0;
       XX(idA,:) = []; 
       numXXZ = XX';
       numXXZ=mapminmax(numXXZ,-1,1);
       numXXX = numXXZ';
       idA = find( numXXX(:,1) == 0);
            numXXX(idA,:) = []; 
       
       if  ~isempty(numXXX)
%            if dtw(numAA,numXXX)<1000000
           distDTW(i,j) = dtw(numAA,numXXX);
%            end
       end
%        if  isempty(numXXX)
%            break;
%        end
    end  
end
dtw = sum(distDTW,2);
feature_DTW = zeros(l,1);
[m,n] = size(distDTW);
for i = 1:m
    count = 0;
    for j = 1:n
        if distDTW(i,j) > 0
            count = count+1;
            feature_DTW(i,1) = feature_DTW(i,1)+distDTW(i,j);
        end
    end
    feature_DTW(i,1) = feature_DTW(i,1)/count;
    
end
cd('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹'); %设置当前文件夹
mkdir('distDTW');
xlswrite('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\distDTW\distDTW.xlsx',distDTW);

% xlswrite('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\分块后轨迹\distDTW\feature_DTW.xlsx',feature_DTW);
%%
function [ angle ] = find_angle( A,B,C )
%求每三个点形成的角度
a = sqrt((B(1,1)-C(1,1))^2+(B(1,2)-C(1,2))^2);
b = sqrt((A(1,1)-C(1,1))^2+(A(1,2)-C(1,2))^2);
c = sqrt((B(1,1)-A(1,1))^2+(B(1,2)-A(1,2))^2);

pos = (a.^2+c.^2-b.^2)/(2*a*c);
angle = (acos(pos))*180/pi;         %%余弦值装换为弧度值
% disp(realangle);
end
%%

