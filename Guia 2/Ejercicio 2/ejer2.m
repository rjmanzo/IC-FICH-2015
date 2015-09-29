clear all; close all;
% Defino el archivo a utilizar
% archivo = 'circulo';
archivo = 'te';
path_archivo=strcat('../Datos/',archivo,'.csv');

% SOM 2D con el circulo
% SOM(path_archivo,[10 10],0.5,3,[20 150 100],0,2);

%SOM 2D con la te
% SOM(path_archivo,[10 10],0.5,3,[20 150 100],0,2);

%SOM 1D con la te
%[W]=SOM(archivo,matris_som,gamma,vecindad,epocas_etapas,cant_salidas,ini)

SOM(path_archivo,[100 1],0.5,3,[20 150 100],0,2);