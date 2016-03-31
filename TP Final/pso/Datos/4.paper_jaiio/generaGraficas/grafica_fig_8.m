%GRafica TABLA IV - figura 8
%TEST CON LA IMAGEN 3 UTILIZADA PARA ENTRENAR EL ALGORITMO (1-50% DE RUIDO)
%Ruido (%)	
clear all,close all, clc
ruido=[1 2 5 10 20 30 40 50]
PSNR_Original=[25.8837 23.2070 18.812 15.843 12.789 11.0012 9.7957 8.820]
PSNR_Mediana=[31.1003 31.1553 30.815 30.104 27.663 23.6514 19.2288 15.391]
PSNR_Mpropuesto=[41.4358 39.5991 34.614 31.381 28.603 26.2732 24.2837 21.794]



figure
plot(ruido,PSNR_Original,'b-.x',ruido,PSNR_Mediana,'r--*',ruido,PSNR_Mpropuesto,'g-.o')
xlabel('% Ruido de Sal y Pimiento')
ylabel('PSNR(db)')
xlim([1 50  ])
ylim([0 45  ])
legend('Referencia','Filtro Mediana','Filtro Propuesto')




