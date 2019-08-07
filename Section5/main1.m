clc
clear

input_cantilever

ngs=2;  %��Ԫÿ������ĸ�˹����
gs=getgs(ngs); % �����˹��λ�ú�Ȩ��

% ����Ԫ���̳�ʼ��
%ak=sparse(2*nnode,2*nnode);
ak=zeros(2*nnode,2*nnode);
force=zeros(2*nnode,1);

dee=getdee(E,v);  %D����

%% �նȾ���
for ie=1:nelement %�Ե�Ԫѭ��
    xe=node(element(ie,:),:); %��Ԫ�����ڵ������γɵ�4x2����
    
    % ��˹������Ԫ�նȾ���
    ke=zeros(8,8);
    for i=1:ngs  %��˹����
        xi=gs(1,i); %��˹��ֲ�x����
        weightx=gs(2,i); %��˹����Ȩ��
        for j=1:ngs
            eta=gs(1,j); %��˹��ֲ�y����
            weighty=gs(2,j); %��˹����Ȩ��
            phi=getphi(xi,eta);  %�ֲ���Ԫ�κ������䵼��
            jacob=getjacob(phi,xe); %[j]����
            ijacob=inv(jacob); %[j]����������
            bee=getbee(phi,ijacob);     %[B]����
            ke=ke+bee'*dee*bee*det(jacob)*weightx*weighty;
        end
    end
    
    % ��Ԫ���ɶȱ���ӳ�����ṹ�������ɶȱ���
    for i=1:4
        edof(i*2-1)=element(ie,i)*2-1;
        edof(i*2)=element(ie,i)*2;
    end
    
    % ���뷨���ɽ�����նȾ���
    for i=1:8
        for j=1:8
            ak(edof(i),edof(j))=ak(edof(i),edof(j))+ke(i,j);
        end
    end
end

%ʩ�������
force=force+loadvector; 

%����λ�Ʊ߽�����
for i=1:nessentialdof  %����֪λ�Ƶ����ɶ�ѭ��
    idof=essentialdof(i,1);
    value=essentialdofdisp(i,1);
    ak(idof,idof)=ak(idof,idof)*10^10;
    force(idof,1)=ak(idof,idof)*value;
end

%�ⷽ��
u=ak\force;

%�ڵ�λ��
for i=1:nnode
    ndisp(i,1)=u(2*i-1,1); 
    ndisp(i,2)=u(2*i,1); 
end
%���㵥Ԫ���Ĵ���λ����Ӧ��
for ie=1:nelement %�Ե�Ԫѭ��
    for i=1:4
        ue(i*2-1,1)=ndisp(element(ie,i),1);        
        ue(i*2,1)=ndisp(element(ie,i),2);
    end    
    disp=mean(ndisp(element(ie,:),:)); % ��Ԫ���Ĵ���λ��
    edisp(ie,:)=disp;
    xi=0;
    eta=0;
    phi=getphi(xi,eta);  %�ֲ���Ԫ�κ������䵼��
    jacob=getjacob(phi,xe); %[j]����
    ijacob=inv(jacob); %[j]����������
    bee=getbee(phi,ijacob);     %[B]����
    stress=dee*bee*ue;       %��ԪӦ��
    estress(ie,:)=stress';
end

