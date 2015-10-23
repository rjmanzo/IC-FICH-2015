function  hijos= cruza(P,progenitores)
    hijos=P; %Para que hijos tenga el mismo tamaño que P
    [cantIndividuos,cantGenes]=size(P);
    cantP=size(progenitores,1);
    prog1=randperm(cantP);
    prog2=randperm(cantP);
    while(sum(prog1==prog2)) %Se generan vectores hasta que un padre no pueda cruzasrse con sigo mismo
        prog2=randperm(cantP);
    end
    for i=1:cantP %Se recorren los progenitores para que cada uno tenga al menos un hijo
        ptoDeCruza=round(rand()*(cantGenes-1)+1); %Se calcula el punto de cruza al azar
        hijos(i,:)=[P(progenitores(prog1(i)),1:ptoDeCruza) P(progenitores(prog2(i)),ptoDeCruza+1:end)]; %El hijo es la concatenación de dos padres
    end
    hijosFaltantes=cantIndividuos-cantP; %Se necesita recorrer los hijos que faltan para completar el tamaño de la población
    prog1=round(rand(hijosFaltantes,1)*(cantP-1)+1);
    prog2=round(rand(hijosFaltantes,1)*(cantP-1)+1);
    while(sum(prog1==prog2)) %Se generan vectores hasta que un padre no pueda cruzasrse con sigo mismo
        prog2=round(rand(hijosFaltantes,1)*(cantP-1)+1);
    end
    for i=1:hijosFaltantes %Este FOR genera la cantidad de indiviuos restantes para llegar al mismo tamaño de población
        ptoDeCruza=round(rand()*(cantGenes-1)+1);
        hijos(i+cantP,:)=[P(progenitores(prog1(i)),1:ptoDeCruza) P(progenitores(prog2(i)),ptoDeCruza+1:end)];
    end
end

