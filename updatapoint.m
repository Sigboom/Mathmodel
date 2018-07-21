function [change, temp, average] = updatapoint(temp,average, n, r, point)
change = [];
%记录已被确定的站点
changed = sort(reshape(temp(r).link,1,point(r).mode * 12 + 12),'descend');
changed = [r, changed];
%记录需要改变的站点
isfind = zeros(1,n);      %需要改变的站点已存储或已确定的站点
for i = 1:length(changed) %已被确认的站点无需再次更新
    if(changed(i) == 0),break;end
    temp(changed(i)).link = [];
    average(changed(i)) = inf;
    isfind(changed(i)) = 1;
end
for i = 1:length(changed)
    if(changed(i) == 0),break;end
    befind = changed(i);
    for j = 1 : n
        if(isfind(j) == 1),continue;end
        if(sum(sum(ismember(temp(j).link,befind)))~=0)
            change = [change, j];
            isfind(j) = 1;
        end
    end
end