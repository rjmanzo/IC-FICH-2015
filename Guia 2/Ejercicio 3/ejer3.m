clear all; 
close all;
% Defino el archivo a utilizar
archivo = 'clouds_m';
path_archivo=strcat('../Datos/',archivo,'.csv');
path_salida=strcat('../Datos/particiones/',archivo);
particionar(path_archivo,path_salida,1,0.8);

%Visualizo el conjunto de patrones a clasificar
graficar_patrones(path_archivo);

%Path de entrenamiento y test
path_e = strcat('../Datos/particiones/',archivo,'_e_1','.csv');
path_t = strcat('../Datos/particiones/',archivo,'_t_1','.csv');

gamma=0.02; 
alpha=0.2;
tasa_max_err=0.11;
epoca_max=320;
criterio=3;
cant_salidas=1;

%-----------------------------------------------------
%SOM
%-----------------------------------------------------
t = cputime;
% Obtengo la celda con los pesos de todas las neuronas
%SOM(archivo,matris_som,gamma,vecindad,epocas_etapas,cant_salidas,ini)
[W_SOM] = SOM(path_e,[10 10],0.5,3,[20 200 100],cant_salidas,1);
% Obtengo la etiqueta de cada neurona
[E] = etiquetar(path_e,W_SOM);
% Evaluo el clasificador
[tasa_a_t_SOM] = clasificar(path_t,W_SOM,E);
%Fin del temporizador
tiempo_ejecucion_SOM = cputime-t;

%-----------------------------------------------------
%RBF
%-----------------------------------------------------
%Me posiciono en la carpeta
cd ../../Guia' 2'/Ejercicio' 1'/
% Conf. de variables del problema 
K=25; % Cantidad de gaussianas
bandera_M_sigma=1; %bandera_M_sigma=0 -> sigma = 1-> todos circulos,bandera_M_sigma=1 sigmas distintos en la diagonal
t = cputime;
[medias,M]= kmeans(path_e,K,cant_salidas);
gaussianas=gaussiana(path_e,medias,M,cant_salidas,bandera_M_sigma);
[W,tasa_a_rbf,epoca_rbf]=rbf(gaussianas,gamma,tasa_max_err,epoca_max,cant_salidas, criterio); %LMS
gaussianas=gaussiana(path_t,medias,M,cant_salidas,bandera_M_sigma);
tasa_a_t_rbf=rbf_test(gaussianas,W,cant_salidas);
tiempo_ejecucion_RBF = cputime-t;

% % % -----------------------------------------------------
% % % MLP
% % % -----------------------------------------------------
cd ../../Guia' 2'/Ejercicio' 3'/
neuronas=[10 50 1];   
%Inicio del temporizador
t = cputime;
[tasa_e_mlp,tasa_a_mlp,epoca_mlp,W_mlp]=mlp_ejer4_e(path_e,criterio,gamma,alpha,tasa_max_err,epoca_max,neuronas);
[tasa_e_t_mlp,tasa_a_t_mlp]=mlp_ejer4_t(path_t,W_mlp,neuronas);
%Fin del temporizador
tiempo_ejecucion_MLP = cputime-t;


