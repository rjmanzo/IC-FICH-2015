function x = genotipoTofenotipo(Poblacion,Rango)
    if (length(Rango)==2)
        x= bi2de(Poblacion,'left-msb');  
        maximoValor=2^(size(Poblacion,2))-1; %
        x=(x*Rango(2)+Rango(1)*(maximoValor-x))/maximoValor; %interpolacion
        %%%%%%%%%%%%%%%%%%%%%%%%
        %|  maximoValor -> Rango(2)  |%
        %|  0        -> Rango(1)  |%
        %%%%%%%%%%%%%%%%%%%%%%%%
    elseif (length(Rango)==4)
        mitad=round(size(Poblacion,2)/2); %Se busca la mitad, la mitad de los bits corresponden a x  y el resto a y 
        x(:,1)= bi2de(Poblacion(:,1:mitad),'left-msb');
        x(:,2)= bi2de(Poblacion(:,mitad+1:end),'left-msb');
        maximoValor=2^(mitad)-1; %maximo valor en x a y
        x(:,1)=(x(:,1)*Rango(2)+Rango(1)*(maximoValor-x(:,1)))/maximoValor; 
        x(:,2)=(x(:,2)*Rango(4)+Rango(3)*(maximoValor-x(:,2)))/maximoValor;
    end
end

