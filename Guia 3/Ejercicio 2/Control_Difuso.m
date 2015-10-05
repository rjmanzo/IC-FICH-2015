%function [I,V] = Control_Difuso( e,A)
%Entradas:
    e=-10; %Error
    
    A=[-31  -30  -15 -10
       -15  -10  -10  -5
       -10  -5  -5  0
        -5   0   0  5
         0   5   5  10
         5   10  10 15
         10  15  15 20
         15  20  20 25
         20  25  30 31];
     
  

    B=[-15  -10  -10 -7
       -10  -7  -7  -5
       -7  -5  -5  0
        -5   0   0  10  
         11   15   15  20
         15   20  20 25
         20  25  25 30
         25  35  35 36
         35  36  36 38];

%     BI=[0 1  1  2 
%         1 2  2  3
%         2 3  3  4];
%Inicializaci�n:
    areaV=0;     %Area de trapecio para salida V
    Cen_areaV=0; %Centroide*area para salida V
    areaI=0;     %Area de trapecio para salida V
    Cen_areaI=0; %Centroide*area para salida I
    [cant_conjuntos,~]=size(A);
for i=1:cant_conjuntos %Se recorren los conjuntos
    if (e>A(i,1) && e<A(i,4)) %Si el elementos est� en un triangulito
        if     e>A(i,3) 
            a=(e-A(i,4))/(A(i,3)-A(i,4)); %se calcula el grado de membres�a       
        elseif (e<A(i,2))
            a=(e-A(i,1))/(A(i,2)-A(i,1)); %se calcula el grado de membres�a
        else 
            a=1;
        end
%         %Coordenadas de trapecio para salida V:
%             X1=B(i,1);
%             X2=(B(i,2)-B(i,1))*a+B(i,1);
%             X3=(B(i,3)-B(i,4))*a+B(i,4);
%             X4=B(i,4);

%         areaV=areaV+(X2-X1)*a/2+(X3-X2)*a+(X4-X3)*a/2;
%         Cen_areaV=Cen_areaV+((2/3)*(X2-X1)+X1)*(X2-X1)*a/2 + ((X3-X2)/2+X2)*(X3-X2)*a + ((X4-X3)*1/3+X3)*(X4-X3)*a/2;
%          
%         %Coordenadas de trapecio para salida I:
%             X1=BI(i,1);
%             X2=(BI(i,2)-BI(i,1))*a+BI(i,1);
%             X3=(BI(i,3)-BI(i,4))*a+BI(i,4);
%             X4=BI(i,4);
% 
%         areaI=areaI+(X2-X1)*a/2+(X3-X2)*a+(X4-X3)*a/2;
%         Cen_areaI=Cen_areaI+((2/3)*(X2-X1)+X1)*(X2-X1)*a/2 + ((X3-X2)/2+X2)*(X3-X2)*a + ((X4-X3)*1/3+X3)*(X4-X3)*a/2;
% %          
    end
end
Y=sum(Cen_areaV)/sum(areaV);
if (Y<0)
    I=abs(Y);
    V=0;
else
    I=0;
    V=Y*10;
end
I=sum(Cen_areaI)/sum(areaI);

hold on
%subplot(3,1,1)
graficar(A);
hold on
scatter(e,0,600,'.');

% subplot(3,1,2)
% graficar(B);
% hold on
% scatter(Y,0,600,'.');
% 
% subplot(3,1,3)
% graficar(BI);
% hold on
% scatter(I,0,600,'.');

hold off

%end

