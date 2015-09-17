%clear all; 
%close all;
%archivo = 'irisbin';
archivo = 'XOR';
%cp=1; % cantidad de particiones
%path_archivo=strcat('../Datos/',archivo,'.csv');  
%path_salida=strcat('../Datos/particiones/',archivo);
%particionar(path_archivo,path_salida,cp,0.8);

gamma=0.02;  
tasa_max_err=0.05;
epoca_max=300;

% % RBF
% K=6;
% cant_salidas=1;
% t = cputime;
% path_e = strcat('../Datos/particiones/',archivo,'_e_1','.csv');
% path_t = strcat('../Datos/particiones/',archivo,'_e_1','.csv');
% [medias,M]= kmeans(path_e,K,cant_salidas);
% gaussianas=gaussiana(path_e,medias,M,cant_salidas);
% [W,tasa_a,epoca_actual]=rbf(gaussianas,gamma,tasa_max_err,epoca_max,cant_salidas); %LMS
% gaussianas=gaussiana(path_t,medias,M,cant_salidas);
% tasa_a_test_RBF=rbf_test(gaussianas,W,cant_salidas);
% tiempo_ejecucion = cputime-t

% % MLP

neuronas=[3 1];   
alpha=0.2;
criterio=2;
path_entrada_e = strcat('../../Guia',' 2','/Datos/particiones/',archivo,'_e_1','.csv');
path_entrada_t = strcat('../../Guia',' 2','/Datos/particiones/',archivo,'_t_1','.csv');
[tasa_e_mlp,tasa_a_mlp,epoca_mlp,W_mlp]=mlp_ejer4_e(path_entrada_e,criterio,gamma,alpha,tasa_max_err,epoca_max,neuronas);
[tasa_e_t_mlp,tasa_a_t_mlp]=mlp_ejer4_t(path_entrada_t,W_mlp,neuronas);

