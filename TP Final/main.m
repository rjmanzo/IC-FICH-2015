
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
% figure, imshow(ruidosa);

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
S=[ 50 50;
    128 50;
    200 50];

% figure('Name','Conjuntos M y S','NumberTitle','off')
% subplot(2,1,1)
% graficar_conjunto(x,M);
% title('M')
% subplot(2,1,2)
% graficar_conjunto(x,S);
% title('S')

[n,m]=size(ruidosa);
for i=1:n-2
    for j=1:n-2
rect=[i j 2 2]
%ventana
I2 = imcrop(ruidosa,rect) % rect [xmin ymin width height]
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
 ss1= obtener_respuesta( r,s1 ,M,S );
% ss2= obtener_respuesta( r,s2 ,M,S );
% NS1= obtener_respuesta( r,[ss1 ss2] ,M,S );
% 
% ss3= obtener_respuesta( r,s3 ,M,S );
% ss4= obtener_respuesta( r,s4 ,M,S );
% NS2= obtener_respuesta( r,[ss3 ss4] ,M,S );
% DP2= obtener_respuesta( r,[NS1 NS2] ,M,S );
% 
% I2(2,2)=obtener_respuesta( r,[DP1 DP2] ,M,S );
 end
end
end
figure, imshow(I2);