clear all;
close all;
cp=10; % cantidad de particiones
archivo='spheres2d70';
path_archivo=strcat('../Datos/',archivo,'.csv');  
path_salida=strcat('../Datos/particiones/',archivo);
particionar_(path_archivo,path_salida,cp,0.8);

%spheres2d10.csv, spheres2d50.csv y spheres2d70.csv

% 
% %a- 
%     archivo='spheres1d10';
%     figure('Name',archivo,'NumberTitle','off')
%     Err_t=zeros(1,cp); %Errores en la etapa test
%     path_entrada_p = strcat('../Datos/particiones/',archivo,'_e_');
%     path_entrada_t = strcat('../Datos/particiones/',archivo,'_t_');
%     for i=1:cp %Se recorren las particiones
%         strcat('Numero Particion:',num2str(i))
%         [tasa_e,epoca_ac, W]=Ps_training_(strcat(path_entrada_p,num2str(i),'.csv'),2,10,0.088,0.18,archivo);
%         epoca_ac
%         tasa_e
%         Err_t(i)=Ps_test_(strcat(path_entrada_t,num2str(i),'.csv'),W);
%         %pause
%     end
%     media=mean(Err_t);
%     desv=std(Err_t);
    
    %b
%     archivo='spheres2d10';
%     figure('Name',archivo,'NumberTitle','off')
%     Err2d10_t=zeros(1,cp); %Errores en la etapa test
%     path_entrada_p = strcat('../Datos/particiones/',archivo,'_e_');
%     path_entrada_t = strcat('../Datos/particiones/',archivo,'_t_');
%     for i=1:cp %Se recorren las particiones
%         strcat('Numero Particion:',num2str(i))
%         [tasa_e,epoca_ac, W]=Ps_training_(strcat(path_entrada_p,num2str(i),'.csv'),2,10,0.08,0.25,archivo);
%         Err2d10_t(i)=Ps_test_(strcat(path_entrada_t,num2str(i),'.csv'),W);
%         %pause
%     end
%     media2d10=mean(Err2d10_t);
%     desv2d10=std(Err2d10_t);
%     
    
    
%     archivo='spheres2d50';
%     figure('Name',archivo,'NumberTitle','off')
%     Err2d50_t=zeros(1,cp); %Errores en la etapa test
%     path_entrada_p = strcat('../Datos/particiones/',archivo,'_e_');
%     path_entrada_t = strcat('../Datos/particiones/',archivo,'_t_');
%     for i=1:cp %Se recorren las particiones
%         strcat('Numero Particion:',num2str(i))
%         [tasa_e,epoca_ac, W]=Ps_training_(strcat(path_entrada_p,num2str(i),'.csv'),2,10,0.08,0.25,archivo);
%         Err2d50_t(i)=Ps_test_(strcat(path_entrada_t,num2str(i),'.csv'),W);
%         %pause
%     end
%     media2d50=mean(Err2d50_t);
%     desv2d50=std(Err2d50_t);
   
    
%     
        archivo='spheres2d70';
    figure('Name',archivo,'NumberTitle','off')
    Err2d70_t=zeros(1,cp); %Errores en la etapa test
    path_entrada_p = strcat('../Datos/particiones/',archivo,'_e_');
    path_entrada_t = strcat('../Datos/particiones/',archivo,'_t_');
    for i=1:cp %Se recorren las particiones
        strcat('Numero Particion:',num2str(i))
        [tasa_e,epoca_ac, W]=Ps_training_(strcat(path_entrada_p,num2str(i),'.csv'),2,10,0.08,0.25,archivo);
        Err2d70_t(i)=Ps_test_(strcat(path_entrada_t,num2str(i),'.csv'),W);
        %pause
    end
    media2d70=mean(Err2d70_t);
    desv2d70=std(Err2d70_t);
    
    
    
    
    
    
    