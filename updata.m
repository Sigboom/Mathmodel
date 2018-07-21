function [point, num, dis] = updata(n,point,dis,link)
num = 1;
%更新宿主站点信息
point(n).key = 1;
dis(n, :) = inf;
dis(:, n) = inf;
point(n).link = link(:,1);
%更新所有站点信息
for i = 1 : 3
    for j = 1: point(n).mode * 4 + 4
        if(link(j,i) ~= 0)
            point(link(j,i)).key = 0;
            dis(link(j,i),:) = inf;
            dis(:,link(j,i)) = inf;
            
            if(i == 1)
                point(n).degree = point(n).degree + 1;
            else
                point(link(j,i - 1)).degree = point(link(j,i - 1)).degree + 1;
                point(link(j,i - 1)).link = link(j,i);
            end
            point(n).all = point(n).all + 1;
        end
    end
end
num = num + point(n).all;