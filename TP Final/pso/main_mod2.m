clear all, close all, clc

% path_imagen = 'Datos/prueba1/fig1_mc.tif';
% %path_imagen = 'Datos/lena.jpg';
% original = imread(path_imagen);
% reescalada = imresize(original,0.2,'Method','nearest');
% imwrite(reescalada,'Datos/prueba1/fig1_0.2_hc.tif' )
% %Imagen ruidosa (S&P)
% ruidosa = imnoise(reescalada,'salt & pepper',0.01);
% % ruidosa = imnoise(original,'salt & pepper',0.01);
% % imwrite(ruidosa,'Datos/prueba1/fig1_mc_1por.tif' )
% imwrite(ruidosa,'Datos/prueba1/fig1_0.2_hc_1por.tif' )
% % path_imagen = 'Datos/cameramanRuido.tif';
% % ruidosa = imread(path_imagen);

 
%====================================
% LECTURA DE LA IMAGEN SIN RUIDO
%====================================
%path_imagen = 'Datos/cameraman.tif';
path_imagen = 'Datos/prueba1/fig1_hc.tif';
original = imread(path_imagen);


%====================================
% LECTURA DE LA IMAGEN CON RUIDO
%====================================
%Imagen ruidosa (S&P)
% ruidosa = imnoise(original,'salt & pepper',0.05);
% imwrite(ruidosa,'Datos/cameramanRuido.tif' )
%path_imagen = 'Datos/cameramanRuido256x256_1por.tif';
path_imagen = 'Datos/prueba1/fig1_hc_1por.tif';
ruidosa = imread(path_imagen);



%====================================
% APLICO FILTRO DE MEDIANA
%
% (UNA UNICA VEZ EN LA OPTIMIZACION)
%
%====================================
recuperada = medfilt2(ruidosa,[3 3]);

procesar=ruidosa;

%====================================
% EXTRAIGO DIMENSIONES DE LA IMAGEN
%====================================
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



%====================================
% COMIENZO A CONTAR EL TIEMPO
%====================================
tic


%====================================
% LEVANTO EL SISTEMA DIFUSO
%====================================
a = readfis('FL-AMF-AUTO.fis');

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


%====================================
% FINALIZO EL REGISTRO DEL TIEMPO
%====================================
toc


%Resultados--------------------------------------

figure('Name','ORIGINAL','NumberTitle','off'), imshow(imcrop(original,[2 2 n-1 m-1]));
figure('Name','RUIDO','NumberTitle','off'), imshow(imcrop(ruidosa,[2 2 n-1 m-1]));
figure('Name','MEDIANA','NumberTitle','off'), imshow(imcrop(recuperada,[2 2 n-1 m-1]));
figure('Name','FUZZY','NumberTitle','off'), imshow(imcrop(procesar,[2 2 n-1 m-1]));
%figure('Name','FUZZY BORDES','NumberTitle','off'), imshow(procesar_2);

%A mayor PSNR mejor es el resultado
psrn1 = psnr(imcrop(original,[2 2 n-1 m-1]),imcrop(recuperada,[2 2 n-1 m-1]))
psnr2=psnr(imcrop(original,[2 2 n-1 m-1]),imcrop(procesar,[2 2 n-1 m-1]))
%psrn3= psnr(original,procesar_2)
