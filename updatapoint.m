function [change, temp, average] = updatapoint(temp,average, n, r, point)
change = [];
%��¼�ѱ�ȷ����վ��
changed = sort(reshape(temp(r).link,1,point(r).mode * 12 + 12),'descend');
changed = [r, changed];
%��¼��Ҫ�ı��վ��
isfind = zeros(1,n);      %��Ҫ�ı��վ���Ѵ洢����ȷ����վ��
for i = 1:length(changed) %�ѱ�ȷ�ϵ�վ�������ٴθ���
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