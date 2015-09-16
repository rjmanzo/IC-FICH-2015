clear all; 
close all;
% Defino el archivo a utilizar
archivo = 'clouds';

% % -----------------------------------------------------
% % SOM
% % -----------------------------------------------------
cp=1; % cantidad de particiones

%Particiono
path_archivo= strcat('../../Guia',' 2','/Datos/',archivo,'.csv');
path_salida = strcat('../../Guia',' 2','/Datos/particiones/',archivo);
particionar(path_archivo,path_salida,cp,0.8);

%Path de entrenamiento y test
path_entrada_e = strcat('../../Guia',' 2','/Datos/particiones/',archivo,'_e_1','.csv');
path_entrada_t = strcat('../../Guia',' 2','/Datos/particiones/',archivo,'_t_1','.csv');

%Inicio del temporizador
t = cputime;
% Obtengo la celda con los pesos de todas las neuronas
[W_SOM] = SOM(path_entrada_e,[10 10],0.5,3,[50 350 100],0,2);
% Obtengo la etiqueta de cada neurona
[E] = etiquetar(path_entrada_e,W_SOM);
% Evaluo el clasificador
[ta_SOM] = clasificar(path_entrada_t,W_SOM,E);
%Fin del temporizador
tiempo_ejecucion_SOM = cputime-t;

% % -----------------------------------------------------
% % RBF
% % -----------------------------------------------------
% % Me posiciono en la carpeta
% cd ../../Guia' 2'/Ejercicio' 1'/
% % Conf. de variables del problema
% gamma=0.02;  
% tasa_max_err=0.05;
% epoca_max=300;
% K=50; % Cantidad de gaussianas
% cant_salidas=1;
% %Inicio del temporizador
% t = cputime;
% path_e = strcat('../Datos/particiones/',archivo,'_e_1','.csv');
% path_t = strcat('../Datos/particiones/',archivo,'_e_1','.csv');
% % Calculo las medias y la matriz de varianzas
% [medias,M]= kmeans(path_e,K,cant_salidas);
% % Calculo las salidas de las gaussianas en el entrenamiento
% gaussianas=gaussiana(path_e,medias,M,cant_salidas);
% % Entreno la rbf
% [W,tasa_a,epoca_actual]=rbf(gaussianas,gamma,tasa_max_err,epoca_max,cant_salidas);
% gaussianas=gaussiana(path_t,medias,M,cant_salidas);
% % Pruebo la rbf
% tasa_a_test_RBF=rbf_test(gaussianas,W,cant_salidas);
% %Fin del temporizador
% tiempo_ejecucion_RBF = cputime-t;

% % -----------------------------------------------------
% % MLP
% % -----------------------------------------------------
% % Me posiciono en la carpeta
% cd ../../Guia' 1'/Ejercicio' 4'/
% % Conf. de variables del problema
% neuronas=[8 4 3];   
% alpha=0.2;
% criterio=3;
%epoca_max = 300
% %Inicio del temporizador
%t = cputime;
% path_entrada_e = strcat('../../Guia',' 2','/Datos/particiones/',archivo,'_e_1','.csv');
% path_entrada_t = strcat('../../Guia',' 2','/Datos/particiones/',archivo,'_t_1','.csv');
% [tasa_e_mlp,tasa_a_mlp,epoca_mlp,W_mlp]=mlp_ejer4_e(path_entrada_e,criterio,gamma,alpha,tasa_max_err,epoca_max,neuronas);
% [tasa_e_t_mlp,tasa_a_t_mlp]=mlp_ejer4_t(path_entrada_t,W,neuronas);
% %Fin del temporizador
% %tiempo_ejecucion_MLP = cputime-t;


