clc
clear

input_cantilever

ngs=2;  %单元每个方向的高斯点数
gs=getgs(ngs); % 计算高斯点位置和权重

% 有限元方程初始化
%ak=sparse(2*nnode,2*nnode);
ak=zeros(2*nnode,2*nnode);
force=zeros(2*nnode,1);

dee=getdee(E,v);  %D矩阵

%% 刚度矩阵
for ie=1:nelement %对单元循环
    xe=node(element(ie,:),:); %单元各个节点坐标形成的4x2矩阵
    
    % 高斯积分求单元刚度矩阵
    ke=zeros(8,8);
    for i=1:ngs  %高斯积分
        xi=gs(1,i); %高斯点局部x坐标
        weightx=gs(2,i); %高斯积分权重
        for j=1:ngs
            eta=gs(1,j); %高斯点局部y坐标
            weighty=gs(2,j); %高斯积分权重
            phi=getphi(xi,eta);  %局部单元形函数及其导数
            jacob=getjacob(phi,xe); %[j]矩阵
            ijacob=inv(jacob); %[j]矩阵的逆矩阵
            bee=getbee(phi,ijacob);     %[B]矩阵
            ke=ke+bee'*dee*bee*det(jacob)*weightx*weighty;
        end
    end
    
    % 单元自由度编码映射至结构整体自由度编码
    for i=1:4
        edof(i*2-1)=element(ie,i)*2-1;
        edof(i*2)=element(ie,i)*2;
    end
    
    % 编码法集成进整体刚度矩阵
    for i=1:8
        for j=1:8
            ak(edof(i),edof(j))=ak(edof(i),edof(j))+ke(i,j);
        end
    end
end

%施加外荷载
force=force+loadvector; 

%引入位移边界条件
for i=1:nessentialdof  %对已知位移的自由度循环
    idof=essentialdof(i,1);
    value=essentialdofdisp(i,1);
    ak(idof,idof)=ak(idof,idof)*10^10;
    force(idof,1)=ak(idof,idof)*value;
end

%解方程
u=ak\force;

%节点位移
for i=1:nnode
    ndisp(i,1)=u(2*i-1,1); 
    ndisp(i,2)=u(2*i,1); 
end
%计算单元形心处的位移与应力
for ie=1:nelement %对单元循环
    for i=1:4
        ue(i*2-1,1)=ndisp(element(ie,i),1);        
        ue(i*2,1)=ndisp(element(ie,i),2);
    end    
    disp=mean(ndisp(element(ie,:),:)); % 单元形心处的位移
    edisp(ie,:)=disp;
    xi=0;
    eta=0;
    phi=getphi(xi,eta);  %局部单元形函数及其导数
    jacob=getjacob(phi,xe); %[j]矩阵
    ijacob=inv(jacob); %[j]矩阵的逆矩阵
    bee=getbee(phi,ijacob);     %[B]矩阵
    stress=dee*bee*ue;       %单元应力
    estress(ie,:)=stress';
end

