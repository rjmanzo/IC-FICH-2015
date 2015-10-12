clear all
close all
clc
a = [0  0.7  0.3 0 0 0 0];

%trapecio
S=[-7 -5 -5 -3 ;
-5 -3 -3 -1;
-3 -1 -1 0;
-1 0 0 1;
0 1 1 3;
1 3 3 5;
3 5 5 7];

%g
S2=[mean(S(1,:)) std(S(1,:));
    mean(S(2,:)) std(S(2,:))
    mean(S(3,:)) std(S(3,:))
    mean(S(4,:)) std(S(4,:))
    mean(S(5,:)) std(S(5,:))
    mean(S(6,:)) std(S(6,:))
    mean(S(7,:)) std(S(7,:))];

%trapecios
salida1= defuzzification(a,S)
%g
salida2= defuzzification(a,S2)