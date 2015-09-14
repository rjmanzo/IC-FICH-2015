function Particionar(archivo,cp,porc)
    %Parámetros:
        %archivo    ->  ruta con datos a particionar
        %cp         ->  cantidad de particiones
        %porc       ->  porcentaje de patrones de prueba
    
    datos=load(strcat('Datos/',archivo,'.csv'));
    archivoe=strcat(archivo,'_e');
    archivop=strcat(archivo,'_p');
    
    [n,m]=size(datos);
    cant_e=round((1-porc)*n);
    Me=zeros(cant_e,m);
    Mp=zeros(n-cant_e,m);
    for i=1:cp
        index=randperm(n);
        ie=index(1:cant_e);
        ip=index(cant_e+1:end);
        Me=datos(ie,:);
        Mp=datos(ip,:);
        csvwrite(strcat('Datos/',archivoe,num2str(i),'.csv'),Me);
        csvwrite(strcat('Datos/',archivop,num2str(i),'.csv'),Mp);
    end
end

