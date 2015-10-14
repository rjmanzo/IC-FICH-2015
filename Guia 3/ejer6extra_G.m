%Ejercicio 6
clear all
close all
x=-20:0.5:20;
%Mapeos
 r=[1 2 3 4 5 6 7];

%-----------------------------------------------------
% -----------TRAPECIOS--------------------------------
%-----------------------------------------------------

%Matriz de entrada M
M=[-20 -20 -10 -5;
    -10 -5 -5 -2;
    -5 -2 -2 0;
    -2 0 0 2;
    0 2 2 5;
    2 5 5 10;
    5 10 20 20];

%Matriz de entrada Constante M2
M2=[-20 -20 20 20;
    -20 -20 20 20;
    -20 -20 20 20;
    -20 -20 20 20;
    -20 -20 20 20;
    -20 -20 20 20;
    -20 -20 20 20];

%Matriz de entrada con tres conjuntos distintos pero simetrico.
M3=[-20 -20 -10 0;
    -20 -20 -10 0;
    -20 -20 -10 0;
    -10 0 0 10;
    0 10 20 20;
    0 10 20 20;
    0 10 20 20];

%Matriz de salida S
S=[-7 -5 -5 -3 ;
   -5 -3 -3 -1;
   -3 -1 -1 0;
   -1 0 0 1;
    0 1 1 3;
    1 3 3 5;
    3 5 5 7];

%Matriz de salida unica S2
S2=[-7 -5 -5 -3 ;
   -7 -5 -5 -3;
   -7 -5 -5 -3;
   -7 -5 -5 -3;
    -7 -5 -5 -3;
    -7 -5 -5 -3;
    -7 -5 -5 -3];

%Matriz de salida unica S2
S3=[-7 -5 -5 -3 ;
   -5 -3 -3 -1;
   -1 -1 0 1;
   -1 -1 0 1;
    0 2 4 3;
    0 2 4 3;
    3 3 5 5];

% %-----------------------------------------------------
% % -----------GAUSSEANAS-------------------------------
% %-----------------------------------------------------

%Matriz de entrada G
G=[mean(M(1,:)) std(M(1,:));
    mean(M(2,:)) std(M(2,:))
    mean(M(3,:)) std(M(3,:))
    mean(M(4,:)) std(M(4,:))
    mean(M(5,:)) std(M(5,:))
    mean(M(6,:)) std(M(6,:))
    mean(M(7,:)) std(M(7,:))];

%Matriz de entrada Constante G2
G2=[mean(M2(1,:)) std(M2(1,:));
    mean(M2(2,:)) std(M2(2,:))
    mean(M2(3,:)) std(M2(3,:))
    mean(M2(4,:)) std(M2(4,:))
    mean(M2(5,:)) std(M2(5,:))
    mean(M2(6,:)) std(M2(6,:))
    mean(M2(7,:)) std(M2(7,:))];

%Matriz de entrada con tres conjuntos distintos pero simetrico (G3)
%Matriz de entrada Constante G2
G3=[mean(M3(1,:)) std(M3(1,:));
    mean(M3(2,:)) std(M3(2,:))
    mean(M3(3,:)) std(M3(3,:))
    mean(M3(4,:)) std(M3(4,:))
    mean(M3(5,:)) std(M3(5,:))
    mean(M3(6,:)) std(M3(6,:))
    mean(M3(7,:)) std(M3(7,:))]; 

%Matriz de entrada G
GS=[mean(S(1,:)) std(S(1,:));
    mean(S(2,:)) std(S(2,:))
    mean(S(3,:)) std(S(3,:))
    mean(S(4,:)) std(S(4,:))
    mean(S(5,:)) std(S(5,:))
    mean(S(6,:)) std(S(6,:))
    mean(S(7,:)) std(S(7,:))];

%Matriz de entrada G
GS2=[mean(S2(1,:)) std(S2(1,:));
    mean(S2(2,:)) std(S2(2,:))
    mean(S2(3,:)) std(S2(3,:))
    mean(S2(4,:)) std(S2(4,:))
    mean(S2(5,:)) std(S2(5,:))
    mean(S2(6,:)) std(S2(6,:))
    mean(S2(7,:)) std(S2(7,:))];

%Matriz de entrada G
GS3=[mean(S3(1,:)) std(S3(1,:));
    mean(S3(2,:)) std(S3(2,:))
    mean(S3(3,:)) std(S3(3,:))
    mean(S3(4,:)) std(S3(4,:))
    mean(S3(5,:)) std(S3(5,:))
    mean(S3(6,:)) std(S3(6,:))
    mean(S3(7,:)) std(S3(7,:))];

%Figuras gauseanas
figure('Name','Gauseanas: entradas M1, M2 y M3','NumberTitle','off')
subplot(3,1,1)
graficar_conjunto(x,G);
title('G1')
subplot(3,1,2)
graficar_conjunto(x,G2);
title('G2')
subplot(3,1,3)
graficar_conjunto(x,G3);
title('G3')

%salidas gauseanas
figure('Name','Gauseanas: salidas S1, S2 y S3','NumberTitle','off')
subplot(3,1,1)
graficar_conjunto(x,GS);
title('S1')
subplot(3,1,2)
graficar_conjunto(x,GS2);
title('S2')
subplot(3,1,3)
graficar_conjunto(x,GS3);
title('S3')

% RESPUESTA VS.
figure('Name','Gauseanas: M VS. S - Salidas','NumberTitle','off')
salida=obtener_respuesta(r,x,G,GS);
subplot(3,3,1)
plot(x,salida)
title('G1 vs S1')
salida=obtener_respuesta(r,x,G,GS2);
subplot(3,3,2)
plot(x,salida)
title('G1 vs S2')
salida=obtener_respuesta(r,x,G,GS3);
subplot(3,3,3)
plot(x,salida)
title('G1 vs S3')

salida=obtener_respuesta(r,x,G2,GS);
subplot(3,3,4)
plot(x,salida)
title('G2 vs S1')
salida=obtener_respuesta(r,x,G2,GS2);
subplot(3,3,5)
plot(x,salida)
title('G2 vs S2')
salida=obtener_respuesta(r,x,G2,GS3);
subplot(3,3,6)
plot(x,salida)
title('G2 vs S3')

salida=obtener_respuesta(r,x,G3,GS);
subplot(3,3,7)
plot(x,salida)
title('G3 vs S1')
salida=obtener_respuesta(r,x,G3,GS2);
subplot(3,3,8)
plot(x,salida)
title('G3 vs S2')
salida=obtener_respuesta(r,x,G3,GS3);
subplot(3,3,9)
plot(x,salida)
title('G3 vs S3')

