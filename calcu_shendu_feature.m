namelist  = dir('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\*.xlsx');
l = length(namelist);
for i = 1:l
data = xlsread(strcat('G:\硕士论文\轨迹识别\matlab\test_DTW\tracing_points\tracing_points\',namelist(i).name));
X = data(:,3);
a = std(X);
b = mean(X);
feature(i,1) = a/b;
end