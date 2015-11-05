function  hijos= cruza(Poblacion,progenitores)
    hijos=Poblacion; %hijos la misma cantidad que la poblacion actual
    [cantIndividuos,cantGenes]=size(Poblacion);
    cantPadres=size(progenitores,1);
    prog1=randperm(cantPadres); %genero indice para mesclar padres-> padre1
    prog2=randperm(cantPadres); % genero indice para mesclar padres-> padre2
    while(sum(prog1==prog2)) %Se generan vectores hasta que un padre no pueda cruzasrse con sigo mismo
        prog2=randperm(cantPadres);
    end
    for i=1:cantPadres %Se recorren los progenitores para que cada uno tenga al menos un hijo
        ptoDeCruza=round(rand()*(cantGenes-1)+1); %Se calcula el punto de cruza al azar
        hijos(i,:)=[Poblacion(progenitores(prog1(i)),1:ptoDeCruza) Poblacion(progenitores(prog2(i)),ptoDeCruza+1:end)]; %El hijo es la concatenacion de dos padres
    end
    hijosFaltantes=cantIndividuos-cantPadres; %Se necesita recorrer los hijos que faltan para completar el tamaño de la poblacion
    prog1=round(rand(hijosFaltantes,1)*(cantPadres-1)+1);
    prog2=round(rand(hijosFaltantes,1)*(cantPadres-1)+1);
    while(sum(prog1==prog2)) %Se generan vectores hasta que un padre no pueda cruzasrse con sigo mismo
        prog2=round(rand(hijosFaltantes,1)*(cantPadres-1)+1);
    end
    for i=1:hijosFaltantes %Este FOR genera la cantidad de indiviuos restantes para llegar al mismo tamaño de poblacion
        ptoDeCruza=round(rand()*(cantGenes-1)+1);
        hijos(i+cantPadres,:)=[Poblacion(progenitores(prog1(i)),1:ptoDeCruza) Poblacion(progenitores(prog2(i)),ptoDeCruza+1:end)];
    end
end

