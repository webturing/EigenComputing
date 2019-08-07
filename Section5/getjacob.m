function jacob=getjacob(phi,xe)
% 输入：形函数、单元各个节点坐标形成的4x2矩阵
% 输出：Jacob矩阵

jacob=[phi(1,2) phi(2,2) phi(3,2) phi(4,2);phi(1,3) phi(2,3) phi(3,3) phi(4,3)]*xe;

