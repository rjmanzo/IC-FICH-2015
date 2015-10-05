% clear all; 
% close all;
%archivo = 'irisbin';
archivo = 'XOR';
%  cp=1; % cantidad de particiones
%   path_archivo=strcat('../Datos/',archivo,'.csv');  
%   path_salida=strcat('../Datos/particiones/',archivo);
%  particionar(path_archivo,path_salida,cp,0.8);

gamma=0.02;  
tasa_max_err=0.05;
epoca_max=300;
criterio=3;

% RBF
%para XOR
K=4;
cant_salidas=1;
path_e = strcat('../Datos/particiones/',archivo,'_e_1','.csv');
path_t = strcat('../Datos/particiones/',archivo,'_t_1','.csv');

%patrones test
%  patrones=csvread( path_t);
% figure('Name','patrones test');
% title('patrones test');
% hold on
% scatter(patrones(patrones(:,3)==-1,2),patrones(patrones(:,3)==-1,3),'red');
% scatter(patrones(patrones(:,3)==1,2),patrones(patrones(:,3)==1,3),'blue');

[medias,M]= kmeans(path_e,K,cant_salidas);

gaussianas=gaussiana(path_e,medias,M,cant_salidas,0);
[W,tasa_a,epoca_actual]=rbf(gaussianas,gamma,tasa_max_err,epoca_max,cant_salidas,criterio); %LMS

gaussianas=gaussiana(path_t,medias,M,cant_salidas,0);
tasa_a_test_RBF=rbf_test(gaussianas,W,cant_salidas);




