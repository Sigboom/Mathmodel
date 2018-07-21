function point = rand_gene(n, xylabel)
point(n).mode = 1;
 
for i = 1 : n
    point(i).mode = round(rand(1,1));
    point(i).key = -1;%��ʼ��
    %����Ϊ����������Ϊ����
    point(i).a = mod(rand(1,1) * 1000,xylabel(2) - xylabel(1)) + xylabel(1);
    %����Ϊ��γ������Ϊ��γ
    point(i).b = mod(rand(1,1) * 1000,xylabel(4) - xylabel(3)) + xylabel(3);
    point(i).degree = 0;
    point(i).all = 0;
    point(i).link = [];
end