%Ejercicio 1
function [ u ] = membresia( x, vector )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
m=length(vector);
if (m==4)
    if (x<vector(1) || x>vector(4))
        u=0;
    else if (x>= vector(1) && x<vector(2))
            u=(x-vector(1))/(vector(2)-vector(1));
        else if (x>=vector(2) && x<=vector(3))
                u=1;
            else
                u=1-((x-vector(3))/(vector(4)-vector(3)));
                
            end
        end
    end
else
    u=exp(-0.5*((x-vector(1))/vector(2))^2) ;
    
end
end

