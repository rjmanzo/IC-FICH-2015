clear all;
close all;

%Creo la figura para poder visualizar la grafica
figure(1)

%Entreno la neurona
% Ps_training(archivo,criterio,epoca_max,gamma,tasa_max, graph_title)
[mean_training_error,epoca_ac,W]=Ps_training('Datos/OR_trn.csv',2,10,0.000005,0.002,'EJER1 - OR');
%Pruebo la neurona
mean_test_Err=Ps_test('Datos/OR_tst.csv',W);
%Creo la figura para poder visualizar la grafica
pause
figure(2);
%Entreno la neurona
[mean_training_error2,epoca_ac,W]=Ps_training('Datos/XOR_trn.csv',2,200,0.3,0.3,'EJER1 - XOR');
mean_test_Err2=Ps_test('Datos/XOR_tst.csv',W);