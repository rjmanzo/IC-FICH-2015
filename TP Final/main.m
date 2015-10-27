
% clear all
% close all
% clc

%Cargo la imagen original
path_imagen = 'Datos/cameraman.tif';
% original = gpuArray(imread(path_imagen)); SI QUERES TRABAJAR CON LA GPU
original = imread(path_imagen);
% figure, imshow(original);

%Imagen ruidosa (S&P)
ruidosa = imnoise(original,'salt & pepper',0.05);
figure, imshow(ruidosa);

%Denoise de salt and paper
recuperada = medfilt2(ruidosa,[3 3]);
% figure, imshow(recuperada);

%borroso
x=0:1:254; %rango grises 8 bits
r=[1 2 3]; %map
%Entrada
M=[0 0 75 100;
    50 100 150 200;
    150 200 255 255];
%salida
%S=[ 50 50;
%    128 50;
%    200 50];
S=[0 50 50 100;
    50 128 128 200;
    150 200 200 255];

figure('Name','Conjuntos M y S','NumberTitle','off')
subplot(2,1,1)
graficar_conjunto(x,M);
title('M')
subplot(2,1,2)
graficar_conjunto(x,S);
title('S')

[n,m]=size(ruidosa);
for i=1:n-2
    for j=1:m-2
        rect=[i j 2 2];
        I2 = imcrop(ruidosa,rect); % rect [xmin ymin width height]
        if (I2(2,2)==255 ||I2(2,2)==0)
            DP1 = median(I2(:)');
            %pixel - norte - sur
            s1=[I2(1,2) I2(3,2)];
            %pixel - oeste - este
            s2=[I2(2,1) I2(2,3)];
            %pixel - noroeste - sureste
            s3=[I2(1,1) I2(3,3)];
            %pixel - suroeste - noreste
            s4=[I2(1,3) I2(3,1)];
            %
            
            mapeo=index_map(r,M); % mapeo
            a1=grado_activacion(double(s1(1)),mapeo); %activacion para ese x
            a2=grado_activacion(double(s1(2)),mapeo); %activacion para ese x
            a=max(a1,a2); %union de membresias
            ss1=defuzzification(a,S); %respuesta
            
            a1=grado_activacion(double(s2(1)),mapeo); %activacion para ese x
            a2=grado_activacion(double(s2(2)),mapeo); %activacion para ese x
            a=max(a1,a2); %union de membresias
            ss2=defuzzification(a,S); %respuesta
            
            
            a1=grado_activacion(double(s3(1)),mapeo); %activacion para ese x
            a2=grado_activacion(double(s3(2)),mapeo); %activacion para ese x
            a=max(a1,a2); %union de membresias
            ss3=defuzzification(a,S); %respuesta
            
            a1=grado_activacion(double(s4(1)),mapeo); %activacion para ese x
            a2=grado_activacion(double(s4(2)),mapeo); %activacion para ese x
            a=max(a1,a2); %union de membresias
            ss4=defuzzification(a,S); %respuesta
            
            a1=grado_activacion(double(ss1),mapeo); %activacion para ese x
            a2=grado_activacion(double(ss2),mapeo); %activacion para ese x
            a=max(a1,a2); %union de membresias
            NS1=defuzzification(a,S); %respuesta
            
            a1=grado_activacion(double(ss3),mapeo); %activacion para ese x
            a2=grado_activacion(double(ss4),mapeo); %activacion para ese x
            a=max(a1,a2); %union de membresias
            NS2=defuzzification(a,S); %respuesta
            
            
            a1=grado_activacion(double(NS1),mapeo); %activacion para ese x
            a2=grado_activacion(double(NS2),mapeo); %activacion para ese x
            a=max(a1,a2); %union de membresias
            DP2=defuzzification(a,S); %respuesta
            
            a1=grado_activacion(double(DP1),mapeo); %activacion para ese x
            a2=grado_activacion(double(DP2),mapeo); %activacion para ese x
            a=max(a1,a2); %union de membresias
            f=defuzzification(a,S); %respuesta
            A = uint8(f);
            I2(2,2)=A;
            for l=i:i+2
             for m=j:j+2
                 ruidosa(l,m)=I2(l-i+1,m-j+1);
             end
            end
        end
    end
end

figure('Name','Salida','NumberTitle','off'), imshow(ruidosa);