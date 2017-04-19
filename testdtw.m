disp('正在计算参考模板的参数...')
for i=1:10
	fname = sprintf('..\\ch6\\%da.wav',i-1);
	x = audioread(fname);
	[x1 x2] = vad(x);
	m = mfcc(x);
	m = m(x1-2:x2-2,:);
	ref(i).mfcc = m;
end

disp('正在计算测试模板的参数...')
for i=1:10
	fname = sprintf('..\\ch6\\%db.wav',i-1);
	x = audioread(fname);
	[x1 x2] = vad(x);
	m = mfcc(x);
	m = m(x1-2:x2-2,:);
	test(i).mfcc = m;
end

disp('正在进行模板匹配...')
dist = zeros(10,10);
for i=1:10
for j=1:10
	dist(i,j) = dtw(test(i).mfcc, ref(j).mfcc);
end
end

disp('正在计算匹配结果...')
for i=1:10
	[d,j] = min(dist(i,:));
	fprintf('测试模板 %d 的识别结果为：%d\n', i, j);
end
