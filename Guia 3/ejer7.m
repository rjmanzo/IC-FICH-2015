%ejercicio 7
clear al
close all
x=-20:0.5:20;
r=[1 2 3 4 5 6 7];
r2=[1 2 3 4 5 6 7 8 9 10 11];
g=40/41;
a=g;
t_ref=15;
temp_salida(1)=15;
ti=15; %cte
cambio=30; % cantidad de pasos hasta cambiar la temperatura de referencia
valor=25; % valor de la temperatura de referencia asignado en el cambio

M1=[-20 -20 -10 -5;
    -10 -5 -5 -2;
    -5 -2 -2 0;
    -2 0 0 2;
    0 2 2 5;
    2 5 5 10;
    5 10 20 20];

M2=[-20 -20 -10 -5;
    -10 -5 -4 -2;
    -4 -2 -1 -0;
    -1 0 0 1;
    0 1 2 4;
    2 4 5 10;
    5 10 20 20];

M3=[-20 -20 -15 -14;
    -17 -13 -13 -7;
    -8 -5 -5 -2;
    -10 -8 -8 -5;
    -5 -1 -1 0;
    -1 0 0 1;
    0 1 1 5;
    2 5 5 8;
    5 8 8 10;
    7 13 13 17;
    14 15 20 20];

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

S3=[-7 -5 -5 -3;
    -6 -4 -4 -2;
    -5 -3 -3 -1;
    -4 -2 -2 0;
    -3 -1 -1 0;
    -1 0 0 1;
    0 1 1 3;
    0 2 2 4;
    1 3 3 5;
    2 4 4 6;
    3 5 5 7];

%-------------------------------------------------------------
%Figuras: Entradas y salidas
%-------------------------------------------------------------

%Entradas
figure('Name','Trapecios: entradas M1, M2 y M3','NumberTitle','off')
subplot(3,1,1)
graficar_conjunto(x,M1);
title('M1')
subplot(3,1,2)
graficar_conjunto(x,M2);
title('M2')
subplot(3,1,3)
graficar_conjunto(x,M2);
title('M3')

%salidas
figure('Name','Trapecios: salidas S1 y S2','NumberTitle','off')
subplot(3,1,1)
graficar_conjunto(x,S1);
title('S1')
subplot(3,1,2)
graficar_conjunto(x,S2);
title('S2')
subplot(3,1,3)
graficar_conjunto(x,S3);
title('S3')

%-------------------------------------------------------------
%M1 vs S1
%-------------------------------------------------------------
mapeo=index_map(r,M1); % mapeo
for i=1:200
    if i>cambio
        t_ref=valor;
    end
    error(i)=t_ref-temp_salida(i);
    act=grado_activacion(error(i),mapeo); %activacion para ese x
    q(i)=defuzzification(act,S1); %respuesta
    temp_salida(i+1)= ti+g*q(i)+a*(temp_salida(i)-ti);
end

figure('Name','M1 - S1','NumberTitle','off')
subplot(3,1,1)
plot(error,'red')
xlim([0,200])
grid on
title('error');
xlabel('tiempo(s)')
ylabel('t_ref-temp_salida  (°C)')
subplot(3,1,2)
plot(q,'red')
xlim([0,200])
grid on
title('q(i)');
xlabel('tiempo(s)')
ylabel('Salida q')
%figure('Name','Adaptacion a nueva temperatura de referencia','NumberTitle','off')
subplot(3,1,3)
plot (temp_salida,'red')
xlim([0,200])
grid on
title('temperatura');
xlabel('tiempo(s)')
ylabel('temperatura °C')

%-------------------------------------------------------------
%M1 vs S2
%-------------------------------------------------------------
t_ref=15;
temp_salida=0
temp_salida(1)=15;
mapeo=index_map(r,M1); % mapeo
for i=1:200
    if i>cambio
        t_ref=valor;
    end
    error(i)=t_ref-temp_salida(i);
    act=grado_activacion(error(i),mapeo); %activacion para ese x
    q(i)=defuzzification(act,S2); %respuesta
    temp_salida(i+1)= ti+g*q(i)+a*(temp_salida(i)-ti);
