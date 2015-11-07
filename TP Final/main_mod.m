clear all, close all, clc


% NWORKERS = 3;
% 
% if matlabpool('size') == 0 
%     ClusterSettings = parcluster('local');
%     ClusterSettings.NumWorkers = NWORKERS;
%     eval(sprintf('matlabpool open local %d',NWORKERS));
% end

%====================================
% LECTURA DE LA IMAGEN SIN RUIDO
%====================================
path_imagen = 'Datos/cameraman100.tif';
%path_imagen = 'Datos/lena.jpg';
original = imread(path_imagen);


%====================================
% LECTURA DE LA IMAGEN CON RUIDO
%====================================
%Imagen ruidosa (S&P)
% ruidosa = imnoise(original,'salt & pepper',0.05);
% imwrite(ruidosa,'Datos/cameramanRuido.tif' )
path_imagen = 'Datos/cameramanRuido2.tif';
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
% IDENTIFICACION DE PIXELES "RUIDOSOS" (valor 0 Ã³ 255)
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

for ii = 1:length(xx)
    
    %===================================================
    % EXTRAIGO LOS PIXELES RUIDOSOS EVITANDO LOS BORDES
    %===================================================
    if (xx(ii) ~= 1) && (xx(ii) ~= n) && (yy(ii) ~= 1) && (yy(ii) ~= m)
        
        RECORTES(:,:,ii) = imcrop(procesar, [yy(ii)-1 xx(ii)-1 2 2]); % rect [xmin ymin width height]
        
        idxs(ii,1) = IDXS(ii);
        
    end
end

%=================================================================
% ELIMINO LOS RECORTES E INDICES QUE CORRESPONDERÃ?AN A LOS BORDES
%=================================================================
RECORTES(:,:,idxs==0) = [];
idxs(idxs==0) = [];



%====================================
% COMIENZO A CONTAR EL TIEMPO
%====================================
tic


%====================================
% LEVANTO EL SISTEMA DIFUSO
%====================================
a = readfis('FL-AMF');




V = zeros(length(idxs),1); % VECTOR DONDE ALMACENARE LOS PIXELES CORREGIDOS

parfor ii = 1:numel(idxs)
    
        recorte = RECORTES(:,:,ii);
        
        DP1 = median(double(recorte(:)));
        
        %pixel - norte - sur
        s1 = [double(recorte(1,2)) double(recorte(3,2))];
        
        %pixel - oeste - este
        s2 = [double(recorte(2,1)) double(recorte(2,3))];
        
        %pixel - noroeste - sureste
        s3 = [double(recorte(1,1)) double(recorte(3,3))];
        
        %pixel - suroeste - noreste
        s4 = [double(recorte(1,3)) double(recorte(3,1))];
        
        %--------------------------------------
        
        %--------------------------------------
        ss1 = evalfis(s1,a);
        ss2 = evalfis(s2,a);
        ss3 = evalfis(s3,a);
        ss4 = evalfis(s4,a);         
        
        NS1 = evalfis([ss1, ss2],a);
        NS2 = evalfis([ss3, ss4],a);
        
        DP2 = evalfis([NS1 NS2],a);
        
        %--------------------------------------
        
        %--------------------------------------
        
        V(ii) = uint8( evalfis([double(DP1) double(DP2)],a) );
        
end

procesar(idxs) = V;


%====================================
% FINALIZO EL REGISTRO DEL TIEMPO
%====================================
toc


%Resultados--------------------------------------

figure('Name','ORIGINAL','NumberTitle','off'), imshow(original);
figure('Name','RUIDO','NumberTitle','off'), imshow(ruidosa);
figure('Name','MEDIANA','NumberTitle','off'), imshow(recuperada)
figure('Name','FUZZY','NumberTitle','off'), imshow(procesar);
%figure('Name','FUZZY BORDES','NumberTitle','off'), imshow(procesar_2);

%A mayor PSNR mejor es el resultado
psrn1 = psnr(original,recuperada)
psrn2 = psnr(original,procesar)
%psrn3= psnr(original,procesar_2)



% %======================================
% % FINALIZO LA EJECUCION DE LOS WORKERS
% %======================================
% if matlabpool('size') > 1
%     matlabpool close
% end