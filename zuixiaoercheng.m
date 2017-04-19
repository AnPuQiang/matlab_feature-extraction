p=polyfit(numAA(1:10,1),numAA(1:10,2),1);
x=-1:0.01:1;
y=p(1,1)*x+p(1,2);
plot(numAA(:,1),numAA(:,2));
hold on;
plot(x,y,'-r');