end
figure('Name','M1 - S2','NumberTitle','off')
subplot(3,1,1)
plot(error,'red')
xlim([0,200])
grid on
title('error');
xlabel('tiempo(s)')
ylabel('t_ref-temp_salida  (°C)')
subplot(3,1,2)
plot(q,'red')
xlim([0,200])
grid on
title('q(i)');
xlabel('tiempo(s)')
ylabel('Salida q')
subplot(3,1,3)
plot (temp_salida,'red')
xlim([0,200])
grid on
title('temperatura');
xlabel('tiempo(s)')
ylabel('temperatura °C')

%-------------------------------------------------------------
%M2 vs S1
%-------------------------------------------------------------
t_ref=15;
temp_salida=0
temp_salida(1)=15;
mapeo=index_map(r,M2); % mapeo
for i=1:200
    if i>cambio
        t_ref=valor;
    end
    error(i)=t_ref-temp_salida(i);
    act=grado_activacion(error(i),mapeo); %activacion para ese x
    q(i)=defuzzification(act,S1); %respuesta
    temp_salida(i+1)= ti+g*q(i)+a*(temp_salida(i)-ti);
end
figure('Name','M2 - S1','NumberTitle','off')
subplot(3,1,1)
plot(error,'red')
xlim([0,200])
grid on
title('error');
xlabel('tiempo(s)')
ylabel('t_ref-temp_salida  (°C)')
subplot(3,1,2)
plot(q,'red')
xlim([0,200])
grid on
title('q(i)');
xlabel('tiempo(s)')
ylabel('Salida q')
subplot(3,1,3)
plot (temp_salida,'red')
xlim([0,200])
grid on
title('temperatura');
xlabel('tiempo(s)')
ylabel('temperatura °C')

%-------------------------------------------------------------
%M2 vs S2
%-------------------------------------------------------------
t_ref=15;
temp_salida=0
temp_salida(1)=15;
mapeo=index_map(r,M2); % mapeo
for i=1:200
    if i>cambio
        t_ref=valor;
    end
    error(i)=t_ref-temp_salida(i);
    act=grado_activacion(error(i),mapeo); %activacion para ese x
    q(i)=defuzzification(act,S2); %respuesta
    temp_salida(i+1)= ti+g*q(i)+a*(temp_salida(i)-ti);
end
figure('Name','M2 - S2','NumberTitle','off')
subplot(3,1,1)
plot(error,'red')
xlim([0,200])
grid on
title('error');
xlabel('tiempo(s)')
ylabel('t_ref-temp_salida  (°C)')
subplot(3,1,2)
plot(q,'red')
xlim([0,200])
grid on
title('q(i)');
xlabel('tiempo(s)')
ylabel('Salida q')
subplot(3,1,3)
plot (temp_salida,'red')
xlim([0,200])
grid on
title('temperatura');
xlabel('tiempo(s)')
ylabel('temperatura °C')

%-------------------------------------------------------------
%M3 vs S3
%-------------------------------------------------------------
mapeo=index_map(r2,M3); % mapeo
for i=1:200
    if i>cambio
        t_ref=valor;
    end
    error(i)=t_ref-temp_salida(i);
    act=grado_activacion(error(i),mapeo); %activacion para ese x
    q(i)=defuzzification(act,S3); %respuesta
    temp_salida(i+1)= ti+g*q(i)+a*(temp_salida(i)-ti);
end

figure('Name','M1 - S1','NumberTitle','off')
subplot(3,1,1)
plot(error,'red')
xlim([0,200])
grid on
title('error');
xlabel('tiempo(s)')
ylabel('t_ref-temp_salida  (°C)')
subplot(3,1,2)
plot(q,'red')
xlim([0,200])
grid on
title('q(i)');
xlabel('tiempo(s)')
ylabel('Salida q')
%figure('Name','Adaptacion a nueva temperatura de referencia','NumberTitle','off')
subplot(3,1,3)
plot (temp_salida,'red')
xlim([0,200])
grid on
title('temperatura');
xlabel('tiempo(s)')
ylabel('temperatura °C')

% conclusiones:
% las dos primeras cobinaciones no tiene osilaciones al aproximar la temperatura de referencia
% pero no logran llegar a esa temperatura, tiene error
% de las dos ultimas las dos son llegan a t_ref, pero la ultima opcion M2 - S2 lo hace con mas
% osilacion, la tercela opcion lo hace mas suavemente
