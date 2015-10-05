clear all
close all
a = [0  0.7  0.3 0 0 0 0];

S=[-7 -5 -5 -3 ;
-5 -3 -3 -1;
-3 -1 -1 0;
-1 0 0 1;
0 1 1 3;
1 3 3 5;
3 5 5 7];

% [ u ] = membresia( x, M )
x=-2.4
graficar_conjunto(x,S);
activacion=grado_activacion(x,S)
[ salida ] = defuzzification( a,S )