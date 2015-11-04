%Ejercicio 1
function [ u ] = membresia( x, vector )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
m=length(vector);
if (m==4) %Gauss2mf y %BellGauss
    %Si c1 y c2 son iguales entonces deberia hacer la funcion de bell. 
    %Igual, aca hago trampa. Como bell requiere 3 parametros (a,b y c) en
    %el ultimo parametro del vector pongo el mismo q a y pregunto por este.
    if(vector(1) == vector(4))
        u= 1/ (1 + abs((x - vector(3))/vector(1))^(2*vector(2))); %BellGauss
    else
        %Si c1 y c2 son diferentes hago Gass2mf
        if (x<vector(1))
            u=exp(-((x-vector(1))^2)/(2*(vector(2))^2));
        else if (x>=vector(1) && x<=vector(3))
                u=1;
            else if(x>vector(3))
                    u=exp(-((x-vector(3))^2)/(2*(vector(4))^2));
                end
            end
        end
    end
else
    u=exp(-((x-vector(1))^2)/(2*(vector(2))^2)); %Gaussmf (normal)
end
end

