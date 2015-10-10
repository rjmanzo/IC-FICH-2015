%ejercicio 7
clear al
close all
r=[1 2 3 4 5 6 7];
g=40/41;
a=g;
t_ref=15;
temp_salida(1)=15;
ti=15; %cte

M1=[-20 -20 -10 -5;
    -10 -5 -5 -2;
    -5 -2 -2 0;
    -2 0 0 2;
    0 2 2 5;
    2 5 5 10;
    5 10 20 20];
M2=[-20 -20 -10 -5;
    -10 -5 -4 -2;
    -4 -2 -1 0;
    -1 0 0 1;
    0 1 2 4;
    2 4 5 10;
    5 10 20 20];
S1=[-7 -5 -5 -3;
    -5 -3 -3 -1;
    -3 -1 -1 0;
    -1 0 0 1;
    0 1 1 3;
    1 3 3 5;
    3 5 5 7];
S2=[-7 -5 -5 -4;
    -5 -4 -4 -3;
    -4 -3 -3 0;
    -3 0 0 3;
    0 3 3 4;
    3 4 4 5;
    4 5 5 7];   

  mapeo=index_map(r,M2); % mapeo
for i=1:200 
    if i>30
    t_ref=25;
    end
    error(i)=t_ref-temp_salida(i);
    act=grado_activacion(error(i),mapeo); %activacion para ese x
    q(i)=defuzzification(act,S2); %respuesta 
    temp_salida(i+1)= ti+g*q(i)+a*(temp_salida(i)-ti)
end
figure(1)
plot(error)
title('error');
figure(2)
plot (temp_salida)
title('temperatura');
