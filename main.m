n = 1000;              %计算的站点数
 %星站 蝴蝶站 子站 宿主站 建设成本              
Build_Scost = [1 5]; Build_Bcost = [2 10]; 
Build_satecost = 20;                      %卫星租赁成本
%子站 宿主站 传输成本 卫星传输成本
tran_Zcost = [5 10]; tran_Wcost = 50;      
xylabel = [80,85,20,25];            %设定随机生成点区域
point=rand_gene(n, xylabel);%在指定区域内随机生成 n 个站点
dis = apdis(point,n);            %计算所有站点之间距离
m = 0;                              %存储每次确定的站点数
nm = n;                             %存储剩余未确定的站点数
average = zeros(1,n);            %存储所有站点成本平均值
temp(n).link = zeros(12,3);     %存储每个站点的站群连接关系
change = [];                       %存储受影响的站点
for i  = 1 : n               %计算出输入所有点独立的站群情况
    [average(i), temp(i).link] = greed(i, point, dis, Build_Scost+tran_Zcost, Build_Bcost+tran_Zcost);
end
while(nm ~= 0)                   %循环每次更新剩下站群情况
    arm = mymin(average, temp, dis, n);
    [point,m,dis] = updata(arm,point,dis,temp(arm).link);%确定选定的站点群
    nm = nm - m;
    [change,temp,average] = updatapoint(temp,average,n, arm, point);        %找到被影响的站点
    for i = 1:length(change)                               %更新所有受影响的站群
        [average(change(i)), temp(change(i)).link] = greed(change(i),point,dis,Build_Scost,Build_Bcost);
    end
end
[Starnum,Butternum] = myplot(point, n, xylabel);                    %画站点图并计算所有站型站点数
cost = calcost(Build_Scost+tran_Zcost,Starnum,Build_Bcost+tran_Zcost,Butternum,Build_satecost + tran_Wcost,point,n);
output(point,n);