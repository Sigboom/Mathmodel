function dis = apdis(point, n)%�ú����������������վ��ľ���
%������빫ʽ 
%��A��γ�Ȧ�1�����Ȧ�1��B��γ�Ȧ�2�����Ȧ�2�������SΪ�� 
%S=R��arc cos[cos��1cos��2cos����1-��2��+sin��1sin��2] 
%����RΪ����뾶��������ȡ6378km��
dis = zeros(n); %����һ��n*n�ľ���
pi = 3.1415;
R = 6378;
for i = 1:n %���Ƕ���ת��Ϊ������
    point(i).a = point(i).a * pi / 180;
    point(i).b = point(i).b * pi / 180;
end
%�����е�֮�����
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