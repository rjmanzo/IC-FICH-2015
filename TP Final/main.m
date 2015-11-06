clear all
close all
clc

% parpool('local',2)
% parpool

path_imagen = 'Datos/cameraman.tif';
%path_imagen = 'Datos/lena.jpg';
original = imread(path_imagen);
%Imagen ruidosa (S&P)
% ruidosa = imnoise(original,'salt & pepper',0.05);
% imwrite(ruidosa,'Datos/cameramanRuido.tif' )
path_imagen = 'Datos/cameramanRuido.tif';
ruidosa = imread(path_imagen);

recuperada = medfilt2(ruidosa,[3 3]);

procesar=ruidosa;
[n,m]=size(procesar);
a=readfis('FL-AMF');
tic
[xx yy]=find(procesar==255 | procesar==0); %xx=columnas yy=filas

for i=1:length(xx)
    if(xx(i)~=1 && xx(i)~=256 && yy(i)~=1 && yy(i)~=256)
        rect=[yy(i)-1 xx(i)-1 2 2];
        recorte = imcrop(procesar,rect); % rect [xmin ymin width height]
        DP1 = median(recorte(:)');
            %pixel - norte - sur
            s1=[double(recorte(1,2)) double(recorte(3,2))];
            %pixel - oeste - este
            s2=[double(recorte(2,1)) double(recorte(2,3))];
            %pixel - noroeste - sureste
            s3=[double(recorte(1,1)) double(recorte(3,3))];
            %pixel - suroeste - noreste
            s4=[double(recorte(1,3)) double(recorte(3,1))];
            %
            SS = [s1; s2; s3; s4];
            ss = zeros(4,1);
            parfor k=1:4
            ss(k)=evalfis(SS(k,:),a);
            end
%                ss1=evalfis(s1,a);
%             ss2=evalfis(s2,a);
%             ss3=evalfis(s3,a);
%             ss4=evalfis(s4,a);
            NS1=evalfis([ss(1) ss(2)],a);
            NS2=evalfis([ss(3) ss(4)],a);
            DP2=evalfis([NS1 NS2],a);
            f=evalfis([double(DP1) double(DP2)],a);
            A=uint8(f);
            procesar(xx(i),yy(i))=A;
 
    end
end
toc

% %FASE 2: Filtrado de bordes con mediana. Ventana de 3x3 descentradas.
% %El filtro de mediana no arregla el ruido de sal y pimienta en los bordes,
% %de manera tal que tenemos q hacer un algoritmo que nos permita recorrer
% %los bordes y en conjunto con sus vecinos mas proximos (i+1,j+1) calcular un promedio.
% 
% %Me creo una copia para no pisar el algo original
% procesar_2 = procesar;
% 
% %Las esquinas son un caso especial. Son matrices de 3x3 pero descentradas
% %de otra manera al recorrido general.
% 
% %Esquinas-------------------------
% %Esquina superior izquierda
% rect=[1 1 2 2];
% recorte = imcrop(procesar,rect); % rect [xmin ymin width height]
% if (recorte(1,1)==255 ||recorte(1,1)==0)
%     procesar_2(l,1)=  median(recorte(:)');
% end
% %Esquina superior derecha
% rect=[1 m-2 2 2];
% recorte = imcrop(procesar,rect); % rect [xmin ymin width height]
% if (recorte(3,1)==255 ||recorte(3,1)==0)
%     procesar_2(l,m)=  median(recorte(:)');
% end
% %Esquina inferior izquierda
% rect=[n-2 1 2 2];
% recorte = imcrop(procesar,rect); % rect [xmin ymin width height]
% if (recorte(3,1)==255 ||recorte(3,1)==0)
%     procesar_2(l,n)=  median(recorte(:)');
% end
% %Esquina inferior derecha
% rect=[n-2 m-2 2 2];
% recorte = imcrop(procesar,rect); % rect [xmin ymin width height]
% if (recorte(3,3)==255 ||recorte(3,3)==0)
%     procesar_2(n,m)=  median(recorte(:)');
% end
% 
% %Bordes-------------------------
% %Recorro la primer Columna (Fijo j=1)
% for i=1:n-1
%     rect=[1 i 2 2];
%     recorte = imcrop(procesar,rect); % rect [xmin ymin width height]
%     if (recorte(2,1)==255 ||recorte(2,1)==0) %En el rect el valor analizar es el de la i=2, j=1
%         procesar_2(i+1,1)=  median(recorte(:)');
%     end
% end
% 
% %Recorro la ultima Columna (Fijo j=m)
% for i=1:n-1
%     rect=[m-2 i 2 2]; 
%     recorte = imcrop(procesar,rect); % rect [xmin ymin width height]
%     if (recorte(2,3)==255 ||recorte(2,3)==0) %En el rect el valor analizar es el de la i=2, j=1
%         procesar_2(i+1,m)=  median(recorte(:)');
%     end
% end
% 
% %Recorro la primer fila (Fijo i=1)
% for j=1:m-1
%     rect=[j 1 2 2];
%     recorte = imcrop(procesar,rect); % rect [xmin ymin width height]
%     if (recorte(1,2)==255 ||recorte(1,2)==0) %En el rect el valor analizar es el de la i=2, j=1
%         procesar_2(1,j+1)=  median(recorte(:)');
%     end
% end
% 
% %Recorro la ultima fila (Fijo i=n)
% for j=1:m-1
%     rect=[j n-2 2 2];
%     recorte = imcrop(procesar,rect); % rect [xmin ymin width height]
%     if (recorte(3,2)==255 ||recorte(3,2)==0) %En el rect el valor analizar es el de la i=2, j=1
%         procesar_2(n,j+1)=  median(recorte(:)');
%     end
% end

%Resultados--------------------------------------

figure('Name','ORIGINAL','NumberTitle','off'), imshow(original);
figure('Name','RUIDO','NumberTitle','off'), imshow(ruidosa);
figure('Name','MEDIANA','NumberTitle','off'), imshow(recuperada)
figure('Name','FUZZY','NumberTitle','off'), imshow(procesar);
%figure('Name','FUZZY BORDES','NumberTitle','off'), imshow(procesar_2);

%A mayor PSNR mejor es el resultado
psrn1= psnr(original,recuperada)
psrn2= psnr(original,procesar)
%psrn3= psnr(original,procesar_2)

