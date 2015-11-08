clear all,close all,clc
%====================================
%Inicializo el parpool
%inicializar_parpool();
%====================================


%====================================
% LECTURA DE LA IMAGEN ORIGINAL
%====================================
path_imagen = 'Datos/cameraman128x128.tif';
imgOrig = imread(path_imagen);



% LECTURA DE LA IMAGEN CON RUIDO
%====================================
path_imagen = 'Datos/cameramanRuido128x128_1por.tif';
imgRuido = imread(path_imagen);


%====================================
% APLICO FILTRO DE MEDIANA
%
% (UNA UNICA VEZ EN LA OPTIMIZACION)
%
%====================================
recuperada = medfilt2(imgRuido,[3 3]);

%====================================
% PARAMETROS DE INICIALIZACION
%====================================
c1=0.3; %Aceleracion: Comp. cognitiva 
c2=1-c1; %Aceleracion: Comp. Global
%c2=0.7; %Aceleracion: Comp. Global
maxIter=2000; %Max. de iteraciones 
TolCorte=38; %toleracia psnr (db)
cantPart=6;

%====================================
% DEFINICION DE INTERVALOS DE FUNCIONES
%====================================
intervalo1=[0 255];
intervalo2=[1 50];



%====================================
% COMIENZO A CONTAR EL TIEMPO
%====================================
t = cputime;


%====================================
% LLAMO A PSO
%====================================
[mejorGlobalVal,mejorGlobalPos,cantIter] =particulas_global(imgRuido,imgOrig,intervalo1,intervalo2,maxIter,TolCorte,c1,c2,cantPart)



%====================================
% FINALIZO EL REGISTRO DEL TIEMPO
%====================================
%Tiempos y resultados (gEP)
tiempoTotal=cputime - t;
display(strcat('Tiempo Total (gEP): ',num2str(tiempoTotal),' segundos'));

%====================================
%Termino el recorrido. Cierro el parpool
%====================================
%finalizar_parpool();



%====================================
%guardo el sistema encontrado
%====================================
a = crear_sistema('FL-AMF-AUTO',mejorGlobalPos,1);

