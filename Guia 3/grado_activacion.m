%Ejercicio 3
function [ activacion ] = grado_activacion(x,M )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
[n,m]=size(M); 
for i=1:n
    activacion(i)=membresia(x,M(i,:));
end
end

