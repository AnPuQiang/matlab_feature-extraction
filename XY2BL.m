function [ B,L ] = XY2BL( x,y,a,e,L0 )
% 此函数用于进行高斯反算

% CGCS2000椭球参数
% a=6378137;
% e=0.081819191042811;
% ee=0.0820944381518626;
% 1975国际椭球参数
% a=6378140;
% e=0.0818192214555235;

ee=e/sqrt(1-e^2);
% 计算底点的经度
ap=1+3/4*e^2+45/64*e^4+175/256*e^6+11025/16384*e^8+43659/65536*e^10;
bp=3/4*e^2+15/16*e^4+525/512*e^6+2205/2048*e^8+72765/65536*e^10;
cp=15/64*e^4+105/256*e^6+2205/4096*e^8+10395/16384*e^10;
dp=35/512*e^6+315/2048*e^8+31185/131072*e^10;
ep=315/16384*e^8+3465/65536*e^10;
fp=639/131072*e^10;

B=x/(a*(1-e^2)*ap);
deltaB=1000;
while deltaB>10^(-20)
    Bi=1/ap*(x/(a*(1-e^2))+bp/2*sin(2*B)-cp/4*sin(4*B)+dp/6*sin(6*B)-ep/8*sin(8*B)+fp/10*sin(10*B));
    deltaB=abs(Bi-B);
    B=Bi;
end
Bf=B;

% 计算大地经纬度BL
tf=tan(Bf);
Vf=sqrt(1+ee^2*cos(Bf)*cos(Bf));
Wf=sqrt(1-e^2*sin(Bf)*sin(Bf));
Nf=a/Wf;
etaf=ee*cos(Bf);
B=Bf-1/2*Vf^2*tf*((y/Nf)*(y/Nf)-1/12*(5+3*tf^2+etaf^2-9*etaf^2*tf^2)*(y/Nf)^4+1/360*(61+90*tf^2+45*tf^4)*(y/Nf)^6);
LP=1/cos(Bf)*((y/Nf)-1/6*(1+2*tf^2+etaf^2)*(y/Nf)^3+1/120*(5+28*tf^2+24*tf^4+6*etaf^2+8*etaf^2*tf^2)*(y/Nf)^5);
B=B/pi*180;
LP=LP/pi*180;
L=L0+LP;


end

