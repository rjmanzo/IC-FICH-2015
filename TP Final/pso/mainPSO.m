% % 
% % /////////////////////////////////////////////
% % //      ___  ___       ___   _   __   _    //
% % //     /   |/   |     /   | | | |  \ | |   //
% % //    / /|   /| |    / /| | | | |   \| |   //
% % //   / / |__/ | |   / / | | | | | |\   |   //
% % //  / /       | |  / /  | | | | | | \  |   //
% % // /_/        |_| /_/   |_| |_| |_|  \_|   //
% % //                                         //
% % /////////////////////////////////////////////

% mainPSO.m es el script principal de la optimizacion de conjunto borrosos mediante Enjambre de particulas(PSO)
% En los parametros se debe setear el path la imagen original (imgOrig) la imagen ruidosa ( imgRuido) con cierto porcentage
% de ruido, y por ultimo el path de salida de donde se escribira el sistema borroso optimizado en disco

% Descripcion de Paramentros
%flagWrite=0 no escribe el sistema en el disco
%flagWrite=1    escribe el sistema en el disco

%flagSalida = 0 cantGausseanas=3;. modifica solo conjuntos de entrada (son 3 conj. entradas -> cantGaussenasa= 3)
%flagSalida = 2 . tomando como entrada un sistema desde disco
%flagSalida = 1 cantGausseanas=5;. modifica solo conjuntos de salida (son 5 conj. salidas-> cantGausseanas=5)
%flagSalida = 3 cantGausseanas=8;. modifica entrada(conj iguales) y salida(son 8 conj. -> cantGausseanas=8)
%flagSalida = 4 cantGausseanas=11;. modifica entrada(conj distintos) y salida(son 11 conj. -> cantGausseanas=11
%     intervalo1=[inferioro superior]; rango de valores en la que se puede despplazar la gaussianas, esta relacionada con el rango de grises posible en la imagen
%     intervalo2=[inferior superior];  rango de valores que puede tomar la varianza
%     c1= %Aceleracion: Comp. cognitiva- entre [2 y 5]
%     c2= %Aceleracion: Comp. Global entre [2 y 5]
%     maxIter %Maximo  de iteraciones
%     TolCorte %toleracia psnr (db)
%     cantPart cantidad de particulas del enjambre
%     cantGausseanas cantidad de gausseanas (cada gausseana representa una funcion de memebresia) a optimizar


clear all,close all,clc
 
    %====================================
    %Inicializo el parpool
    
    %====================================
    
    %inicializar_parpool();
   
    for i=1:4
    %====================================
    % LECTURA DE LA IMAGEN ORIGINAL
    %====================================
    path_imagen = strcat('Datos/4.paper_jaiio/128/img_',num2str(i),'_128x128.tif');
    listImgOrig{i}= imread(path_imagen);
    
    
    % LECTURA DE LA IMAGEN CON RUIDO
    %====================================    
    path_imagen =strcat('Datos/4.paper_jaiio/128/gray_noise_40/img_',num2str(i),'_128x128_40por.tif');
    listImgRuido{i} = imread(path_imagen);
    end
    
    %====================================
    % APLICO FILTRO DE MEDIANA
    %
    % (UNA UNICA VEZ EN LA OPTIMIZACION)
    %
    %====================================
%     recuperada = medfilt2(imgRuido,[3 3]);
    
    %====================================
    % PARAMETROS DE INICIALIZACION
    %====================================
    c1=2; %Aceleracion: Comp. cognitiva
    c2=3.2; %Aceleracion: Comp. Global
    maxIter=200; %Max. de iteraciones
    TolCorte=50; %toleracia psnr (db)
    cantPart=30;
    cantGausseanas=3;
    flagWrite=0;
    flagSalida=0;
 
    
    
    %====================================
    % DEFINICION DE INTERVALOS DE FUNCIONES
    %====================================
    intervalo1=[0 257];
    intervalo2=[2 17];
    
    
    %====================================
    % LLAMO A PSO
    %====================================
    tic
    [mejorGlobalVal,mejorGlobalPos,cantIter] =particulas_global(listImgRuido,listImgOrig,intervalo1,intervalo2,maxIter,TolCorte,c1,c2,cantPart,cantGausseanas,flagWrite,flagSalida)
    toc
   tiempo=tic-toc
    %====================================
    %Termino el recorrido. Cierro el parpool
    %====================================
    %finalizar_parpool();
    %====================================
    %guardo el sistema encontrado
    %====================================

    a = crear_sistema('Datos/4.paper_jaiio/sistema/sistema_40particulas_noise_40%.fis',mejorGlobalPos,1,flagSalida);

    %a = crear_sistema(strcat('Datos/blonde_fis/FL-blonde-',num2str(i)),mejorGlobalPos,1,flagSalida);


