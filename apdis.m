function dis = apdis(point, n)%该函数用来计算输入各站点的距离
%球面距离公式 
%设A点纬度β1，经度α1；B点纬度β2，经度α2，则距离S为： 
%S=R·arc cos[cosβ1cosβ2cos（α1-α2）+sinβ1sinβ2] 
%其中R为地球半径，本题中取6378km；
dis = zeros(n); %生成一个n*n的矩阵
pi = 3.1415;
R = 6378;
for i = 1:n %将角度制转化为弧度制
    point(i).a = point(i).a * pi / 180;
    point(i).b = point(i).b * pi / 180;
end
%求所有点之间距离
for i = 1:n
    for j = (i + 1):n
        dis(i, j) = R * acos(cos(point(i).b)*cos(point(j).b) ...
            * cos(point(i).a - point(j).a) + sin(point(i).b) ... 
            * sin(point(j).b));
        dis(j, i) = dis(i, j);
    end
end
for i = 1:n
    dis(i,i) = inf;
end