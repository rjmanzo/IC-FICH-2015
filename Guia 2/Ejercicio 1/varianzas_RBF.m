function[M]=varianzas_RBF(datos, medias)
%datos tiene en la primer columna el indice de la media a la que pertenece
[K,col]=size(medias);
%varianza=zeros(K,col);
for i=1:K
    k_i=datos(datos(:,1)==i,2:end);
    [n,m]=size(k_i);
    distancia=zeros(n,m);
    for j=1:n
        distancia(j,:)=(k_i(j,:)-medias(i,:)).^2;
    end
    if(isempty(k_i)==0)
        varianza_i(i,:)=sum(distancia)./length(distancia);
    end
end
%promedio la varianza de todos los conjuntos
prom_var=sum(varianza_i)./length(varianza_i);
M=zeros(col,col);
for k=1:col
    M(k,k)=prom_var(k);
end
end