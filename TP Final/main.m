
clear all
close all
clc

%Cargo la imagen original
path_imagen = 'Datos/cameraman.tif';
% original = gpuArray(imread(path_imagen)); SI QUERES TRABAJAR CON LA GPU
original = imread(path_imagen);
figure, imshow(original);

%Imagen ruidosa (S&P)
ruidosa = imnoise(original,'salt & pepper',0.05);
figure, imshow(ruidosa);

%Denoise de salt and paper
recuperada = medfilt2(ruidosa,[3 3]);
figure, imshow(recuperada);

%borroso
x=0:1:254; %rango grises 8 bits
r=[1 2 3]
%Entrada
M=[0 0 75 100;
   50 100 150 200;
   150 200 255 255];
S=[ 50 50;
    128 50;
    200 50];

figure('Name','Conjuntos M y S','NumberTitle','off')
subplot(2,1,1)
graficar_conjunto(x,M);
title('M')
subplot(2,1,2)
graficar_conjunto(x,S);
title('S')



I2 = imcrop(I,rect)