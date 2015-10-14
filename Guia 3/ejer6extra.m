%Ejercicio 6 extra. TRAPECIOS
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

%Figuras trapecios
figure('Name','Trapecios: entradas M1, M2 y M3','NumberTitle','off')
subplot(3,1,1)
graficar_conjunto(x,M);
title('M1')
subplot(3,1,2)
graficar_conjunto(x,M2);
title('M2')
subplot(3,1,3)
graficar_conjunto(x,M3);
title('M3')

%salidas trapecios
figure('Name','Trapecios: salidas S1, S2 y S3','NumberTitle','off')
subplot(3,1,1)
graficar_conjunto(x,S);
title('S1')
subplot(3,1,2)
graficar_conjunto(x,S2);
title('S2')
subplot(3,1,3)
graficar_conjunto(x,S3);
title('S3')

% RESPUESTA VS.
figure('Name','Trapecios: M VS. S - Salidas','NumberTitle','off')
salida=obtener_respuesta(r,x,M,S);
subplot(3,3,1)
plot(x,salida)
title('M1 vs S1')
salida=obtener_respuesta(r,x,M,S2);
subplot(3,3,2)
plot(x,salida)
title('M1 vs S2')
salida=obtener_respuesta(r,x,M,S3);
subplot(3,3,3)
plot(x,salida)
title('M1 vs S3')

salida=obtener_respuesta(r,x,M2,S);
subplot(3,3,4)
plot(x,salida)
title('M2 vs S1')
salida=obtener_respuesta(r,x,M2,S2);
subplot(3,3,5)
plot(x,salida)
title('M2 vs S2')
salida=obtener_respuesta(r,x,M2,S3);
subplot(3,3,6)
plot(x,salida)
title('M2 vs S3')

salida=obtener_respuesta(r,x,M3,S);
subplot(3,3,7)
plot(x,salida)
title('M3 vs S1')
salida=obtener_respuesta(r,x,M3,S2);
subplot(3,3,8)
plot(x,salida)
title('M3 vs S2')
salida=obtener_respuesta(r,x,M3,S3);
subplot(3,3,9)
plot(x,salida)
title('M3 vs S3')

% 
% %-----------------------------------------------------
% % -----------GAUSSEANAS-------------------------------
% %-----------------------------------------------------
% 
% %Matriz de entrada G
% G=[mean(M(1,:)) std(M(1,:));
%     mean(M(2,:)) std(M(2,:))
%     mean(M(3,:)) std(M(3,:))
%     mean(M(4,:)) std(M(4,:))
%     mean(M(5,:)) std(M(5,:))
%     mean(M(6,:)) std(M(6,:))
%     mean(M(7,:)) std(M(7,:))];
% 
% %Matriz de entrada Constante G2
% G2=[mean(M2(1,:)) std(M2(1,:));
%     mean(M2(2,:)) std(M2(2,:))
%     mean(M2(3,:)) std(M2(3,:))
%     mean(M2(4,:)) std(M2(4,:))
%     mean(M2(5,:)) std(M2(5,:))
%     mean(M2(6,:)) std(M2(6,:))
%     mean(M2(7,:)) std(M2(7,:))];
% 
% %Matriz de entrada con tres conjuntos distintos pero simetrico (G3)
% %Matriz de entrada Constante G2
% G3=[mean(M3(1,:)) std(M3(1,:));
%     mean(M3(2,:)) std(M3(2,:))
%     mean(M3(3,:)) std(M3(3,:))
%     mean(M3(4,:)) std(M3(4,:))
%     mean(M3(5,:)) std(M3(5,:))
%     mean(M3(6,:)) std(M3(6,:))
%     mean(M3(7,:)) std(M3(7,:))];
% 
% %Matriz de salida S
% S=[-7 -5 -5 -3 ;
%    -5 -3 -3 -1;
%    -3 -1 -1 0;
%    -1 0 0 1;
%     0 1 1 3;
%     1 3 3 5;
%     3 5 5 7];
% 
% %Matriz de salida unica S2
% S2=[-7 -5 -5 -3 ;
%    -7 -5 -5 -3;
%    -7 -5 -5 -3;
%    -7 -5 -5 -3;
%     -7 -5 -5 -3;
%     -7 -5 -5 -3;
%     -7 -5 -5 -3];
% 
% %Figuras trapecios
% figure('Name','Gausseanas G1, G2 y G3','NumberTitle','off')
% subplot(3,1,1)
% graficar_conjunto(x,G);
% title('G')
% subplot(3,1,2)
% graficar_conjunto(x,G2);
% title('G2')
% subplot(3,1,3)
% graficar_conjunto(x,G3);
% title('G3')
% 
% % 
% % %trapecio
% % figure('Name','Trapecio - Conjuntos M y S','NumberTitle','off')
% % subplot(2,1,1)
% % graficar_conjunto(x,M);
% % title('M')
% % subplot(2,1,2)
% % graficar_conjunto(x,S);
% % title('S')
% % 
% % figure('Name','Ejercicio 6 extra. M2 y S - Entrada Lineal/Simetrica','NumberTitle','off')
% % salida=obtener_respuesta(r,x,M2,S);
% % subplot(2,1,1)
% % plot(x,salida)
% % title('M trapecio - S trapecio (M-S)')
% % 
% % xlabel('rango')
% % ylabel('salida')
% % salida=obtener_respuesta(r,x,M2,S);
% % subplot(2,1,2)
% % plot(x,salida)
% % title('M gaus - S trapecio (M2-S)')
% % xlabel('rango')
% % ylabel('salida')
% % 
% % figure('Name','Ejercicio 6 - ','NumberTitle','off')
% % salida=obtener_respuesta(r,x,M,S2);
% % subplot(2,1,1)
% % plot(x,salida)
% % title('M trapecio - S gaus (M-S2)')
% % 
% % xlabel('rango')
% % ylabel('salida')
% % salida=obtener_respuesta(r,x,M2,S2);
% % subplot(2,1,2)
% % plot(x,salida)
% % title('M gaus - S gaus (M2-S2)')
% % xlabel('rango')
% % ylabel('salida')