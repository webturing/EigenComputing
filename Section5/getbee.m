function bee=getbee(phi,ijacob)
% ����ƽ��Ӧ���B����(4x8)


bee=zeros(4,8); 
dNdx=zeros(2,1); 
for i=1:4  %��4���ڵ�ѭ��
    dNdx=ijacob*phi(i,2:3)';
    index=(i-1)*2+1; %��ǰ�ڵ�[B]������к�
    bee(1,index)=dNdx(1);
    bee(2,index+1)=dNdx(2);
    bee(3,index)=dNdx(2);
    bee(3,index+1)=dNdx(1);
end
