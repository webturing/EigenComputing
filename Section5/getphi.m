function phi=getphi(xi,eta)
% ���룺���ֵ�ֲ�����
% ������κ������䵼��phi(i,j)����i���ڵ���κ�����j=1Ϊ�κ�����j=2Ϊ�κ�����x��ƫ����j=3Ϊ�κ�����y��ƫ��
phi=zeros(4,3); 

xe=[-1 -1;1 -1;1 1;-1 1]; %�ĸ��ڵ������
for i=1:4 %�Խڵ�ѭ��
    curxi=xe(i,1); %��ǰ�ڵ��x����
    cureta=xe(i,2); %��ǰ�ڵ��y����
    phi(i,1)=0.25*(1+curxi*xi)*(1+cureta*eta);
    phi(i,2)=0.25*curxi*(1+cureta*eta);
    phi(i,3)=0.25*(1+curxi*xi)*cureta;
end