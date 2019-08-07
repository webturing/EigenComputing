function phi=getphi(xi,eta)
% 输入：积分点局部坐标
% 输出：形函数及其导数phi(i,j)，第i个节点的形函数，j=1为形函数，j=2为形函数对x的偏导，j=3为形函数对y的偏导
phi=zeros(4,3); 

xe=[-1 -1;1 -1;1 1;-1 1]; %四个节点的坐标
for i=1:4 %对节点循环
    curxi=xe(i,1); %当前节点的x坐标
    cureta=xe(i,2); %当前节点的y坐标
    phi(i,1)=0.25*(1+curxi*xi)*(1+cureta*eta);
    phi(i,2)=0.25*curxi*(1+cureta*eta);
    phi(i,3)=0.25*(1+curxi*xi)*cureta;
end