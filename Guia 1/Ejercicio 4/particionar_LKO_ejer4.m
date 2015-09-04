function cp=particionar_LKO_ejer4(archivo,salida,k)
    datos=load(archivo);  
    n=length(datos);
    cp=floor(n/k); 
    index=randperm(n);
    for i=1:cp
        pos_ini_p=(i-1)*k+1; 
        pos_fin_p=pos_ini_p+k-1;
        index_t=index(pos_ini_p:pos_fin_p); %Indice del conjunto de prueba 
        index_e=[index(1:pos_ini_p-1) index(pos_fin_p+1:end)]; 
        path_entrenamiento = strcat(salida,'_e_lko_',num2str(i),'.csv');
        path_test = strcat(salida,'_t_lko_',num2str(i),'.csv');
        csvwrite(path_entrenamiento,datos(index_e,:));
        csvwrite(path_test,datos(index_t,:));
    end
end
