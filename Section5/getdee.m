function dee=getdee(E,v)
% ����ƽ��Ӧ���D����(4x4)
a=E/((1+v)*(1-2*v));
%dee=[(1-v) v 0 v;v (1-v) 0 v; 0 0 (1-2*v)/2 0; v v 0 1];  
dee=[(1-v) v 0 v;v (1-v) 0 v; 0 0 (1-2*v)/2 0; v v 0 1-v];  %epz=0,�������߶���
dee=dee*a;