
%Ejercicio 6
x=-20:1:20;
r=[1 2 3 4 5 6 7];
%Matriz de entrada M
M=[-20 -20 -10 -5;
    -10 -5 -5 -2;
    -5 -2 -2 0;
    -2 0 0 2;
    0 2 2 5;
    2 5 5 10;
    5 10 20 20];

%Matriz de salida S
S=[-7 -5 -5 -3 ;
   -5 -3 -3 -1;
   -3 -1 -1 0;
   -1 0 0 1;
    0 1 1 3;
    1 3 3 5;
    3 5 5 7];

salida=obtener_respuesta(r,x,M,S );
plot(salida)