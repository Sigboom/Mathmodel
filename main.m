n = 1000;              %�����վ����
 %��վ ����վ ��վ ����վ ����ɱ�              
Build_Scost = [1 5]; Build_Bcost = [2 10]; 
Build_satecost = 20;                      %�������޳ɱ�
%��վ ����վ ����ɱ� ���Ǵ���ɱ�
tran_Zcost = [5 10]; tran_Wcost = 50;      
xylabel = [80,85,20,25];            %�趨������ɵ�����
point=rand_gene(n, xylabel);%��ָ��������������� n ��վ��
dis = apdis(point,n);            %��������վ��֮�����
m = 0;                              %�洢ÿ��ȷ����վ����
nm = n;                             %�洢ʣ��δȷ����վ����
average = zeros(1,n);            %�洢����վ��ɱ�ƽ��ֵ
temp(n).link = zeros(12,3);     %�洢ÿ��վ���վȺ���ӹ�ϵ
change = [];                       %�洢��Ӱ���վ��
for i  = 1 : n               %������������е������վȺ���
    [average(i), temp(i).link] = greed(i, point, dis, Build_Scost+tran_Zcost, Build_Bcost+tran_Zcost);
end
while(nm ~= 0)                   %ѭ��ÿ�θ���ʣ��վȺ���
    arm = mymin(average, temp, dis, n);
    [point,m,dis] = updata(arm,point,dis,temp(arm).link);%ȷ��ѡ����վ��Ⱥ
    nm = nm - m;
    [change,temp,average] = updatapoint(temp,average,n, arm, point);        %�ҵ���Ӱ���վ��
    for i = 1:length(change)                               %����������Ӱ���վȺ
        [average(change(i)), temp(change(i)).link] = greed(change(i),point,dis,Build_Scost,Build_Bcost);
    end
end
[Starnum,Butternum] = myplot(point, n, xylabel);                    %��վ��ͼ����������վ��վ����
cost = calcost(Build_Scost+tran_Zcost,Starnum,Build_Bcost+tran_Zcost,Butternum,Build_satecost + tran_Wcost,point,n);
output(point,n);