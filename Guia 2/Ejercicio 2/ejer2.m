%clear all; close all;
% Defino el archivo a utilizar
% archivo = 'circulo';
%path_archivo=strcat('../Datos/',archivo,'.csv');
% % Llamo al SOM 2D con el circulo
% SOM(path_archivo,[10 10],0.5,3,[50 350 100],0,2);
% % Defino el archivo a utilizar
archivo = 'te';
path_archivo=strcat('../Datos/',archivo,'.csv');  
% Llamo al SOM 2D con la te
SOM(path_archivo,[10 10],0.5,3,[20 150 100],0,2);
% % Llamo al SOM 1D con la te
%SOM(path_archivo,[100 1],0.5,3,[20 150 100],0,2);