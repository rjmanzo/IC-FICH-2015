% particulas_global.m
%---------------------
% SALIDAS
%---------------
% mejorGlobalVal : valor (psnr) de mejor global de emjambre
% mejorGlobalPos : posicion (matris) de la mejor particula global
% cantIter
% --------------
% ENTRADAS
% --------------
% imgRuido:imagen con ruido
% imgOrig: imagen limpia
% intervalo1:intervalo en la que se pueden centrar la gauss
% intervalo2: intervalo de sigmas
% maxIter: cantidad maxima de iteraciones
% TolCorte: tolerancia de corte en db
% c1: constante de aceleracion cognitiva
% c2: constantes de aceleracion global
% cantPart: cantidad de particulas [entre 20 y 30 aprox]
% cantGausseanas: cantidad de gauseanas [entre 3 y 11]
% flagWrite: bandera para escribir sistema a disco o no
%flagWrite=0 no escribe el sistema en el disco
%flagWrite=1    escribe el sistema en el disco

%flagSalida = 0 cantGausseanas=3;. modifica solo conjuntos de entrada (son 3 conj. entradas -> cantGaussenasa= 3)
%flagSalida = 2 . tomando como entrada un sistema desde disco
%flagSalida = 1 cantGausseanas=5;. modifica solo conjuntos de salida (son 5 conj. salidas-> cantGausseanas=5)
%flagSalida = 3 cantGausseanas=8;. modifica entrada(conj iguales) y salida(son 8 conj. -> cantGausseanas=8)
%flagSalida = 4 cantGausseanas=11;. modifica entrada(conj distintos) y salida(son 11 conj. -> cantGausseanas=11
% p_inercial= con decresimiento lineal, gran impacto al inicio y muy poco
% al final

%Particulas: Enjambre del mejor global
function [mejorGlobalVal,mejorGlobalPos,cantIter] = particulas_global(imgRuido,imgOrig,intervalo1,intervalo2,maxIter,TolCorte,c1,c2,cantPart,cantGausseanas,flagWrite,flagSalida)
cantIter=1;

%Inicializar: genero las particulas al azar en funcion del intervalo
posParticulas=inicializar_particulas(intervalo1,intervalo2,cantPart,cantGausseanas); %Inicializar posiciones al azar

%Inicializar: obtengo las posiciones de las particulas y calculo el mejor global
mejorLocPos=posParticulas;                      %mejor posicion es la mejor posicion que tomo el emjambre
tic
mejorLocVal=aplicar_funcion_v2(imgRuido,imgOrig,mejorLocPos,flagWrite,flagSalida); % mejorLocVal-->vector de psnr's
toc
[mejorGlobalVal,mejorGlobalIndex]=max(mejorLocVal); %Maximo psnr global entre todas las particulas->pnsr->mas grande es mejor
mejorGlobalPos=mejorLocPos(:,mejorGlobalIndex*4-3:mejorGlobalIndex*4);
velocPartic=zeros(cantGausseanas,cantPart*4); %Velocidades iniciales

%Particulas: Inicio de algoritmo------------------------

while cantIter<=maxIter && TolCorte>mejorGlobalVal
 
        p_inercial=(maxIter-cantIter)/maxIter;
    
    %actualizacion de velocidad: Rand de r1i y r2i
    r1=rand(size(posParticulas));
    r2=rand(size(posParticulas));
    %Calculo la velocidad de las particulas
    velocPartic=p_inercial.*velocPartic+c1*r1.*(mejorLocPos-posParticulas)+c2*r2.*(repmat(mejorGlobalPos,1,cantPart)-posParticulas);
    
    %Actualizo la posicion de las particulas
    posParticulas=posParticulas+velocPartic;
    
    %Las particulas que se salen del intervalo las  o las que x1<x2 las
    %reasigno a parametros aceptados
    posParticulas=verificar_intervalo(posParticulas,intervalo1,intervalo2);
    
    %Calculo las nuevas posiciones y valores de las particulas
    funLocales=aplicar_funcion_v2(imgRuido,imgOrig,posParticulas,flagWrite,flagSalida); %% vector igual que mejorLocVal
    %Comparo valor de la posicion actual (posParticulas+1) con la vieja (posParticulas)
    mayores=funLocales>mejorLocVal; %todas las particulas con mayor pnsr a los mejores actuales 
    %Reemplazo por los nuevos maximos tanto en los valores como en las posiciones
    mejorLocVal(mayores==1)=funLocales(mayores==1); %escribo pnsr solo de las mejores particulas
    index=find(mayores==1);
    for ii=1:length(index)
        mejorLocPos(:,index(ii)*4-3:index(ii)*4)=posParticulas(:,index(ii)*4-3:index(ii)*4);
    end
 
    
    %Calculo la mejor posicion y valor global entre todas las particulas (Max. Global)
    [funGlobalVal,funGlobalPos]=max(mejorLocVal);%busco mayor
    if funGlobalVal>mejorGlobalVal
        mejorGlobalVal=funGlobalVal;
        mejorGlobalPos=mejorLocPos(:,funGlobalPos*4-3:funGlobalPos*4);
    end
 

    cantIter=cantIter+1;
    mejorGlobalVal
end

%Particulas: Fin del algoritmo------------------------
end





