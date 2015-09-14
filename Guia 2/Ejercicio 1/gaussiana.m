function gaussianas=gaussiana(archivo,medias,varianza,cant_salidas)    
    [K,col]=size(medias);
    patrones=csvread( archivo );
    [n,~]=size(patrones);
    gaussianas=zeros(n,K+cant_salidas);
    gaussianas(:,end-cant_salidas+1:end)=patrones(:,end-cant_salidas+1:end);
    for i=1:n
        X=patrones(i,1:end-cant_salidas);
        for j=1:K
            gaussianas(i,j)=exp(-1/2*dot((X-medias(j,:)),(X-medias(j,:))));
%            dist=X-medias(j,:);
%             gaussianas(i,j)=exp(-1/2*dist*inv(varianza)*dist');
        end
    end

end
