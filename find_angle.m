function [ angle ] = find_angle( A,B,C )
%��ÿ�������γɵĽǶ�
a = sqrt((B(1,1)-C(1,1))^2+(B(1,2)-C(1,2))^2);
b = sqrt((A(1,1)-C(1,1))^2+(A(1,2)-C(1,2))^2);
c = sqrt((B(1,1)-A(1,1))^2+(B(1,2)-A(1,2))^2);

pos = (a.^2+c.^2-b.^2)/(2*a*c);
angle = (acos(pos))*180/pi;         %%����ֵװ��Ϊ����ֵ
% disp(realangle);


end

