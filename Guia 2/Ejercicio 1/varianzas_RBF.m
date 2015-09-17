function[M]=varianzas_RBF(patrones, medias)
%patrones tiene en la primer columna el indice de la media a la que pertenece
[K,col]=size(medias);
%varianza=zeros(K,col);
for j=1:K
    k_j=patrones(patrones(:,1)==j,2:end);
    [n,m]=size(k_j);
    distancia=zeros(n,m);
    for i=1:n
        distancia(i,:)=(k_j(i,:)-medias(j,:)).^2;
    end
    if(isempty(k_j)==0)
        varianza_j(j,:)=sum(distancia)./length(distancia);
    end
end
%promedio la varianza de todos los conjuntos
prom_var=sum(varianza_j)./length(varianza_j);
M=zeros(col,col);
for k=1:col
    M(k,k)=prom_var(k);
end
end