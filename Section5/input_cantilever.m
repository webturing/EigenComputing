% creatmodel_cantilever
% ������������ģ��

xlength=48;
ylength=12;
nx=24;
ny=6;
spacex=xlength/nx;
spacey=ylength/ny;
% ���ɽڵ�
[meshX,meshY] = meshgrid(0:spacex:xlength,0:spacey:ylength);
[a b]=size(meshX);
count=0;
for i=1:a
    for j=1:b
        count=count+1;
        node(count,1)=meshX(i,j);
        node(count,2)=meshY(i,j);
    end
end

% ���ɾ��ε�Ԫ
count=0;
for iy=1:ny
    for ix=1:nx
        count=count+1;
        delta=(iy-1)*(nx+1);
        element(count,:)=[ix+delta,ix+1+delta,ix+1+nx+1+delta,ix+1+nx+delta];
    end
end


% ����������������
nnode=size(node,1);
nelement=size(element,1);
loadvector=zeros(nnode*2,1); %������������
loadvector(nnode*2,1)=-1000; 

% ����λ�Ʊ߽�����
nessentialdof=0; %����Լ�����ɶ����� 
for t=1:nnode
    if node(t,1)<10^-10 
        % Լ��x
        nessentialdof=nessentialdof+1;
        essentialdof(nessentialdof,1)=2*t-1;
        essentialdofdisp(nessentialdof,1)=0;
        % Լ��y
        nessentialdof=nessentialdof+1;
        essentialdof(nessentialdof,1)=2*t;
        essentialdofdisp(nessentialdof,1)=0;
    end
end

% ���ϲ���
E=3*10^7;
v=0.0; %v=0.0ʱ��ƽ��Ӧ�������ƽ��Ӧ�������D������ͬ��