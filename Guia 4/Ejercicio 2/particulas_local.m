%Particulas: Enjambre del mejor local 
function [] = particulas_global(intervalo,Nfunc,maxIter,p_inercial,cantParticulas,c1,c2,entorno)
	%Inicializo la bandera para el ciclo
	cantIter=1; 

	%Inicializar: genero las particulas al azar en funcion del intervalo
	posParticulas=inicializar_particulas(intervalo,cantParticulas); %Inicializar posiciones al azar

	%Inicializar: obtengo las posiciones de las particulas y calculo el mejor del entorno local k
	mejorLocPos=posParticulas;
	mejorLocVal=aplicar_funcion(Nfunc,mejorLocPos);
	%Mejor posicion y valor del entorno K
	for k=1:cantParticulas
        indexEntorno=entornoK(k,cantParticulas,Entorno);
        [funGlobalVal,funGlobalPos]=min(mejorLocVal(indexEntorno));
        mejorEntornoVal(k)=funGlobalVal;
        mejorEntornoPos(:,k)=mejorLocPos(:,funGlobalPos);
	end	
	
	velocPartic=zeros(size(posParticulas)); %Velocidades iniciales

	%Particulas: Inicio de algoritmo------------------------

		while cantIter<maxIter;
			
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
			velocPartic=inercia*velocPartic+c1*r1.*(mejorLocPos-posParticulas)+c2*r2.*(mejorEntornoPos-posParticulas);
						
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
			
			%Calculo la mejor posicion y valor del entorno local k
			for k=1:cantParticulas
				indexEntorno=entornoK(k,cantParticulas,Entorno);
				[funGlobalVal,funGlobalPos]=min(mejorLocVal(indexEntorno));
				if funGlobalVal<mejorEntornoVal(k)
					mejorEntornoVal(k)=funGlobalVal;
					mejorEntornoPos(:,k)=mejorLocPos(:,funGlobalPos);
				end
			end
			
			%Muestro el resultado parcial
			resutlado_parcial(cantIter,mejorGlobalVal,mejorGlobalPos);
			cantIter=cantIter+1;
		end

	%Particulas: Fin del algoritmo------------------------

end

%Entorno Local K
function[index]=entornoK(k,cantidad,n)
    index=k-n:k+n;
    index(index<1)=1;
    index(index>cantidad)=cantidad;
end





