function dee=getdee(E,v)
% 计算平面应变的D矩阵(4x4)
a=E/((1+v)*(1-2*v));
%dee=[(1-v) v 0 v;v (1-v) 0 v; 0 0 (1-2*v)/2 0; v v 0 1];  
dee=[(1-v) v 0 v;v (1-v) 0 v; 0 0 (1-2*v)/2 0; v v 0 1-v];  %epz=0,所以两者都对
dee=dee*a;