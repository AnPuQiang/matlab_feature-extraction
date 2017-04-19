clc;
clear;
%%计算间距的分布情况
numLength = xlsread('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\轨迹点距离\numLength.xlsx');
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
        if(numLength(h,i)>(ymax/20))
            numBlock(numBlockRow,i) = h;    %%获取超过间距阈值的前一点的位置
            numBlockRow = numBlockRow+1;
        end
    end
end
xlswrite('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\轨迹点距离\numBlock.xlsx',numBlock);

%%绘制散点图，同时将属于同一地块的路径连接起来
namelist  = dir('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\*.xlsx');
numList = length(namelist);
numBlockLength = size(numBlock,1);  %计算numBlock的行数
 for k=1:l
    X = xlsread(strcat('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\',namelist(k).name));
    numX = X(:,1:2);
    figure(k+l);
%     scatter(numX(:,1),X(:,2),6,'filled');
    hold on;
    for p = 1:numBlockLength-1    %地块序号
        AA = numBlock(p,k);     %第一个分界点
        BB = numBlock(p+1,k);   %第二个分界点
        if BB>0
            plot(numX(AA+1:BB,1),numX(AA+1:BB,2),'o-r','linewidth',3,'markerfacecolor','r')
            hold on;
        end
        if BB==0
            plot(numX(AA+1:size(numX,1),1),numX(AA+1:size(numX,1),2),'o-r','linewidth',3,'markerfacecolor','r')
            hold on;
            break;
        end
    end  
 end