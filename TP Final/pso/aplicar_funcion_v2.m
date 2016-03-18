function[salida]=aplicar_funcion_v2(listImgRuido,listImgOrig, pos,flagWrite,flagSalida) %pos: particulas
%UNTITLED Summary of this function goes here
%   version multicore de aplicar funcion
[~,mm]=size(pos);
for l_i=1:length(listImgRuido)
    l_i
contador=0;
%procesar la imgRuido(j)esima contra la particula(i)esima
procesar=listImgRuido{l_i}; %tomo imagen(i)esima
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
parfor ii = 1:length(xx)
    
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
% ELIMINO LOS RECORTES E INDICES QUE CORRESPONDERÍAN A LOS BORDES
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
%tic;


%====================================
% LEVANTO EL SISTEMA DIFUSO 
% cada sistema difuso representa una
% particula "pos"
%====================================
for ff=1:4:mm
contador=contador+1;
[a] = crear_sistema('FL-AMF-AUTO',pos(:,ff:ff+3),flagWrite,flagSalida)
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
%toc;


contador;% incrementa en 1 con cada particula
%el psnr aqui esta img orig contra una sola img, esto lo tengo que cambiar
%a que sea psnr promedio de listImgOrig contra todas las otras imag, y el
%desvio de ese promedio
psnr_i(l_i,contador)= psnr(imcrop(listImgOrig{l_i},[2 2 n-1 m-1]),imcrop(procesar,[2 2 n-1 m-1]));
% salida(contador)= psnr(listImgOrig,procesar);

end %PARTICULA - Fin paso todas las particulas a una imagen
end% Lista de imagenes
salida=mean(psnr_i); % promedio las psnr obtenidas por cada particula en cada imagen
end %FUNCION


