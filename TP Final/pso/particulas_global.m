%Particulas: Enjambre del mejor global
function [] = particulas_global(imgRuido,imgOrig,intervalo1,intervalo2,maxIter,TolCorte,p_inercial,c1,c2,cantPart)
cantIter=1;

%Inicializar: genero las particulas al azar en funcion del intervalo
posParticulas=inicializar_particulas(intervalo1,intervalo2,cantPart); %Inicializar posiciones al azar

%Inicializar: obtengo las posiciones de las particulas y calculo el mejor global
mejorLocPos=posParticulas;                      %mejor posicion es la mejor posicion que tomo el emjambre
tic
mejorLocVal=aplicar_funcion(imgRuido,imgOrig,mejorLocPos); % mejorLocVal-->vector de psnr's
toc
[mejorGlobalVal,mejorGlobalIndex]=max(mejorLocVal); %Maximo psnr global entre todas las particulas->pnsr->mas grande es mejor
mejorGlobalPos=mejorLocPos(:,mejorGlobalIndex*4-3:mejorGlobalIndex*4);
velocPartic=zeros(5,cantPart*4); %Velocidades iniciales

%Particulas: Inicio de algoritmo------------------------

while cantIter<=maxIter && TolCorte>mejorGlobalVal
 
    %Verifico peso inercial
    if(p_inercial<0)
        p_inercial = 1;
    else
        p_inercial=(maxIter-cantIter)/maxIter;
    end
    
    %actualizacion de velocidad: Rand de r1i y r2i
    r1=rand(size(posParticulas));
    r2=rand(size(posParticulas));
    AA=p_inercial.*velocPartic;
    BB=c1*r1.*(mejorLocPos-posParticulas);
    CC=c2*r2.*(repmat(mejorGlobalPos,1,cantPart)-posParticulas);
    %Calculo la velocidad de las particulas
    velocPartic=p_inercial.*velocPartic+c1*r1.*(mejorLocPos-posParticulas)+c2*r2.*(repmat(mejorGlobalPos,1,cantPart)-posParticulas);
    
    %Actualizo la posicion de las particulas
    posParticulas=posParticulas+velocPartic;
    
    %Las particulas que se salen del intervalo las  o las que x1<x2 las
    %reasigno a parametros aceptados
    posParticulas=verificar_intervalo(posParticulas,intervalo1,intervalo2);
    
    %Calculo las nuevas posiciones y valores de las particulas
    funLocales=aplicar_funcion(imgRuido,imgOrig,posParticulas); %% vector igual que mejorLocVal
    %Comparo valor de la posicion actual (posParticulas+1) con la vieja (posParticulas)
    mayores=funLocales>mejorLocVal; %todas las particulas con mayor pnsr a los mejores actuales 
    %Reemplazo por los nuevos maximos tanto en los valores como en las posiciones
    mejorLocVal(mayores==1)=funLocales(mayores==1); %escribo pnsr solo de las mejores particulas
   % mejorLocPos=posParticulas(mayores==1); % posiciones de los sistemas que tienen mejores psnr   
    index=find(mayores==1);
    for ii=1:length(index)
        mejorLocPos(:,index(ii)*4-3:index(ii)*4)=posParticulas(:,index(ii)*4-3:index(ii)*4);
    end
   
    
    %mejorGlobalPos=mejorLocPos(:,mejorGlobalIndex*4-3:mejorGlobalIndex*4);
    
    %Calculo la mejor posicion y valor global entre todas las particulas (Max. Global)
    [funGlobalVal,funGlobalPos]=max(mejorLocVal);%busco mayor
    if funGlobalVal>mejorGlobalVal
        mejorGlobalVal=funGlobalVal;
        mejorGlobalPos=mejorLocPos(:,funGlobalPos*4-3:funGlobalPos*4);
    end
    
    %Muestro el resultado parcial
    %resultado_parcial(cantIter,mejorGlobalVal,mejorGlobalPos);
    cantIter=cantIter+1;
end
%Particulas: Fin del algoritmo------------------------
end





