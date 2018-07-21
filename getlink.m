function link = getlink(i, point, dis)
link = zeros(point(i).mode * 4 + 4,3);%初始化存储连接矩阵
dis(:,i) = inf;                   %消除宿主站被连接的情况
%若为单点则<= 20范围内没有其他点则必为宿主站。
%若不为单点则对于其他点不可见
while(point(i).degree < point(i).mode * 4 + 4)
    [imin, j] = min(dis(i,:));
    if(imin <= 20)      %筛选出距离小于20的二级站点
        point(i).degree = point(i).degree + 1;
        point(i).all = point(i).all + 1;
        point(i).link(point(i).degree) = j;
        dis(:,j) = inf;
    else
        break;
    end
end
for n = 1:point(i).degree   %记录二级连接情况
    link(n,1) = point(i).link(n);
end
imin = min(dis(i,:));
%若度为0，则该站点无二级站点，若剩余站点距离大于40，则无三级站点
%筛选满足约束的 40以内的三级站点
if(point(i).degree ~= 0 && imin <= 40)
    while(point(i).all < point(i).mode * 6 + 6)
        k = 0;
        jmin = inf;
        %从所有非一二级站点中选取距离二级站点最近的站点
        for j = 1:point(i).degree  
            %若二级站点被连接过，则无需找最近站点
            if(point(point(i).link(j)).degree == 1)
                 link(j,2)= point(point(i).link(j)).link;
                continue; 
            end
            [jmintemp, ktemp]= min(dis(point(i).link(j),:));
            if(jmintemp < jmin)
                jmin = jmintemp;
                k = ktemp;
                jp = point(i).link(j);
                rowj = j;
            end
        end
        if(k == 0), break;end;
        j = jp; 
        if(jmin <= 10)
            point(j).degree = point(j).degree + 1;
            point(i).all = point(i).all + 1;
            point(j).link = k;
            link(rowj, 2) = k;
            dis(:,k) = inf;
        else
            break;
        end
    end
    %二级站点已满连或者没有距离小于等于10的三级站点
    k = 0;
    jmin = inf;
    for j = 1:point(i).degree
        if(point(point(i).link(j)).degree == 1)
            [jmintemp, ktemp]= min(dis(point(i).link(j),:));
            if(jmintemp < jmin)
                jmin = jmintemp;
                k = ktemp;
            end
        end
    end
    %若 k 为 0 则没有三级站点，则更不存在四级站点。
    %若剩余站点最近距离大于20，则不存在四级站点。
    if(k ~= 0 && jmin < 20)
        %筛选距离三级站点最近的站点候选四级站点
        kmin = inf;
        %从所有非一二三级站点中选取距离三级点最近的站点
        for j = 1:point(i).degree
            %若该二级站点没有子站，则查看下一二级站点
            if(point(point(i).link(j)).degree ~= 1),continue;end
            k = point(point(i).link(j)).link;
         %若该二级站点的子站点有连接，则将其存储入link第3列中
            [kmintemp, ltemp] = min(dis(k,:));
            if(kmintemp < kmin)
                kmin = kmintemp;
                li = ltemp;
                kp = k;
                jp = j;
            end
        end
        k = kp;
        j = jp;
        %如果距三级站点最近站点距离大于10，则跳出循环
        if(kmin < 10)
            point(k).degree = point(k).degree + 1;
            point(k).link = li;
            link(j,3) = li;
        end
    end
end 
function arm = mymin(average, temp, dis, n)
minavg = inf;
mindis = inf; 
dissum = 0;
for i = 1 : n
    if(average(i) == inf),continue;end
    if(average(i) < minavg)
        for k = 1:3
            for j = 1: length(temp(i).link(:,1))
                if(temp(i).link(j,k) == 0),continue,end
                if(k == 1)
                    dissum = dissum + dis(i,temp(i).link(j));
                else
                    dissum = dissum + dis(temp(i).link(j,k),temp(i).link(j,k - 1));
                end
            end
        end
        mindis = dissum;
        minavg = average(i);
        arm = i;
    else
        if(average(i) == minavg)
            for k = 1:3
                for j = 1: length(temp(i).link(:,1))
                    if(temp(i).link(j,k) == 0),continue,end
                    if(k == 1)
                        dissum = dissum + dis(i,temp(i).link(j));
                    else
                        dissum = dissum + dis(temp(i).link(j,k),temp(i).link(j,k - 1));
                    end
                end
            end
            if(dissum < mindis)
                mindis = dissum;
                arm = i;
            end
        end
    end
end