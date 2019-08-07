% ����
% y=H/2�����λ��
tarnode=[76:100];
ntarnode=length(tarnode);
xx=zeros(ntarnode,2); %xx��¼y=H/2�����λ�ƣ����ڻ�ͼ
for i=1:ntarnode
    xx(i,1)=node(tarnode(i),1);
    xx(i,2)=ndisp(tarnode(i),2);
end

% x=L/2��������ĵ�Ԫ(6�С�2��)
tarelem=[12 13;36 37;60 61;84 85;108 109;132 133];
nytarelem=size(tarelem,1);
yy=zeros(nytarelem,2); %xx��¼x=L/2�����y����ͼ�Ӧ�������ڻ�ͼ
for  i=1:nytarelem
    elem1=tarelem(i,1);
    elem2=tarelem(i,2);
    xe=node(element(elem1,:),:); %��Ԫ�����ڵ������γɵ�4x2����   
    cury=xe(1,2); %��Ԫ���ĵ�y����
    s12=0.5*(estress(elem1,3)+estress(elem2,3)); %ȡx=L/2�������൥Ԫ��ƽ����Ӧ��
    yy(i,1)=cury;
    yy(i,2)=s12;
end

