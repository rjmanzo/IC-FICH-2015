function[salida]=aplicar_funcion_multicore(imgRuido,imgOrig, pos) %pos: particulas
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
% ELIMINO LOS RECORTES E INDICES QUE CORRESPONDERÍAN A LOS BORDES
%=================================================================
RECORTES(:,:,idxs==0) = [];
idxs(idxs==0) = [];



%====================================
% COMIENZO A CONTAR EL TIEMPO
%====================================
tic

%====================================
% LEVANTO EL SISTEMA DIFUSO CORRESPONDIENTE A CADA PARTICULA
%====================================
for ff=1:4:mm
contador=contador+1;
[a] = crear_sistema('FL-AMF-AUTO',pos(:,ff:ff+3),0)




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
        
end %SISTEMA DIFUSO

procesar(idxs) = V;


%====================================
% FINALIZO EL REGISTRO DEL TIEMPO
%====================================
toc
contador
salida(contador)= psnr(imgOrig,procesar)
end %PARTICULA

end %FUNCION















