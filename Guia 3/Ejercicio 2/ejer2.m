M=[-20 -20 -10 -5;
    -10 -5 -5 -2;
    -5 -2 -2 0;
    -2 0 0 2;
    0 2 2 5;
    2 5 5 10;
    5 10 20 20];

% M2=[mean(M(1,:)) std(M(1,:));
%     mean(M(2,:)) std(M(2,:))
%     mean(M(3,:)) std(M(3,:))
%     mean(M(4,:)) std(M(4,:))
%     mean(M(5,:)) std(M(5,:))
%     mean(M(6,:)) std(M(6,:))
%     mean(M(7,:)) std(M(7,:))];
% 
%  [I,V] = Control_Difuso( -10,M)

% M=[-4 -3 -1 2]
% M2=[1 1]
x=15;
% [ u ] = membresia( x, M )
graficar_conjunto(x,M);
activacion=grado_activacion(x,M);
[ salida ] = defuzzification( activacion,M )