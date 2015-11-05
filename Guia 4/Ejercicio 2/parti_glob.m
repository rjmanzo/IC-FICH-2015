function [] = parti_glob(intervalo,maximoIteraciones,iteracion,mejorPosiLocal,mejorValorLocal,mejorPosiGlobal,mejorValorGlobal,posParticulas,velocidadDeParticula,c1,c2,cantParticulas,numeroFuncion)
while iteracion<maximoIteraciones;
    inercia=(maximoIteraciones-iteracion)/maximoIteraciones;
    r1=rand(size(posParticulas));
    r2=rand(size(posParticulas));
    velocidadDeParticula=inercia*velocidadDeParticula+c1*r1.*(mejorPosiLocal-posParticulas)+c2*r2.*(repmat(mejorPosiGlobal,1,cantParticulas)-posParticulas);
    posParticulas=posParticulas+velocidadDeParticula;
 
    posParticulas=verificar_intervalo(posParticulas,intervalo);  %particulas fuera de rango se poenen en extremos
       
    graficar_particulas(intervalo,posParticulas,aplicar_funcion(numeroFuncion,posParticulas));
    pause(0.1);
    funLocales=aplicar_funcion(numeroFuncion,posParticulas);
    menores=funLocales<mejorValorLocal; %Banderas donde indica que se dio menor valor
    mejorValorLocal(menores==1)=funLocales(menores==1); %Reemplazo por los minimos en valores y posic
    mejorPosiLocal(:,menores==1)=posParticulas(:,menores==1);
    [funGlobalVal,funGlobalPos]=min(mejorValorLocal); %minino global reemplaza
    if funGlobalVal<mejorValorGlobal
        mejorValorGlobal=funGlobalVal;
        mejorPosiGlobal=mejorPosiLocal(:,funGlobalPos);
    end
    resultado_parcial(iteracion,mejorValorGlobal,mejorPosiGlobal);%Muestro iteraciones y Mejor global obtenido
    iteracion=iteracion+1;
end
end