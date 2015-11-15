% test.m
% Creado para correr test sobre los 10 sistemas difusos obtenidos en corridas distintas del 
% main_PSO con imagenes de 1% de ruido, de manera de poder obtener con ellos valores promedios y desvios, los sistemas 
%fueren creados  en las siguientes carpetas
% 1.blonde_fis
% 1.cameraman_fis
% 1.mandril_fis
% 1.lena_fis
% 3.fig1_lc_fis
% 3.fig1_mc_fis
% 3.fig1_hc_fis
%
%COLOCAR en "nombre_img" el NOMBRE DE LA IMAGEN DE LA QUE SE QUIERE CORRER EL
%TEST

clear all, close all , clc 

nombre_img='mandril';
carpeta_img=strcat('Datos/2.',nombre_img,'_fis/');
path_imagen = strcat(carpeta_img,nombre_img,'.tif');
original = imread(path_imagen);
path_imagen = strcat(carpeta_img,nombre_img,'_1por.tif');
ruidosa = imread(path_imagen);
carpeta_sistema=carpeta_img;

recuperada = medfilt2(ruidosa,[3 3]);
procesar=ruidosa;
[n,m]=size(procesar);


%========================================================
% IDENTIFICACION DE PIXELES "RUIDOSOS" (valor 0 ó 255)
%
% (UNA UNICA VEZ EN LA OPTIMIZACION)
%
%========================================================
[xx, yy] = find(procesar==255 | procesar==0); %xx=columnas yy=filas

IDXS = find(procesar==255 | procesar==0);


%=======================================
% EXTRAIGO RECORTES EN UNA HIPER-MATRIZ
%
% (UNA UNICA VEZ EN LA OPTIMIZACION)
%
%=======================================
RECORTES = zeros(3,3,length(xx));
idxs = zeros(length(xx),1);
DP1 = zeros(length(xx),1);
for ii = 1:length(xx)
    
    %===================================================
    % EXTRAIGO LOS PIXELES RUIDOSOS EVITANDO LOS BORDES
    %===================================================
    if (xx(ii) ~= 1) && (xx(ii) ~= n) && (yy(ii) ~= 1) && (yy(ii) ~= m)
        
        % EXTRAIGO RECORTE
        recorte = imcrop(procesar, [yy(ii)-1 xx(ii)-1 2 2]); % rect [xmin ymin width height]
        
        % ALMACENO RECORTE
        RECORTES(:,:,ii) = recorte;
        
        % PRECALCULO MEDIANA DEL RECORTE
        DP1(ii,1) = median(double(recorte(:)));
        
        % ALMACENO INDICE
        idxs(ii,1) = IDXS(ii);
        
    end
end

%=================================================================
% ELIMINO LOS RECORTES E INDICES QUE CORRESPONDER�?AN A LOS BORDES
%=================================================================
RECORTES(:,:,idxs==0) = [];
DP1(idxs==0) = [];
idxs(idxs==0) = [];



%========================================================
% EXTRAIGO LOS DISTINTOS PARES DE PUNTOS DE LOS RECORTES
%========================================================
s1 = [squeeze(RECORTES(1,2,:)) squeeze(RECORTES(3,2,:))];
s2 = [squeeze(RECORTES(2,1,:)) squeeze(RECORTES(2,3,:))];
s3 = [squeeze(RECORTES(3,3,:)) squeeze(RECORTES(1,1,:))];
s4 = [squeeze(RECORTES(3,1,:)) squeeze(RECORTES(1,3,:))];



cantSistemas=10;
for ii=1:cantSistemas
%====================================
% LEVANTO EL SISTEMA DIFUSO
%====================================

path_sistema=strcat(carpeta_sistema,'FL-',nombre_img,'-',num2str(ii)),'.fis';

%Levanto el sistema difuso de otra imagen
% path_sistema=strcat('Datos/3.fig1_hc_fis/','FL-','fig1_hc','-',num2str(ii)),'.fis';
a = readfis(path_sistema);

%========================================
% EVALUO LOS PARES DE PUNTOS ALMACENADOS
%========================================
ss1 = evalfis(s1,a);
ss2 = evalfis(s2,a);
ss3 = evalfis(s3,a);
ss4 = evalfis(s4,a);         

%=============================
% EVALUO LOS PUNTOS OBTENIDOS
%=============================
NS1 = evalfis([ss1, ss2],a);
NS2 = evalfis([ss3, ss4],a);


%===========================================
% CALCULO EL PIXEL DIFUSO PARA CADA RECORTE
%===========================================
DP2 = evalfis([NS1 NS2],a);


%==============================
% CORRIJO LOS PIXELES RUIDOSOS
%==============================
procesar(idxs) = uint8( evalfis([double(DP1) double(DP2)],a) );


%A mayor PSNR y SSIM
%Desestimo los bordes en el calculo psnr por que el algoritmo no recorre
%los bordes
xx=2;
yy=m-1;
psnrRuidosa(ii)= psnr(imcrop(original,[xx xx yy yy]),imcrop(ruidosa,[xx xx yy yy]));
psnrMediana(ii)= psnr(imcrop(original,[xx xx yy yy]),imcrop(recuperada,[xx xx yy yy]));
psnrMetodoPropuesto(ii)=psnr(imcrop(original,[xx xx yy yy]),imcrop(procesar,[xx xx yy yy]));
gananciaMetodoPropuesto(ii)=psnrMetodoPropuesto(ii)-psnrRuidosa(ii);
ssimMediana(ii)=ssim(imcrop(original,[xx xx yy yy]),imcrop(recuperada,[xx xx yy yy]));
ssimMetodoPropuesto(ii)=ssim(imcrop(original,[xx xx yy yy]),imcrop(procesar,[xx xx yy yy]));
end
%Datos estadisticos
% psnrMediana
% psnrMetodoPropuesto
psnrPromedioRuidosa = mean(psnrRuidosa)
psnrPromedioMediana =mean(psnrMediana)
psnrPromedioMetodoPropuesto= mean(psnrMetodoPropuesto)
% psnrDesvioMEtodoPropuesto=std(psnrMetodoPropuesto)
% gananciaMetodoPropuesto
% gananciaPromedioMetodoPropuesto= mean(gananciaMetodoPropuesto)
% ssimMediana
% ssimMetodoPropuesto
% ssimPromedioMediana= mean(ssimMediana)
% ssimPromedioMetodoPropuesto= mean(ssimMetodoPropuesto)
% ssimDesvioMEtodoPropuesto=std(ssimMetodoPropuesto)



%save(strcat(carpeta_img,'info'),'psnrMetodoPropuesto','psnrPromedioMetodoPropuesto','-ascii');
%save('info', psnrMetodoPropuesto,'-ascii');