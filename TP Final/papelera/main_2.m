clear all
close all
clc

%Cargo la imagen original
path_imagen = 'Datos/cameraman.tif';
% original = gpuArray(imread(path_imagen)); SI QUERES TRABAJAR CON LA GPU
original = imread(path_imagen);
% figure, imshow(original);

%Imagen ruidosa (S&P)
ruidosa = imnoise(original,'salt & pepper',0.05);
figure, imshow(ruidosa);

%Denoise de salt and paper
recuperada = medfilt2(ruidosa,[3 3]);
figure, imshow(recuperada);

%borroso
x=0:1:254; %rango grises 8 bits
r=[1 2 3]; %map
%Entrada
M=[0 25 50 25;
    25 5 128 25;
    200 25 250 50];
% M=[0 0 75 100;
%     50 100 150 200;
%     150 200 255 255];
% salida
S=[50 20;
    100 20;
    150 20;
    200 20];

figure('Name','Conjuntos M y S','NumberTitle','off')
subplot(2,1,1)
graficar_conjunto(x,M);
title('M')
subplot(2,1,2)
graficar_conjunto(x,S);
title('S')

[n,m]=size(ruidosa);

for i=1:m-2
    for j=1:n-2
        rect=[i j 2 2];
        I2 = imcrop(ruidosa,rect); % rect [xmin ymin width height]
        if (I2(2,2)==255 ||I2(2,2)==0)
            DP1 = median(I2(:)');
            %             pixel - norte - sur
            s1=[I2(1,2) I2(3,2)];
            %             pixel - oeste - este
            s2=[I2(2,1) I2(2,3)];
            %             pixel - noroeste - sureste
            s3=[I2(1,1) I2(3,3)];
            %             pixel - suroeste - noreste
            s4=[I2(1,3) I2(3,1)];
            
            % %             --------PRUEBA----------------------
            %             pixel - norte - sur
            %             s1=[144 15];
            % %             -----------------------------------
            
            mapeo=index_map(r,M); % mapeo
            
            %Fuzzy (s1)----------------
            a1=grado_activacion(double(s1(1)),mapeo); %activacion para ese x (P1)
            a2=grado_activacion(double(s1(2)),mapeo); %activacion para ese x (P2)
            a=min(a1,a2); % membresias minimas (AND)
            ss_mean = (double(s1(1)) + double(s1(2))) / 2; %Calculo el promedio. Lo necesito para ver a que conjuntos Bi mapear
            S_act = activacion_conjuntos_salida(ss_mean,S); %Me traigo los conjunto Bi a mapear
            ss1=defuzzification(a,S_act); %respuesta
            
            %Fuzzy (s2)---------------
            a1=grado_activacion(double(s2(1)),mapeo); %activacion para ese x (P1)
            a2=grado_activacion(double(s2(2)),mapeo); %activacion para ese x (P2)
            a=min(a1,a2); % membresias minimas (AND)
            ss_mean = (double(s2(1)) + double(s2(2))) / 2; %Calculo el promedio. Lo necesito para ver a que conjuntos Bi mapear
            S_act = activacion_conjuntos_salida(ss_mean,S); %Me traigo los conjunto Bi a mapear
            ss2=defuzzification(a,S_act); %respuesta
            
            %Fuzzy (s3)---------------
            a1=grado_activacion(double(s3(1)),mapeo); %activacion para ese x (P1)
            a2=grado_activacion(double(s3(2)),mapeo); %activacion para ese x (P2)
            a=min(a1,a2); % membresias minimas (AND)
            ss_mean = (double(s3(1)) + double(s3(2))) / 2; %Calculo el promedio. Lo necesito para ver a que conjuntos Bi mapear
            S_act = activacion_conjuntos_salida(ss_mean,S); %Me traigo los conjunto Bi a mapear
            ss3=defuzzification(a,S_act); %respuesta
            
            %Fuzzy (s4)---------------
            a1=grado_activacion(double(s4(1)),mapeo); %activacion para ese x (P1)
            a2=grado_activacion(double(s4(2)),mapeo); %activacion para ese x (P2)
            a=min(a1,a2); % membresias minimas (AND)
            ss_mean = (double(s4(1)) + double(s4(2))) / 2; %Calculo el promedio. Lo necesito para ver a que conjuntos Bi mapear
            S_act = activacion_conjuntos_salida(ss_mean,S); %Me traigo los conjunto Bi a mapear
            ss4=defuzzification(a,S_act); %respuesta
            
            %Fuzzy (NS1): Relacion entre ss1 y ss2---------------
            a1=grado_activacion(double(ss1),mapeo); %activacion para ese x (P1)
            a2=grado_activacion(double(ss2),mapeo); %activacion para ese x (P2)
            a=min(a1,a2); % membresias minimas (AND)
            ns_mean = (double(ss1) + double(ss2)) / 2; %Calculo el promedio. Lo necesito para ver a que conjuntos Bi mapear
            S_act = activacion_conjuntos_salida(ns_mean,S); %Me traigo los conjunto Bi a mapear
            NS1=defuzzification(a,S_act); %respuesta
            
            %Fuzzy (NS2) : Relacion entre ss3 y ss4---------------
            a1=grado_activacion(double(ss3),mapeo); %activacion para ese x (P1)
            a2=grado_activacion(double(ss4),mapeo); %activacion para ese x (P2)
            a=min(a1,a2); % membresias minimas (AND)
            ns_mean = (double(ss3) + double(ss4)) / 2; %Calculo el promedio. Lo necesito para ver a que conjuntos Bi mapear
            S_act = activacion_conjuntos_salida(ns_mean,S); %Me traigo los conjunto Bi a mapear
            NS2=defuzzification(a,S_act); %respuesta
            
            
            %Fuzzy (NS2) : Relacion entre ss3 y ss4---------------
            a1=grado_activacion(double(ss3),mapeo); %activacion para ese x (P1)
            a2=grado_activacion(double(ss4),mapeo); %activacion para ese x (P2)
            a=min(a1,a2); % membresias minimas (AND)
            ns_mean = (double(ss3) + double(ss4)) / 2; %Calculo el promedio. Lo necesito para ver a que conjuntos Bi mapear
            S_act = activacion_conjuntos_salida(ns_mean,S); %Me traigo los conjunto Bi a mapear
            NS2=defuzzification(a,S_act); %respuesta
            
            %Fuzzy (DP2) : Relacion entre NS1 y NS2---------------
            a1=grado_activacion(double(NS1),mapeo); %activacion para ese x (P1)
            a2=grado_activacion(double(NS2),mapeo); %activacion para ese x (P2)
            a=min(a1,a2); % membresias minimas (AND)
            dp_mean = (double(ss3) + double(ss4)) / 2; %Calculo el promedio. Lo necesito para ver a que conjuntos Bi mapear
            S_act = activacion_conjuntos_salida(dp_mean,S); %Me traigo los conjunto Bi a mapear
            DP2=defuzzification(a,S_act); %respuesta
            
            %Fuzzy (f) : Relacion final entre DP1 y DP2---------------
            a1=grado_activacion(double(DP1),mapeo); %activacion para ese x (P1)
            a2=grado_activacion(double(DP2),mapeo); %activacion para ese x (P2)
            a=min(a1,a2); % membresias minimas (AND)
            f_mean = (double(ss3) + double(ss4)) / 2; %Calculo el promedio. Lo necesito para ver a que conjuntos Bi mapear
            S_act = activacion_conjuntos_salida(f_mean,S); %Me traigo los conjunto Bi a mapear
            f=defuzzification(a,S_act); %respuesta
            
            A = uint8(f);
            I2(2,2)=A;
            for l=i:i+2
                for m=j:j+2
                    ruidosa(m,l)=I2(l-i+1,m-j+1);
                end
            end
        end
    end
end

figure('Name','Salida','NumberTitle','off'), imshow(ruidosa);