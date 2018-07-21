function cost = calcost(Scost,Starnum,Bcost,Butternum,satecost,point,dis)
%计算需要卫星数量
sate = getsate(point, dis);
cost = Scost * Starnum' + Bcost * Butternum' + satecost * sate.num;
disp(['cost is ' num2str(cost)]);
function sate = getsate(point,n)
sate.count = 0;
sate.link = zeros(n ,8);
is_link = zeros(1,n);
dis = zeros(1,n);
pi = 3.1415;
R = 6378;
for i = 1:n %将角度制转化为弧度制
    point(i).a = point(i).a * pi / 180;
    point(i).b = point(i).b * pi / 180;
end
for i = 1 : n
    for j = (i + 1) : n
        if(point(i).key ~= 1 || point(j).key ~= 1)
            dis(i,j) = 0;
        else
            dis(i, j) = (R * acos(cos(point(i).b)*cos(point(j).b) ...
                * cos(point(i).a - point(j).a) + sin(point(i).b) ...
                * sin(point(j).b)) <= 50);
        end
    end
end
for i = 1 : n
    if(is_link(i)),continue; end
    sate.count = sate.count + 1;
    sate.link(sate.count) = i;
    is_link(i) = 1;
    temp = 1;
    for j = (i + 1) : n
        if(dis(i,j))
            temp = temp + 1;
            sate.link(sate.count,temp) = j;
            is_link(j) = 1;
            if(temp >= 8),break;end
        end
    end
end
sate.num = ceil(sate.count / 8);