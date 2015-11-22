function[particulas]=verificar_intervalo(particulas,intervalo1,intervalo2)
[~,m]=size(particulas);          
%verifico los sigmas esten dentro de intervalo (intervalo2)

[n,m]=size(particulas);
i=1:2:m;
B=particulas(:,i);
B(find(B<intervalo2(1)))=intervalo2(1); %valor default de sigma en el nivel bajo de gauss2mf
particulas(:,i)=B;
B(find(B>intervalo2(2)))=intervalo2(2); %valor default de sigma en nivel alto de gauss2mf
particulas(:,i)=B;

%verifico que las gaussiana esten dentro de rango x
i=0;
i=2:2:m;
B=particulas(:,i);
B(find(B<intervalo1(1)))=intervalo1(1); %valor default de de ubicacion eje x de la gaussiana
particulas(:,i)=B;
B(find(B>intervalo1(2)))=intervalo1(2); %valor default de de ubicacion eje x de la gaussiana
particulas(:,i)=B;

%verifico que valor sea x1<x2 en gaussianas, sino los invierto 
for i=1:4:m
    for j=1:n
      if(particulas(j,i+1)>particulas(j,i+3))
          aux=particulas(j,i+1);
          particulas(j,i+1)=particulas(j,i+3);
          particulas(j,i+3)=aux;
      end
    end
end


end