%clear all
close all
clc

path_imagen = 'Datos/cameramanRuido.tif';
imagen = imread(path_imagen);
%Parametros de inicializacion
Nfunc=3; %Numero de funcion a minimizar (Ver Guia 4 - ejer. 1)
c1=0.5; %Aceleracion: Comp. cognitiva 
c2=1-c1; %Aceleracion: Comp. Global
maxIter=1; %Max. de iteraciones 
TolCorte=25 %toleracia psnr (db)
p_inercial = 1;%Si quiero trabajar con peso inercial = 1, sino Default en -1 
rango=255;
sigma=20;

%Obtengo la expresion del intervalo de busqueda segun la funcion seleccionar en Nfunc   
intervalo1=[0 rango];
intervalo2=[2 sigma];
%Inicializo el temporarizador
t = cputime;

particulas_global(imagen,intervalo1,intervalo2,maxIter,TolCorte,p_inercial,20,c1,c2);

%Tiempos y resultados (gEP)
tiempoTotal=cputime - t;
display(strcat('Tiempo Total (gEP): ',num2str(tiempoTotal),' segundos'));

