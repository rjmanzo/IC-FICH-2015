clear all,close all,clc
%i=0;
%for i=1:10    
    %====================================
    %Inicializo el parpool
    %inicializar_parpool();
    %====================================
    
    
    %====================================
    % LECTURA DE LA IMAGEN ORIGINAL
    %====================================
    path_imagen = 'Datos/2.blonde_distintos_%_ruido/blonde.tif';
    imgOrig = imread(path_imagen);
    
    
    % LECTURA DE LA IMAGEN CON RUIDO
    %====================================
    path_imagen = 'Datos/2.blonde_distintos_%_ruido/blonde_20por.tif';
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
    c1=2; %Aceleracion: Comp. cognitiva
    c2=3.5; %Aceleracion: Comp. Global
    maxIter=200; %Max. de iteraciones
    TolCorte=50; %toleracia psnr (db)
    cantPart=30;
    cantGausseanas=3;
    flagWrite=0;
    flagSalida=0;
    %flagWrite=0 no escribe el sistema en el disco
    %flagWrite=1    escribe el sistema en el disco
    
    %flagSalida = 0 cantGausseanas=3;. modifica solo conjuntos de entrada (son 3 conj. entradas -> cantGaussenasa= 3)
    %flagSalida = 2 . tomando como entrada un sistema desde disco
    %flagSalida = 1 cantGausseanas=5;. modifica solo conjuntos de salida (son 5 conj. salidas-> cantGausseanas=5)
    %flagSalida = 3 cantGausseanas=8;. modifica entrada(conj iguales) y salida(son 8 conj. -> cantGausseanas=8)
    %flagSalida = 4 cantGausseanas=11;. modifica entrada(conj distintos) y salida(son 11 conj. -> cantGausseanas=11)
    
    
    %====================================
    % DEFINICION DE INTERVALOS DE FUNCIONES
    %====================================
    intervalo1=[0 257];
    intervalo2=[2 17];
    
    
    
    %====================================
    % COMIENZO A CONTAR EL TIEMPO
    %====================================
    % t = cputime;
    
    
    %====================================
    % LLAMO A PSO
    %====================================
    [mejorGlobalVal,mejorGlobalPos,cantIter] =particulas_global(imgRuido,imgOrig,intervalo1,intervalo2,maxIter,TolCorte,c1,c2,cantPart,cantGausseanas,flagWrite,flagSalida)
    
    
    %====================================
    % FINALIZO EL REGISTRO DEL TIEMPO
    %====================================
    %Tiempos y resultados (gEP)
    % tiempoTotal=cputime - t;
    % display(strcat('Tiempo Total (gEP): ',num2str(tiempoTotal),' segundos'));
    
    %====================================
    %Termino el recorrido. Cierro el parpool
    %====================================
    %finalizar_parpool()
    %====================================
    %guardo el sistema encontrado
    %====================================
    
    a = crear_sistema('Datos/2.blonde_distintos_%_ruido/blonde_20por.fis',mejorGlobalPos,1,flagSalida);
    %a = crear_sistema(strcat('Datos/blonde_fis/FL-blonde-',num2str(i)),mejorGlobalPos,1,flagSalida);
    
%end
% [n,m]=size(imgOrig);
% mejorGlobalVal
%psnr(imcrop(imgOrig,[2 2 n-1 m-1]),imcrop(recuperada,[2 2 n-1 m-1]))
% cantIter-1

