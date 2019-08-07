% 后处理
% y=H/2界面的位移
tarnode=[76:100];
ntarnode=length(tarnode);
xx=zeros(ntarnode,2); %xx记录y=H/2界面的位移，用于画图
for i=1:ntarnode
    xx(i,1)=node(tarnode(i),1);
    xx(i,2)=ndisp(tarnode(i),2);
end

% x=L/2界面两侧的单元(6行、2列)
tarelem=[12 13;36 37;60 61;84 85;108 109;132 133];
nytarelem=size(tarelem,1);
yy=zeros(nytarelem,2); %xx记录x=L/2界面的y坐标和剪应力，用于画图
for  i=1:nytarelem
    elem1=tarelem(i,1);
    elem2=tarelem(i,2);
    xe=node(element(elem1,:),:); %单元各个节点坐标形成的4x2矩阵   
    cury=xe(1,2); %单元形心的y坐标
    s12=0.5*(estress(elem1,3)+estress(elem2,3)); %取x=L/2界面两侧单元的平均剪应力
    yy(i,1)=cury;
    yy(i,2)=s12;
end

