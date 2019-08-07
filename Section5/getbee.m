function bee=getbee(phi,ijacob)
% 计算平面应变的B矩阵(4x8)


bee=zeros(4,8); 
dNdx=zeros(2,1); 
for i=1:4  %对4个节点循环
    dNdx=ijacob*phi(i,2:3)';
    index=(i-1)*2+1; %当前节点[B]矩阵的列号
    bee(1,index)=dNdx(1);
    bee(2,index+1)=dNdx(2);
    bee(3,index)=dNdx(2);
    bee(3,index+1)=dNdx(1);
end
