function [Starnum, Butternum] = myplot(point,n,xylabel)%����վ�����ü�����ͼ
%��ʼ����ͼ����
clf; hold on; grid on; box on;
title('վ�����Ӽ�վ��վ��ͼ *ΪRural Starվ oΪ����վ');
xlabel('����x'); ylabel('γ��y');
rand_x1 = xylabel(1);
rand_x2 = xylabel(2);
rand_y1 = xylabel(3);
rand_y2 = xylabel(4);
axis([rand_x1 - (rand_x2 - rand_x1)/10,rand_x2 + (rand_x2 - rand_x1)/10,...
      rand_y1 - (rand_y2 - rand_y1)/10,rand_y2 + (rand_y2 - rand_y1)/10]);
xtick = rand_x1:(rand_x2 - rand_x1) / 5 : rand_x2;
ytick = rand_y1:(rand_y2 - rand_y1) / 5 : rand_y2;
set(gca,'XTick',xtick);
set(gca,'YTick',ytick);
 
%��������վ�㲢����
Starnum = zeros(1,2);   %  ��վ ��վ ����վ ��Ŀ
Butternum = zeros(1,2); %����վ ��վ ����վ ��Ŀ
for i = 1:n
    %����վ���
    if(point(i).key == 1)
        if(point(i).mode == 0)         plot(point(i).a,point(i).b,'*r','markersize',4);
            Starnum(2) = Starnum(2) + 1;
        else            plot(point(i).a,point(i).b,'or','Markersize',4,'MarkerFaceColor','r');
            Butternum(2) = Butternum(2) + 1;
        end
    else
        if(point(i).mode == 0)
      plot(point(i).a,point(i).b,'*k','markersize',3);
            Starnum(1) = Starnum(1) + 1;
        else          plot(point(i).a,point(i).b,'ok','Markersize',3);
            Butternum(1) = Butternum(1) + 1;
        end
    end
end
%����վ��վ֮�������
for i = 1:n
    if(point(i).degree > 0)
        pa = point(i).a;
        pb = point(i).b;
        for j = 1:point(i).degree
            link = point(i).link(j);
            if(pa < point(link).a)
                x = pa :1/100000:point(link).a;
            else
                x = pa :-1/100000:point(link).a;
            end
            k = (pb - point(link).b)/(pa - point(link).a);
            b = pb - pa * k;
            y = x * k + b;
            plot(x,y,'r');
        end
    end
end