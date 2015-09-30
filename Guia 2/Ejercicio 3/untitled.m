% Defino el archivo a utilizar
archivo = 'clouds';
path_archivo=strcat('../Datos/',archivo,'.csv');
path_salida=strcat('../Datos/','cloudsm');
v_trn=load(path_archivo); %%Cargo el archivo completo
[n,m]=size(v_trn);
v_aux=zeros(n,m);
for i=1:n
    if (v_trn(i,m)==0)
        v_aux(i,1)=v_trn(i,1);
        v_aux(i,2)=v_trn(i,2);
        v_aux(i,3)=-1;
    else
        v_aux(i,:)=v_trn(i,:);
    end
end
 csvwrite(path_salida,v_aux);