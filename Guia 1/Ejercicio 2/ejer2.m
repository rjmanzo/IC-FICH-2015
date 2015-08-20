clear all;
cp=10; % cantidad de particiones
path_archivo='Datos/spheres2d10.csv';    
particionar(path_archivo,cp,0.8);

% 
% %a- 
    figure(1)
    Err_t=zeros(1,cp); %Errores en la etapa test
    path_entrada_p = '../Datos/particiones/spheres2d10_e_';
    path_entrada_t = '../Datos/particiones/spheres2d10_t_';
    for i=1:cp %Se recorren las particiones
        [tasa_e,epoca_ac, W]=Ps_training(strcat(path_entrada_p,num2str(i),'.csv'),1,20,0.3,0.2,'spheres2d10');
        Err_t(i)=Ps_test(strcat(path_entrada_t,num2str(i),'.csv'),W);
    end
    media=mean(Err_t);
    desv=std(Err_t);