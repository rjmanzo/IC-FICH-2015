clear all,close all,clc

% MF1='Dark':'gauss2mf',[2 10.3414634688338 2 140.958492784605]
% MF2='Avg':'gauss2mf',[2 0 15.9913986288094 250.64410407783]
% MF3='Light':'gauss2mf',[17 129.37547494109 16.8589109916481 257]
%Entrada: Conjuntos Default
x =[0:5:255]';
y1 = gauss2mf(x,[17 0 17 77.3810602617945]);
y2 = gauss2mf(x,[17 0 17 257]);
y3 = gauss2mf(x,[2 147.879664778598 17 193.649759408928]);
figure(1)
plot(x,y1,'b:',x, y2,'r--',x, y3,'g-.');
xlim([0 255])
xlabel('Entrada')
ylabel('Grado de membresía')
legend('Dark','Avg','Ligth','Location','northoutside','Orientation','horizontal')
legend('boxoff')