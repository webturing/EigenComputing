% creatmodel_cantilever
% 建立悬臂梁的模型

xlength=48;
ylength=12;
nx=24;
ny=6;
spacex=xlength/nx;
spacey=ylength/ny;
% 生成节点
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

% 生成矩形单元
count=0;
for iy=1:ny
    for ix=1:nx
        count=count+1;
        delta=(iy-1)*(nx+1);
        element(count,:)=[ix+delta,ix+1+delta,ix+1+nx+1+delta,ix+1+nx+delta];
    end
end


% 计算外力荷载向量
nnode=size(node,1);
nelement=size(element,1);
loadvector=zeros(nnode*2,1); %外力荷载向量
loadvector(nnode*2,1)=-1000; 

% 给定位移边界条件
nessentialdof=0; %本质约束自由度总数 
for t=1:nnode
    if node(t,1)<10^-10 
        % 约束x
        nessentialdof=nessentialdof+1;
        essentialdof(nessentialdof,1)=2*t-1;
        essentialdofdisp(nessentialdof,1)=0;
        % 约束y
        nessentialdof=nessentialdof+1;
        essentialdof(nessentialdof,1)=2*t;
        essentialdofdisp(nessentialdof,1)=0;
    end
end

% 材料参数
E=3*10^7;
v=0.0; %v=0.0时，平面应力情况和平面应变情况的D矩阵相同。