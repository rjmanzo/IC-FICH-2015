function [ R,salida ] = defuzzification_2( activacion,M )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
[n,m]=size(M);
numerador=0;
R = zeros(n,m);
if (m==4) % caso trapezoides
    for i=1:n
        area(i)=  (abs(M(i,2)-M(i,1))/2) +  abs(M(i,3)-M(i,2))+ (abs(M(i,4)-M(i,3))/2);
        centroide(i)= abs(M(i,4) - M(i,1))/2;
        numerador=numerador+ area(i)*centroide(i)*activacion(i);
        %-----------------------
        % Agregar la creación del conjunto M escalado
        %Coordenadas de trapecio para salida V:
        R(i,1)= M(i,1)*activacion(i); %cord. a
        R(i,2)= (M(i,2)-M(i,1))*activacion(i); %cord. b
        R(i,3)= (M(i,3)-M(i,4))*activacion(i); %cord. c
        R(i,4)= M(i,4)*activacion(i); %cord. d
        %-----------------------
    end
else %caso gausseana
    for i=1:n
        area(i)=  M(i,2)*(2*pi)^0.5;
        centroide(i)= M(i,1);
        numerador=numerador+ area(i)*centroide(i)*activacion(i);
    end
end

salida= numerador/ sum(area);

end

