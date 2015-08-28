%Funcion Particionar
%Recibe un archivo csv, la cantidad de parciones y el porcentaje de particion
% Devuelve las particiones de entrenamiento y prueba
function []= particionar(archivo,salida,particiones,p)
 v_trn=load(archivo); %%Cargo el archivo completo
 [n,m]=size(v_trn);
 for i=1:particiones
     index=randperm(n);%Permuto el indice por cada nueva particion
     
     %%% Creo la matriz de entrenamiento parcial i
     p_entrenamiento= zeros(floor(n*p),m); 
     for j=1:(floor(p*n)) %desde 1 hasta el porcetaje p (0.8)
     p_entrenamiento(j,:)=v_trn(index(j),:);
     end
     
     %Creo la matriz con la particion de prueba parcial i
     p_test= zeros(ceil(n*(1-p)),m); 
     for j=1:ceil(n*(1-p)) 
     p_test(j,:)=v_trn(index(floor(n*p)+j),:);%%Desde el ultimo valor del index hasta n del index
     end  
     
     %Defino path de salidas
     
     %salida='../Datos/particiones/spheres2d10';
     path_entrenamiento = strcat(salida,'_e_',num2str(i),'.csv');
     path_test = strcat(salida,'_t_',num2str(i),'.csv');
     %Escribo la particion i en el disco
     csvwrite(path_entrenamiento,p_entrenamiento);
     csvwrite(path_test,p_test);
 
 end

end

