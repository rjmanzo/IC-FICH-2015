clear all
close all
clc
path_imagen = 'Datos/cameraman.tif';
original = imread(path_imagen);
% figure, imshow(original);

%Imagen ruidosa (S&P)
ruidosa = imnoise(original,'salt & pepper',0.050);
%imwrite(ruidosa,'Datos/cameramanRuido.tif' )
%path_imagen = 'Datos/cameramanRuido.tif';
%ruidosa = imread(path_imagen);

figure('Name','con ruido','NumberTitle','off'), imshow(ruidosa);

%Denoise de salt and paper
recuperada = medfilt2(ruidosa,[3 3]);
figure('Name','filtro matlab','NumberTitle','off'), imshow(recuperada);

a = readfis('FL-AMF');
 evalfis([125 75],a);
 
procesar=ruidosa;
[n,m]=size(procesar);

for i=1:m-2
    for j=1:n-2
        rect=[j i 2 2];
        recorte = imcrop(procesar,rect); % rect [xmin ymin width height]
        if (recorte(2,2)==255 ||recorte(2,2)==0)
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
              ss1=evalfis(s1,a);
              ss2=evalfis(s2,a);
              ss3=evalfis(s3,a);
              ss4=evalfis(s4,a);
              NS1=evalfis([ss1 ss2],a);
              NS2=evalfis([ss3 ss4],a);
              DP2=evalfis([NS1 NS2],a);
              f=evalfis([double(DP1) double(DP2)],a);
              recorte;
              %sum=(double(recorte(1,1))+double(recorte(1,2))+double(recorte(1,3))+double(recorte(2,1))+double(recorte(2,3))+double(recorte(3,1))+double(recorte(3,2))+double(recorte(3,3)))/8;
              A = uint8(f);             
              %pause
              recorte(2,2)=A;
              
              
            for l=i:i+2
             for m=j:j+2
                 procesar(l,m)=recorte(l-i+1,m-j+1);
             end    
            end
        end
end
end

figure('Name','Salida','NumberTitle','off'), imshow(procesar);
psrn1= psnr(original,recuperada)
psrn2= psnr(original,procesar)


