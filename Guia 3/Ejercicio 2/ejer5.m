clear all;
close all;
<<<<<<< HEAD
=======
%Inicializacion de parametros
x=10;
r=[1 2 3 4 5 6 7];%Vector de correlacion. Mapea A--> B
%r=[7 6 5 4 3 2 1];

>>>>>>> 1fd1f1dcc15042718a6af2f852531d2f8af19059
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
<<<<<<< HEAD

x=10
r=[1;2;3;4;5;6;7];%Vector de correlacion. Mapea A--> B
%r=[7;6;5;4;3;2;1];


%Calculo las activaciones para la matriz A
a = grado_activacion(x,M);

%Reordeno en funcion del indice
mapeo=index_map(r,a);

%Obtengo la salida del sistema mapeado y la escala de sus conjuntos
[R,salida] = defuzzification_2(a,S);

=======

%Calculo las activaciones para la matriz A
a = grado_activacion(x,M);

%Reordeno en funcion del indice
mapeo=index_map(r,a);

%Obtengo la salida del sistema mapeado y la escala de sus conjuntos
[R,salida] = defuzzification_2(mapeo,S);

>>>>>>> 1fd1f1dcc15042718a6af2f852531d2f8af19059
%Grafico los conjuntos y la respuesta del sistema
figure(1);
graficar_conjunto(x,'Conjunto de entrada (M)',M);
figure(2);
graficar_conjunto(x,'Conjunto de salida (S)',S);
figure(3);
<<<<<<< HEAD
graficar_conjunto(x,'Respuesta del sistema',R);
=======
graficar_conjunto(salida,'Respuesta del sistema',R);
>>>>>>> 1fd1f1dcc15042718a6af2f852531d2f8af19059
