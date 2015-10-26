% BUSQUEDA COMPLETA
clear all; close all; clc;

% Pregunto en que archivo estan los datos
archivo = input('Ingrese el nombre del archivo :','s');

% En base al archivo selecciono el nodo inicial
if strcmp( archivo , '7cities' )
    raiz = 7;
else
    raiz = 5;
end

% Arranco el reloj
tic;
% Leo los datos
datos = csvread( strcat( '../Datos/' , archivo , '.csv' ) );

nodos_nr = [1:size(datos,1)];
[costo,camino] = busquedaCompleta( raiz , nodos_nr , datos , raiz );

% Termino el reloj
toc;