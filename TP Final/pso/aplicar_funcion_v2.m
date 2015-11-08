function[salida]=aplicar_funcion_v2(imgRuido,imgOrig, pos) %pos: particulas
%UNTITLED Summary of this function goes here
%   version multicore de aplicar funcion

[~,mm]=size(pos);
contador=0;
%procesar la imgRuido con el sistema(i)
procesar=imgRuido;
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
[a] = crear_sistema('FL-AMF-AUTO',pos(:,ff:ff+3),0)
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


contador;
salida(contador)= psnr(imgOrig,procesar);
end %PARTICULA

end %FUNCION


