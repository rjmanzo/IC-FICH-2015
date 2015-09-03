clear all;
close all;

%Creo la figura para poder visualizar la grafica
% figure('Name','OR','NumberTitle','off')
% 
% %Entreno la neurona
% % Ps_training(archivo,criterio,epoca_max,gamma,tasa_max, graph_title)% 0.000002,0.0002,
% [mean_training_error,epoca_ac,W]=Ps_training('../Datos/OR_trn.csv',3,1000,0.000002,0,'EJER1 - OR');
% %Pruebo la neurona
% mean_test_Err=Ps_test('../Datos/OR_tst.csv',W);
% figure('Name','grafica de error OR','NumberTitle','off')
% plot(mean_training_error);
% title('error en entrenamiento')
% xlabel('numero de epoca')
% ylabel('error')

% pause

%Creo la figura para poder visualizar la grafica
figure('Name','XOR','NumberTitle','off')
%Entreno la neurona
[mean_training_error2,epoca_ac,W]=Ps_training('../Datos/XOR_trn.csv',2,200,0.0003,0.25,'EJER1 - XOR');
mean_test_Err2=Ps_test('../Datos/XOR_tst.csv',W);
figure('Name','grafica de error XOR','NumberTitle','off')
plot(mean_training_error2);
title('error en entrenamiento')
xlabel('numero de epoca')
ylabel('error')