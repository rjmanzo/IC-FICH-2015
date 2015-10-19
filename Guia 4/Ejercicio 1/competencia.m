function progenitores=competencia(fitness,k,porcentagePadres)
    %progenitores - > vector con la posicion de los padres obtenidos en la seleccion natural 
    N=size(fitness,1); %numero de individuos
    cantidadPadres=round((porcentagePadres*N)/100); 
    progenitores=zeros(cantidadPadres,1);
    j=1;
    while (j<=cantidadPadres)
        grupo=round(rand(k,1)*(N-1))+1; %tomo k
        [~,mejor]=max(fitness(grupo)); %maximo fitness
        if(progenitores(progenitores==grupo(mejor)))%Si lo encuentra no lo agrega
            %No se hace nada
        else 
            progenitores(j)=grupo(mejor); %ganador
            j=j+1;
        end
    end
    %Atencion: El rand en grupo puede tomar un valor repetido, lo que genera comparar un padre con sigo mismo 
    
end

