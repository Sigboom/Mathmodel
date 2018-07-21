function [average, link] = greed(n, point, dis, Scost, Bcost)
link = getlink(n, point, dis);%当 point(n)为 宿主站时站群连接情况
if(point(n).mode == 0)
    average = Scost(2);
else
    average = Bcost(2);
end
num = 1;
for i = 1 : point(n).mode * 12 + 12
    if(link(i) ~= 0)
        if(point(link(i)).mode == 0)
            average = average + Scost(1);
        else
            average = average + Bcost(1);
        end
        num = num + 1;
    end
end
average = average / num;