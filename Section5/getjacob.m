function jacob=getjacob(phi,xe)
% ���룺�κ�������Ԫ�����ڵ������γɵ�4x2����
% �����Jacob����

jacob=[phi(1,2) phi(2,2) phi(3,2) phi(4,2);phi(1,3) phi(2,3) phi(3,3) phi(4,3)]*xe;

