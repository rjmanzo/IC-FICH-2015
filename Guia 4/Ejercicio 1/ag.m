function [n,x] = ag(tamPoblacion,tamCromosoma,tasaMutacion,iteracionesMaximas,porcentagePadres,aptitudRequerida,Rango,k,f,f2 )
tic
Poblacion=round(rand(tamPoblacion,tamCromosoma)); %Inizializar poblacion al azar
n=1;  %iteraciones -> t               
mejorAptitud=zeros(iteracionesMaximas,1); %Calculo mejor aptitud, uno por cada n
 
x=genotipoTofenotipo(Poblacion,Rango); %decodificacion
[fitness,mejorAptitud(n),mejorPosicion]=evaluarFitness(x,f); %Se calcula el fitness

%grafica inicial
graficarFunciones(f,f2,Rango,aptitudRequerida);
graficarCromosomas (fitness,f2,mejorAptitud(n),mejorPosicion,x,0.5)

while(mejorAptitud(n)<aptitudRequerida && n<iteracionesMaximas)
    progenitores=competencia(fitness,k,porcentagePadres); %seleccion de padres
    hijos=reproduccion(Poblacion,progenitores,tasaMutacion); %reproduccion
    Poblacion=Reemplazo(Poblacion,hijos,mejorPosicion);%reemplazo
    n=n+1;
    x=genotipoTofenotipo(Poblacion,Rango);
    [fitness,mejorAptitud(n),mejorPosicion]=evaluarFitness(x,f); %evaluar mejor fitnnes de poblacion actual
    graficarCromosomas (fitness,f2,mejorAptitud(n),mejorPosicion,x,0.5)
end

figure('Name','Evolucion a lo largo de las iteracion','NumberTitle','off')
plot(1:n,mejorAptitud(1:n));
ylabel('aptitudRequerida')
xlabel('iteracion')
if(length(Rango)==2) %muestro valor valor
    f2(x(mejorPosicion))
else
    f2(x(mejorPosicion),x(mejorPosicion))
end

toc
end







