%Particulas: Enjambre del mejor global
function [] = particulas_global(imagen,intervalo1,intervalo2,Nfunc,maxIter,TolCorte,p_inercial,c1,c2)
cantIter=1;
cantPart=20;

%Inicializar: genero las particulas al azar en funcion del intervalo
posParticulas=inicializar_particulas(intervalo1,intervalo2,cantPart); %Inicializar posiciones al azar

%Inicializar: obtengo las posiciones de las particulas y calculo el mejor global
mejorLocPos=posParticulas;                      %mejor posicion es la mejor posicion que tomo el emjambre
mejorLocVal=aplicar_funcion(imagen,mejorLocPos); % mejorLocVal-->vector de psnr's
[mejorGlobalVal,mejorGlobalIndex]=min(mejorLocVal); %Minimo global entre todas las particulas
mejorGlobalPos=mejorLocPos(:,mejorGlobalIndex);
velocPartic=zeros(size(posParticulas)); %Velocidades iniciales

%Particulas: Inicio de algoritmo------------------------

while cantIter<maxIter && TolCorte<mejorGlobalVal
 
    %Verifico peso inercial
    if(p_inercial<0)
        p_inercial = 1;
    else
        p_inercial=(maxIter-cantIter)/maxIter;
    end
    
    %Grafico la posicion parcial de las particulas
    graficar_particulas(intervalo,posParticulas,aplicar_funcion(Nfunc,posParticulas));
    pause(0.1);
    
    %actualizacion de velocidad: Rand de r1i y r2i
    r1=rand(size(posParticulas));
    r2=rand(size(posParticulas));
    
    %Calculo la velocidad de las particulas
    velocPartic=p_inercial*velocPartic+c1*r1.*(mejorLocPos-posParticulas)+c2*r2.*(repmat(mejorGlobalPos,1,cantParticulas)-posParticulas);
    
    %Actualizo la posicion de las particulas
    posParticulas=posParticulas+velocPartic;
    
    %Las particulas que se salen del intervalo las reubico en los extremos del intervalo
    posParticulas=verificar_intervalo(posParticulas,intervalo);
    
    %Calculo las nuevas posiciones y valores de las particulas
    funLocales=aplicar_funcion(Nfunc,posParticulas);
    %Comparo valor de la posicion actual (posParticulas+1) con la vieja (posParticulas)
    menores=funLocales<mejorLocVal;
    %Reemplazo por los nuevos minimos tanto en los valores como en las posiciones
    mejorLocVal(menores==1)=funLocales(menores==1);
    mejorLocPos(:,menores==1)=posParticulas(:,menores==1);
    
    %Calculo la mejor posicion y valor global entre todas las particulas (Min. Global)
    [funGlobalVal,funGlobalPos]=min(mejorLocVal);
    if funGlobalVal<mejorGlobalVal
        mejorGlobalVal=funGlobalVal;
        mejorGlobalPos=mejorLocPos(:,funGlobalPos);
    end
    
    %Muestro el resultado parcial
    resultado_parcial(cantIter,mejorGlobalVal,mejorGlobalPos);
    cantIter=cantIter+1;
end
%Particulas: Fin del algoritmo------------------------
end





