clear all;
close all;
%Inicializacion de parametros
x=5;
% r=[1 2 3 4 5 6 7];%Vector de correlacion. Mapea A--> B
r=[7 6 5 4 3 2 1];%Vector de correlacion. Mapea A--> B

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

%Reordeno en funcion del indice
Mapeo=index_map(r,M);

%Calculo las activaciones para la matriz de entrada A
a = grado_activacion(x,Mapeo);

%Obtengo la salida del sistema mapeado y la escala de sus conjuntos
salida=defuzzification(a,S)

%Grafico los conjuntos y la respuesta del sistema
% figure(1);
% s=-20:0.5:20;
% graficar_conjunto(s,S);