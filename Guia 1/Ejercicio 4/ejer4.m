close all; 
clear all;

neuronas=[8 4 3];   
gamma=0.02;  
tasa_max_err=0.05;
epoca_max=300;
alpha=0.2;
criterio=2;

%Primera parte (determinación de estructura óptima):
%
   cp=1; % cantidad de particiones
   archivo='irisbin';
   path_archivo=strcat('../Datos/',archivo,'.csv');  
   path_salida=strcat('../Datos/particiones/',archivo);
   particionar_ejer4(path_archivo,path_salida,cp,0.8);

path_entrada_e = strcat('../Datos/particiones/',archivo,'_e_1','.csv');
path_entrada_t = strcat('../Datos/particiones/',archivo,'_t_1','.csv');

[tasa_e,tasa_a,epoca,W]=mlp_ejer4_e(path_entrada_e,criterio,gamma,alpha,tasa_max_err,epoca_max,neuronas);
[tasa_e_t,tasa_a_t]=mlp_ejer4_t(path_entrada_t,W,neuronas);
%

%Segunda Parte (usando leave-k-out):
% {
%Leave-k-out:
%     K=30; % Hacer K=1 para hacer leave-one-out;
%     cp=ParticionarLKO('Datos/irisbin.csv',K);
%     errorPrueba=zeros(1,cp);
%     for i=1:cp
%         path_entrada_e=strcat('Datos/irisbin_eLKO',num2str(i),'.csv');
%         path_entrada_t=strcat('Datos/irisbin_pLKO',num2str(i),'.csv');
%         
%        [tasa_e,tasa_a,epoca,W]=mlp_ejer4_e(path_entrada_e,criterio,gamma,alpha,tasa_max_err,epoca_max,neuronas);
%        [tasa_e_t(i),tasa_a_t]=mlp_ejer4_t(path_entrada_t,W,neuronas);
%     end
%     errorPrueba=1-errorPrueba;
%     media=mean(errorPrueba);
%     desv=std(errorPrueba);
%}