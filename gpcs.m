%%���¾�����D��·��
%%��ԭʼ�ľ�γ�Ⱥ�mpu6050��txt������ȡ�������ϲ���һ��excel�ļ��У���δ��ɣ�
clc;
clear;
namelist  = dir('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\*.txt');
[m1,m2,m3,m4,m5,m6,m7,m8,m9,m10]=textread('D:\gpcs\matlab\mpu6050\mpu6050\20170414.txt','%n%n%n%n%n%n%n%n%n%n','delimiter', ',');
m = [m1,m2,m3,m4,m5,m6,m7,m8,m9,m10];
l = length(namelist);
 for i=1:l
   % %n�Ƕ�ȡһ�����ݲ���ת��Ϊdouble����
   [data1,data2,data3]=textread(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\',namelist(i).name),'%n%n%n','delimiter', ',');
   data = [data1,data2,data3];
   dataRow = size(data,1); %%data����
   
   %%ȥ����data�е�NAN��
   [m,n] = find(isnan(data)==1);
   data(m,:) = [];
   %%ȥ����ֵ��
   data=data(1:3:end,:);
   %��txt�ļ����ļ�����ȡ����
   point = strfind(namelist(i).name,'.');
   str = namelist(i).name(1:point-1);
   xlswrite(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\',str,'.xlsx'),data);
 end
%%���������ؿ�����ݽ�����ʾ
%%ͬʱ����켣��֮��ľ���洢��numLength��
namelistXLSX  = dir('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\*.xlsx');
l_XLSX = length(namelistXLSX);
numRow = zeros(l,l_XLSX);
numLength =zeros(1,l_XLSX);  %�洢�켣����
 for i=1:l_XLSX
    X = xlsread(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\',namelistXLSX(i).name));
    numX = X(:,1:2);
    %�������ڹ켣��֮��ľ���
    numRow(i,1) = size(X,1);
    numPoint = size(numX,1);    %�����ͼ�켣��ĸ���
    for j = 2:numPoint
       numLength(j-1,i) = sqrt((numX(j,1)-numX(j-1,1))^2 + (numX(j,2)-numX(j-1,2))^2 );
    end
    %%���켣�㱣���ͼƬ
%     figure(i);
%     plot(numX(:,1),numX(:,2),'o-r','linewidth',2,'markerfacecolor','r')
%     saveas(i,['D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\ͼƬ\',int2str(i),'.jpg']);
 end
xlswrite('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\�켣�����\numLength.xlsx',numLength);
%%
%%�Թ켣���зֿ飬����ÿ��켣�����洢
%%������ķֲ����
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
xlswrite('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\�켣�����\numBlock.xlsx',numBlock);
%%
%%����ɢ��ͼ��ͬʱ������ͬһ�ؿ��·����������
%���ֿ��ĸ����ֹ켣���浽\�ֿ��켣\��Ӧ�ĸ��Ա�ŵ��ļ�����
namelist  = dir('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\*.xlsx');
numList = length(namelist);
numBlockLength = size(numBlock,1);  %����numBlock������
cd('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\'); %���õ�ǰ�ļ���
mkdir('�ֿ��켣');
 for k=1:l
    X = xlsread(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\',namelist(k).name));
    numX = X(:,1:2);
    figure(k);
    subplot(1,2,1);plot(numX(:,1),numX(:,2),'o-b')
    subplot(1,2,2);
    hold on;
    cd('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\�ֿ��켣'); %���õ�ǰ�ļ���
     mkdir(namelist(k).name);
    for p = 1:numBlockLength-1    %�ؿ����
        AA = numBlock(p,k);     %��һ���ֽ��
        BB = numBlock(p+1,k);   %�ڶ����ֽ��
        if BB>0     %%�˴��Ƿֽ��
%             plot(numX(AA+1:BB,1),numX(AA+1:BB,2),'o-r','linewidth',3,'markerfacecolor','r')
            plot(numX(AA+1:BB,1),numX(AA+1:BB,2),'o-r')
            hold on;
            xlswrite(strcat('D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\�ֿ��켣\',namelist(k).name,'\',num2str(p),'+',namelist(k).name),numX(AA+1:BB,:));
        end
        if BB==0
            plot(numX(AA+1:size(numX,1),1),numX(AA+1:size(numX,1),2),'o-r','linewidth',3,'markerfacecolor','r')
            hold on;
            break;
        end
    end  
    saveas(k,['D:\gpcs\matlab\test_DTW\tracing_points\tracing_points\ͼƬ\',strcat('�ֿ�',int2str(k)),'.jpg']);
 end
 
%%��ȡ���ؿ�켣�еĹյ�


