%Ejercicio 6
clear all
close all
clc
x=-20:0.5:20;
%Mapeos
% r=[1 2 3 4 5 6 7];
%r=[7 6 5 4 3 2 1];
r=[6 4 3 5 2 7 1];

%Matriz de entrada M
%trapecios
M=[-20 -20 -10 -5;
    -10 -5 -5 -2;
    -5 -2 -2 0;
    -2 0 0 2;
    0 2 2 5;
    2 5 5 10;
    5 10 20 20];
%g
M2=[mean(M(1,:)) std(M(1,:));
    mean(M(2,:)) std(M(2,:))
    mean(M(3,:)) std(M(3,:))
    mean(M(4,:)) std(M(4,:))
    mean(M(5,:)) std(M(5,:))
    mean(M(6,:)) std(M(6,:))
    mean(M(7,:)) std(M(7,:))];


%Matriz de salida S
%trapecios
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


figure('Name','Ejercicio 6','NumberTitle','off')
salida=obtener_respuesta(r,x,M,S);
subplot(2,1,1)
plot(x,salida)
title('M trapecio - S trapecio)')

xlabel('rango')
ylabel('salida')
salida=obtener_respuesta(r,x,M2,S);
subplot(2,1,2)
plot(x,salida)
title('M gaus - S trapecio')
xlabel('rango')
ylabel('salida')

figure('Name','Ejercicio 6 - ','NumberTitle','off')
salida=obtener_respuesta(r,x,M,S2);
subplot(2,1,1)
plot(x,salida)
title('M trapecio - S gaus)')

xlabel('rango')
ylabel('salida')
salida=obtener_respuesta(r,x,M2,S2);
subplot(2,1,2)
plot(x,salida)
title('M gaus - S gaus')
xlabel('rango')
ylabel('salida')