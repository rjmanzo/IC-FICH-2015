function [ salida ] = obtener_respuesta( r,x ,M,S )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
n=length(x);
salida=zeros(1,n);
for i=1:n
    a=grado_activacion(x(i),M); %activacion para ese x
    mapeo=index_map(r,a); % mapeo
    salida(i)=defuzzification( mapeo,S ); %respuesta
end

end

