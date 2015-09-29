function gaussianas=gaussiana(archivo,medias,M_sigma,cant_salidas, bandera)    
    [K,col]=size(medias);
    patrones=csvread( archivo );
    [n,~]=size(patrones);
    gaussianas=zeros(n,K+cant_salidas);
    gaussianas(:,end-cant_salidas+1:end)=patrones(:,end-cant_salidas+1:end);
    for i=1:n
        X=patrones(i,1:end-cant_salidas);
        for j=1:K
            if (bandera==0)
            gaussianas(i,j)=exp(-1/2*dot((X-medias(j,:)),(X-medias(j,:))));
            else
            dist=X-medias(j,:);
            gaussianas(i,j)=exp(-1/2*dist*inv(M_sigma)*dist');
            end
%Agregar bandera de uso en M_sigma
        end
    end

end

