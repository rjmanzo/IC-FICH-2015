clear all
close all
clc

%Inicializo el parpool
inicializar_parpool();

path_imagen = 'Datos/cameramanRuido2.tif';
imgRuido = imread(path_imagen);
path_imagen = 'Datos/cameraman100.tif';
imgOrig = imread(path_imagen);
%Parametros de inicializacion
%Nfunc=3; %Numero de funcion a minimizar (Ver Guia 4 - ejer. 1)
c1=0.5; %Aceleracion: Comp. cognitiva 
% c2=1-c1; %Aceleracion: Comp. Global
c2=0.7; %Aceleracion: Comp. Global
maxIter=100; %Max. de iteraciones 
TolCorte=35; %toleracia psnr (db)
cantPart=6;
p_inercial = 1;%Si quiero trabajar con peso inercial = 1, sino Default en -1 
rango=255;
sigma=15;

%Obtengo la expresion del intervalo de busqueda segun la funcion seleccionar en Nfunc   
intervalo1=[0 rango];
intervalo2=[2 sigma];
%Inicializo el temporarizador
t = cputime;

particulas_global(imgRuido,imgOrig,intervalo1,intervalo2,maxIter,TolCorte,p_inercial,c1,c2,cantPart)

%Tiempos y resultados (gEP)
tiempoTotal=cputime - t;
display(strcat('Tiempo Total (gEP): ',num2str(tiempoTotal),' segundos'));

%Termino el recorrido. Cierro el parpool
finalizar_parpool();

