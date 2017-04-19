%%�Թ켣���зֿ飬����ÿ��켣�����洢
clc;
clear;
%%������ķֲ����
numLength = xlsread('G:\˶ʿ����\�켣ʶ��\matlab\test_DTW\tracing_points\tracing_points\�켣�����\numLength.xlsx');
l = size(numLength,2);  %����켣����������ũ��������
numRow = size(numLength,1); %����켣��������
maxBlock = 36;  %Ԥ��ÿ������ĵؿ������Ϊ36
numBlock = zeros(maxBlock,l);    %����ؿ�ֽ��λ�ã�����ֵΪ�ؿ�ֽ�������е�����
for i = 1:l
    y = numLength(:,i);
    ymin=min(y);
    ymax=max(y);
    x=linspace(ymin,ymax,20); %�������С����ֳ�20���ȷֵ�(19�ȷ�),Ȼ��ֱ�����������ĸ���
%     figure(i);
%     yy=hist(y,x); %�����������ĸ���
%     yyPercent=yy/length(y)*100; %�������������ռ�ٷֱ�
%     bar(x,yyPercent) %��������ֲ�ֱ��ͼ
%     for j = 1:length(x)
%         if yyPercent(j)>0.01
%             text(x(j)-(length(x)/10),yyPercent(j)+yyPercent(1)/30,num2str(yyPercent(j)));
%         end
%     end
    %%�ҳ��ؿ�ֽ�㣬�ֽ���ֵΪ�������1/10
    numBlockRow = 2;    %%�ӵڶ��п�ʼ��¼�ֽ��
    for h = 1:numRow    
        if(numLength(h,i)>(ymax/20))
            numBlock(numBlockRow,i) = h;    %%��ȡ���������ֵ��ǰһ���λ��
            numBlockRow = numBlockRow+1;
        end
    end
end
xlswrite('G:\˶ʿ����\�켣ʶ��\matlab\test_DTW\tracing_points\tracing_points\�켣�����\numBlock.xlsx',numBlock);

%%����ɢ��ͼ��ͬʱ������ͬһ�ؿ��·����������
namelist  = dir('G:\˶ʿ����\�켣ʶ��\matlab\test_DTW\tracing_points\tracing_points\*.xlsx');
numList = length(namelist);
numBlockLength = size(numBlock,1);  %����numBlock������
 for k=1:l
    X = xlsread(strcat('G:\˶ʿ����\�켣ʶ��\matlab\test_DTW\tracing_points\tracing_points\',namelist(k).name));
    numX = X(:,1:2);
    figure(k);
    subplot(1,2,1);plot(numX(:,1),numX(:,2),'o-b')
    subplot(1,2,2);
    hold on;
%     cd('G:\˶ʿ����\�켣ʶ��\matlab\test_DTW\tracing_points\tracing_points\�ֿ��켣'); %���õ�ǰ�ļ���
%      mkdir(namelist(k).name);
    for p = 1:numBlockLength-1    %�ؿ����
        AA = numBlock(p,k);     %��һ���ֽ��
        BB = numBlock(p+1,k);   %�ڶ����ֽ��
        if BB>0     %%�˴��Ƿֽ��
%             plot(numX(AA+1:BB,1),numX(AA+1:BB,2),'o-r','linewidth',3,'markerfacecolor','r')
            plot(numX(AA+1:BB,1),numX(AA+1:BB,2),'o-r')
            hold on;
            
            xlswrite(strcat('G:\˶ʿ����\�켣ʶ��\matlab\test_DTW\tracing_points\tracing_points\�ֿ��켣\',namelist(k).name,'\',num2str(p),'+',namelist(k).name),numX(AA+1:BB,:));
        end
        if BB==0
            plot(numX(AA+1:size(numX,1),1),numX(AA+1:size(numX,1),2),'o-r','linewidth',3,'markerfacecolor','r')
            hold on;
            break;
        end
    end  
 end