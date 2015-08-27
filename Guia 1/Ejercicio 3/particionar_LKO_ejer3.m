function cp=particionar_LKO_eje3(archivo,k)
    %Par�metros:
        %archivo    ->  ruta con datos a particionar
        %k          ->  cantidad de patrones para la prueba
    datos=load(archivo);
    archivoe=strcat(archivo(1:end-4),'_eLKO'); %Preparaci�n de nombre de archivo
    archivop=strcat(archivo(1:end-4),'_pLKO'); %Preparaci�n de nombre de archivo
    
    n=length(datos);
    cp=floor(n/k); %Cantidad de particones
    index=randperm(n); %Vector de indice con valores al azar
    for i=1:cp
        pos_ini_p=(i-1)*k+1; %Posici�n inicial del conjunto de prueba para la i-�sima partici�n
        pos_fin_p=pos_ini_p+k-1; %Posici�n final del conjunto de prueba para la i-�sima partici�n
        ip=index(pos_ini_p:pos_fin_p); %Indice del conjunto de prueba 
        ie=[index(1:pos_ini_p-1) index(pos_fin_p+1:end)]; %Indice para el conjunto de entrenamiento (contiene los valores ausentes en el indice de prueba)
        Me=datos(ie,:); %Matriz de entrenamiento
        Mp=datos(ip,:); %Matriz de prueba
        csvwrite(strcat(archivoe,num2str(i),'.csv'),Me);
        csvwrite(strcat(archivop,num2str(i),'.csv'),Mp);
    end
end
