%DTW算法，计算测试轨迹与模板轨迹之间的距离
 %t为待测试轨迹，r为模板轨迹；轨迹输入均为n行2列的矩阵，n的值代表点数
 %20170210
function dist = dtw(t,r)
n = size(t,1);  
m = size(r,1);

% 帧匹配距离矩阵
d = zeros(n,m);

for i = 1:n
for j = 1:m
	d(i,j) = sum((t(i,:)-r(j,:)).^2);   %存放两个轨迹之间各点的距离
end
end

% 累积距离矩阵
D =  ones(n,m) * realmax;
D(1,1) = d(1,1);

% 动态规划
for i = 2:n
for j = 1:m
	D1 = D(i-1,j);

	if j>1
		D2 = D(i-1,j-1);
    else
        D2 = realmax;
	end

	if j>2
		D3 = D(i-1,j-2);
    else
        D3 = realmax;
	end

	D(i,j) = d(i,j) + min([D1,D2,D3]);
end
end

dist = D(n,m);