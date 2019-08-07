function status=plotcloud(element,node,value)
% ���룺��Ԫ��Ϣelement���ڵ���Ϣnode����Ԫ��value
% �������ʾ��Ԫ��ֲ�����ͼ


nelement=size(element,1);
nnode=size(node,1);

figure
hold on;
for ie=1:nelement
    curpolygon=[element(ie,:),element(ie,1)];%Connectivity Matrix
    x=node(curpolygon,1);
    y=node(curpolygon,2);
    temp=length(x);
    s(1:temp)=value(ie,1);
    fill(x,y,s,'FaceColor','interp');
end

shading interp;
%shading flat
%shading faceted

set(gcf,'color','white')

hold off;
colormap(jet)
colorbar
axis equal
axis off
status='plot completed!'

end