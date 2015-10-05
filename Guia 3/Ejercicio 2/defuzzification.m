function [ salida ] = defuzzification( activacion,M )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
[n,m]=size(M);
numerador=0;
if (m==4) % caso trapezoides
    for i=1:n
        area(i)=  (abs(M(i,2)-M(i,1))/2) +  abs(M(i,3)-M(i,2))+ (abs(M(i,4)-M(i,3))/2);
        centroide(i)= abs(M(i,4) - M(i,1))/2;
        numerador=numerador+ area(i)*centroide(i)*activacion(i);
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

