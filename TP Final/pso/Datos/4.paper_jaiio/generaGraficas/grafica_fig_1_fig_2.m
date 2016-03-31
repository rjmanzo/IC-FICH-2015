clear all,close all,clc

% [50 0 18 50];
% [18 100 18 150];
% [18 200 18 255]
%Entrada: Conjuntos Default
x =[0:5:255]';
y1 = gauss2mf(x,[50 0 18 50]);
y2 = gauss2mf(x,[18 100 18 150]);
y3 = gauss2mf(x,[18 200 18 255]);
figure(1)
plot(x,y1,'b:',x, y2,'r--',x, y3,'g-.');
xlim([0 255])
xlabel('Entrada')
ylabel('Grado de membresía')
legend('Dark','Avg','Ligth','Location','northoutside','Orientation','horizontal')
legend('boxoff')


%Salida: Conjuntos Default
x = [0:5:255]';
y1 = gauss2mf(x,[49 0 18 49]);%dark
y2 = gauss2mf(x,[18 151 18 199]);
y3 = gauss2mf(x,[18 101 18 149]);%avg
y4 = gauss2mf(x,[18 201 18 255]);%ligth
y5 = gauss2mf(x,[18 51 18 99]);
figure(2)
plot(x,y1,'b:',x, y5,'r--',x, y3,'g-.',x, y2,'k-',x, y4,'m-..');
xlim([0 255])
xlabel('Salida')
ylabel('Grado de membresía')
legend('Dark','DmA','Avg','AmL','Ligth','Location','northoutside','Orientation','horizontal')
legend('boxoff')

