clear all,close all,clc

%Inicializo el parpool
inicializar_parpool();

path_imagen = 'Datos/cameraman128x128.tif';
imgOrig = imread(path_imagen);
path_imagen = 'Datos/cameramanRuido128x128_1por.tif';
imgRuido = imread(path_imagen);

%Parametros de inicializacion
c1=0.3; %Aceleracion: Comp. cognitiva 
c2=1-c1; %Aceleracion: Comp. Global
%c2=0.7; %Aceleracion: Comp. Global
maxIter=100; %Max. de iteraciones 
TolCorte=35; %toleracia psnr (db)
cantPart=6;
rango=255;
sigma=15;

%Obtengo la expresion del intervalo de busqueda segun la funcion seleccionar en Nfunc   
intervalo1=[0 rango];
intervalo2=[2 sigma];
%Inicializo el temporarizador
t = cputime;

[mejorGlobalVal,mejorGlobalPos,cantIter] =particulas_global(imgRuido,imgOrig,intervalo1,intervalo2,maxIter,TolCorte,c1,c2,cantPart)

%Tiempos y resultados (gEP)
tiempoTotal=cputime - t;
display(strcat('Tiempo Total (gEP): ',num2str(tiempoTotal),' segundos'));

%Termino el recorrido. Cierro el parpool
finalizar_parpool();

%guardo el sistema encontrado
a = crear_sistema('FL-AMF-AUTO',mejorGlobalPos,1);

