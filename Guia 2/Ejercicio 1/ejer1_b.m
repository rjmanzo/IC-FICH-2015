 clear all; 
 close all;
archivo = 'irisbin';
 %  cp=1; % cantidad de particiones
 %  path_archivo=strcat('../Datos/',archivo,'.csv');  
 %  path_salida=strcat('../Datos/particiones/',archivo);
 % particionar(path_archivo,path_salida,cp,0.8);

gamma=0.02;  
tasa_max_err=0.05;
%epoca_max=10;
%criterio=1;
epoca_max=300;
criterio=3;


% RBF
%para iris
K=10;
cant_salidas=3;
bandera_M_sigma=0; %bandera_M_sigma=0 -> sigma = 1-> todos circulos,bandera_M_sigma=1 sigmas distintos en la diagonal
path_e = strcat('../Datos/particiones/',archivo,'_e_1','.csv');
path_t = strcat('../Datos/particiones/',archivo,'_t_1','.csv');

t = cputime;
[medias,M]= kmeans(path_e,K,cant_salidas);
gaussianas=gaussiana(path_e,medias,M,cant_salidas,bandera_M_sigma);
[W,tasa_a_rbf,epoca_rbf]=rbf(gaussianas,gamma,tasa_max_err,epoca_max,cant_salidas, criterio); %LMS
gaussianas=gaussiana(path_t,medias,M,cant_salidas,bandera_M_sigma);
tasa_a_t_rbf=rbf_test(gaussianas,W,cant_salidas);
tiempo_ejecucion_RBF = cputime-t;

% % MLP
neuronas=[6 4 3];   
alpha=0.2;
t = cputime;
path_entrada_e = strcat('../../Guia',' 2','/Datos/particiones/',archivo,'_e_1','.csv');
path_entrada_t = strcat('../../Guia',' 2','/Datos/particiones/',archivo,'_t_1','.csv');
[tasa_e_mlp,tasa_a_mlp,epoca_mlp,W_mlp]=mlp_ejer4_e(path_entrada_e,criterio,gamma,alpha,tasa_max_err,epoca_max,neuronas);
[tasa_e_t_mlp,tasa_a_t_mlp]=mlp_ejer4_t(path_entrada_t,W_mlp,neuronas);
tiempo_ejecucion_MLP = cputime-t;

