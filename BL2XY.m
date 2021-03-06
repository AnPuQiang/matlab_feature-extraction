function [ x,y ] = BL2XY( B,L,k )
% 此函数用于进行高斯正算

a=6378137;
e=0.081819191042811;

ee=e/sqrt(1-e^2);
% 计算中央子午线经度
if k==6
    L0=6*(fix(L/6)+1)-3;
elseif k==3
    L0=3*(fix((L-1.5)/3)+1);
end
LP=(L-L0)/180*pi;
B=B/180*pi;

% 计算子午圈弧长
ap=1+3/4*e^2+45/64*e^4+175/256*e^6+11025/16384*e^8+43659/65536*e^10;
bp=3/4*e^2+15/16*e^4+525/512*e^6+2205/2048*e^8+72765/65536*e^10;
cp=15/64*e^4+105/256*e^6+2205/4096*e^8+10395/16384*e^10;
dp=35/512*e^6+315/2048*e^8+31185/131072*e^10;
ep=315/16384*e^8+3465/65536*e^10;
fp=639/131072*e^10;
X=a*(1-e^2)*(ap*B-bp/2*sin(2*B)+cp/4*sin(4*B)-dp/6*sin(6*B)+ep/8*sin(8*B)-fp/10*sin(10*B));

% 计算高斯平面坐标
N=a/sqrt(1-e^2*sin(B)*sin(B));
eta=ee*cos(B);
t=tan(B);
m=cos(B)*LP;
x=X+N*t*(0.5*m^2+1/24*(5-t^2+9*eta^2+4*eta^4)*m^4+1/720*(61-58*t^2+t^4)*m^6);
y=N*(m+1/6*(1-t^2+eta^2)*m^3+1/120*(5-18*t^2+t^4+14*eta^2-58*eta^2*t^2)*m^5);




end

