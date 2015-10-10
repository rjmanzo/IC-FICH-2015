function [ salida ] = defuzzification( activacion,S )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
[n,m]=size(S);
if (m==4) % caso trapezoides
    for i=1:n
        
        %Cord. del trapecio
        a=S(i,1);
        b=S(i,2);
        c=S(i,3);
        d=S(i,4);
        
        %Obtengo los Ci para el calculo de Area y centroide
        c2 = ((c-b)/2) + b;
        c1 = a + (2/3)*(b-a);
        c3 = c + (1/3)*(d-c);
        
        %Calculo las Areas i (partes del trapecio)
        area2=(c-b)*activacion(i);
        area1=((b-a)*activacion(i)) /2;
        area3=((d-c)*activacion(i)) /2;
        
        %Calculo el area y el centroide
        area(i) = area1 + area2 + area3;
        if(area(i) == 0) 
            centroide(i) = 0; %Si el trapecio no aporta a la salida (grado de membrecia)
        else
            centroide(i) = (area1*c1 + area2*c2 + area3*c3)  / area(i);
        end
    end
else %caso gausseana
    for i=1:n
        area(i)=  M(i,2)*(2*pi)^0.5;
        centroide(i)= M(i,1)*activacion(i);
        %area(i)*centroide(i)*activacion(i);
    end
end

%Salida del sistema
salida= (sum(centroide.*area))/sum(area);

end

