namelist  = dir('G:\˶ʿ����\�켣ʶ��\matlab\test_DTW\tracing_points\tracing_points\*.xlsx');
l = length(namelist);
for i = 1:l
data = xlsread(strcat('G:\˶ʿ����\�켣ʶ��\matlab\test_DTW\tracing_points\tracing_points\',namelist(i).name));
X = data(:,3);
a = std(X);
b = mean(X);
feature(i,1) = a/b;
end