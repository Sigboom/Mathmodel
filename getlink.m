function link = getlink(i, point, dis)
link = zeros(point(i).mode * 4 + 4,3);%��ʼ���洢���Ӿ���
dis(:,i) = inf;                   %��������վ�����ӵ����
%��Ϊ������<= 20��Χ��û�����������Ϊ����վ��
%����Ϊ��������������㲻�ɼ�
while(point(i).degree < point(i).mode * 4 + 4)
    [imin, j] = min(dis(i,:));
    if(imin <= 20)      %ɸѡ������С��20�Ķ���վ��
        point(i).degree = point(i).degree + 1;
        point(i).all = point(i).all + 1;
        point(i).link(point(i).degree) = j;
        dis(:,j) = inf;
    else
        break;
    end
end
for n = 1:point(i).degree   %��¼�����������
    link(n,1) = point(i).link(n);
end
imin = min(dis(i,:));
%����Ϊ0�����վ���޶���վ�㣬��ʣ��վ��������40����������վ��
%ɸѡ����Լ���� 40���ڵ�����վ��
if(point(i).degree ~= 0 && imin <= 40)
    while(point(i).all < point(i).mode * 6 + 6)
        k = 0;
        jmin = inf;
        %�����з�һ����վ����ѡȡ�������վ�������վ��
        for j = 1:point(i).degree  
            %������վ�㱻���ӹ��������������վ��
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
    %����վ������������û�о���С�ڵ���10������վ��
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
    %�� k Ϊ 0 ��û������վ�㣬����������ļ�վ�㡣
    %��ʣ��վ������������20���򲻴����ļ�վ�㡣
    if(k ~= 0 && jmin < 20)
        %ɸѡ��������վ�������վ���ѡ�ļ�վ��
        kmin = inf;
        %�����з�һ������վ����ѡȡ���������������վ��
        for j = 1:point(i).degree
            %���ö���վ��û����վ����鿴��һ����վ��
            if(point(point(i).link(j)).degree ~= 1),continue;end
            k = point(point(i).link(j)).link;
         %���ö���վ�����վ�������ӣ�����洢��link��3����
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
        %���������վ�����վ��������10��������ѭ��
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