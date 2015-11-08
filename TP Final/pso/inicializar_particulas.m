%la posicion de la particulas se define como p1 p2 p3 p4 de c/u
function[particulas]=inicializar_particulas(intervalo1,intervalo2,cant)
    for i=1:cant
    particulas{i}=particula(intervalo1,intervalo2,5);
    end
    particulas=cell2mat(particulas);
end
function[part]=particula(intervalo1,intervalo2,cant)%cantidad de conj salida por cada particula
   %8*rand+2--> numeros reales entre 2 y 10
   %n=round(255*rand) -> numero enteros entre 0 y 255
 %  p1= 8*rand+2
 %  p2= round(255*rand)
 %  p3= p1=8*rand+2
 %  p4= round(255*rand)
   
   p2_min=intervalo1(1);
   p2_max=intervalo1(2);
   p2=round(p2_min+rand(1,cant)*(p2_max-p2_min));
   
   p1_min=intervalo2(1);
   p1_max=intervalo2(2);
   p1=p1_min+rand(1,cant)*(p1_max-p1_min);
   
   p3_min=intervalo2(1);
   p3_max=intervalo2(2);
   p3=p1_min+rand(1,cant)*(p3_max-p1_min);
   
   for i=1:cant
   p4_min=p2(i);
   p4_max=intervalo1(2);
   p4(i)=round(p4_min+rand(1)*(p4_max-p4_min));      
   end
   part=[p1' p2' p3' p4'];
end


