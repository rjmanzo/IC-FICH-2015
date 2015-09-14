clear all; close all;
% Defino el archivo a utilizar
archivo = 'clouds';
% Particiono los datos
Particionar(archivo,1,0.8);
% ========================= SOM ========================================
% % Obtengo la celda con los pesos de todas las neuronas
% [W_SOM] = SOM('clouds_e1',[10 10],0.5,3,[50 350 100] , 1 );
% % Obtengo la etiqueta de cada neurona
% [E] = etiquetar('clouds_e1',W_SOM);
% % Evaluo el clasificador
% [ta_SOM] = clasificar('clouds_p1',W_SOM,E);
% % ========================= MLP ========================================
% Me posiciono en la carpeta
% cd '../../IC_guia1/Ejercicio 3 y 4';
% % Defino la estructura del MLP
% neuronas = [10 13 1];
% % Entreno el MLP
% [W_MLP,tae_MLP,cep_MLP] = EntrenarPM('../../IC_guia2/Ejercicio 2 y 3/Datos/clouds_e1.csv',neuronas,0.1,0.1,300,0.05);
% % Pruebo el MLP
% [tap_MLP] = ProbarPM('../../IC_guia2/Ejercicio 2 y 3/Datos/clouds_p1.csv',W_MLP,neuronas);
% % ========================= RBF ========================================
% Me posiciono en la carpeta
cd '../../IC_guia2/Ejercicio 1';
% Cantidad de gaussianas
k = 50;
% Calculo las medias y la matriz de varianzas
[ medias , U ] = kmeans('../Ejercicio 2 y 3/Datos/clouds_e1.csv',k,1);
% Calculo las salidas de las gaussianas en el entrenamiento
[M] = gaussiana('../Ejercicio 2 y 3/Datos/clouds_e1.csv',medias,U,1);
% Entreno la rbf
[W_RBF,tae_RBF,cep_RBF] = rbf( M , 0.02 , 0.1 , 500 , 1 );
% Calculo las salidas de las gaussianas en la prueba
[M] = gaussiana('../Ejercicio 2 y 3/Datos/clouds_p1.csv',medias,U,1);
% Pruebo la rbf
[tap_RBF] = rbf_test( M , W_RBF , 1 );