function [ salida ] = obtener_respuesta( r,x ,M,S )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
n=length(x);
salida=zeros(1,n);

%Calculo el mapeo de M --> S
mapeo=index_map(r,M); % mapeo
for i=1:n
    a=grado_activacion(x(i),mapeo); %activacion para ese x
    salida(i)=defuzzification(a,S); %respuesta
end

end

