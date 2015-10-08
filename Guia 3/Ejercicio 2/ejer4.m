% % clear all
% % close all
a = [0  0.7  0.3 0 0 0 0];

S=[-7 -5 -5 -3 ;
-5 -3 -3 -1;
-3 -1 -1 0;
-1 0 0 1;
0 1 1 3;
1 3 3 5;
3 5 5 7];

salida= defuzzification(a,S)

%s=-20:0.5:20