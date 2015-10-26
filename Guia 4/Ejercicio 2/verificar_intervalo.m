function[particulas]=verificar_Intervalo(particulas,intervalo)
    if size(particulas,1)==2
            particulas(1,particulas(1,:)>intervalo(2,1))=intervalo(2,1);
            particulas(1,particulas(1,:)<intervalo(1,1))=intervalo(1,1);    
            particulas(2,particulas(2,:)>intervalo(2,1))=intervalo(2,2);
            particulas(2,particulas(2,:)<intervalo(1,1))=intervalo(1,2);
    else
            particulas(particulas>intervalo(2))=intervalo(2);
            particulas(particulas<intervalo(1))=intervalo(1);
    end

end