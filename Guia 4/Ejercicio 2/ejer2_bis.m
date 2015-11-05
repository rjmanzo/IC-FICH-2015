clear all; clc; close all;
numeroFuncion=3; 
cantParticulas=20;
[intervalo]=graficaDeFuncion(numeroFuncion); %valor de funcion y el intervalo de busqueda
posParticulas=inicializar_particulas(intervalo,cantParticulas); 
mejorPosiLocal=posParticulas;
mejorValorLocal=aplicar_funcion(numeroFuncion,mejorPosiLocal);
[mejorValorGlobal,mejorGlobalIndex]=min(mejorValorLocal); %Minimo global entre todas las particulas
mejorGlobalPos=mejorPosiLocal(:,mejorGlobalIndex);
iteracion=1; %Contador de iteraciones
velocidadDeParticula=zeros(size(posParticulas)); %Velocidades iniciales CERO
c1=0.5; c2=1-c1; %Constantes fijas
maximoIteraciones=100;
tic;
parti_glob(intervalo,maximoIteraciones,iteracion,mejorPosiLocal,mejorValorLocal,mejorGlobalPos,mejorValorGlobal,posParticulas,velocidadDeParticula,c1,c2,cantParticulas,numeroFuncion)
tiempoTotal=toc;
display(strcat('Tiempo Total: ',num2str(tiempoTotal),' segundos'));

