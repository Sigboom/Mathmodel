function [] = output(point,n)
Graph = zeros(n, n);
Posi = zeros(n,1);
sate = getsate(point,n);
for i = 1 : n
    if(sate.link(i) == 0),break;end
    for j = 1:8
        for k = j:8
            if(sate.link(i,j) == 0),break;end
            Graph(sate.link(j),sate.link(k)) = 2;
            Graph(sate.link(k),sate.link(j)) = 2;
        end
    end
end
for i = 1 : n
    if(point(i).key == 1)
        Posi(i) = 1;
    end
    if(point(i).degree == 0),continue;end
    for j = 1: point(i).degree
        Graph(i, point(i).link(j)) = 1;
        Graph(point(i).link(j), i) = 1;
    end
end
csvwrite('Graph.csv',Graph);
csvwrite('Posi.csv',Posi);