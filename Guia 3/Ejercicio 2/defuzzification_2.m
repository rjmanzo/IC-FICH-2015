function salida=defuzzification_2( mapeo,S )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
[n,m]=size(S);
numerador=0;
R = zeros(n,m);
if (m==4) % caso trapezoides
    for i=1:n
        a=S(i,1);
        b=S(i,2);
        c=S(i,3);
        d=S(i,4);
        area(i)=  (abs(b-a)/2) +  abs(c-b)+ (abs(d-c)/2);
        centroide(i)= abs(S(i,4) - S(i,1))/2;
        numerador=numerador+ area(i)*centroide(i)*mapeo(i);
      
    end
else %caso gausseana
    for i=1:n
        area(i)=  S(i,2)*(2*pi)^0.5;
        centroide(i)= S(i,1);
        numerador=numerador+ area(i)*centroide(i)*mapeo(i);
    end
end

salida= numerador/ sum(area);

end

