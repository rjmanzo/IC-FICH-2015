function [a] = crear_sistema(nombre,S,flagWrite,flagSalida) %posParticula
%CREAR_SISTEMA Summary of this function goes here
%   Detailed explanation goes here
%si flagSalida=1 se modifican reglas de salida y se dejan constantes las
%reglas de entrada
%si flagSalida=0 se modifican reglas de entrada y se dejan constantes las
%reglas de salida

%====================================
%modificar Reglas de salida - reglas de entrada constantes
%====================================
if flagSalida==1
a = newfis(nombre);
%Conjunto Entrada P1----------------------------
a.input(1).name = 'P1';
a.input(1).range = [0 255];
a.input(1).mf(1).name = 'Dark';
a.input(1).mf(1).type = 'gauss2mf';
a.input(1).mf(1).params = [50 0 18 50];
a.input(1).mf(2).name = 'Avg';
a.input(1).mf(2).type = 'gauss2mf';
a.input(1).mf(2).params = [18 100 18 150];
a.input(1).mf(3).name = 'Light';
a.input(1).mf(3).type = 'gauss2mf';
a.input(1).mf(3).params = [18 200 18 255];
%Conj. Entrada P2----------------------------
a.input(2).name = 'P2';
a.input(2).range = [0 255];
a.input(2).mf(1).name = 'Dark';
a.input(2).mf(1).type = 'gauss2mf';
a.input(2).mf(1).params = [50 0 18 50];
a.input(2).mf(2).name = 'Avg';
a.input(2).mf(2).type = 'gauss2mf';
a.input(2).mf(2).params = [18 100 18 150];
a.input(2).mf(3).name = 'Light';
a.input(2).mf(3).type = 'gauss2mf';
a.input(2).mf(3).params = [18 200 18 255];
%Conj. Salida--------------------------------
%Este es el conjunto que sufre los cambios
a.output(1).name = 'Decision';
a.output(1).range = [0 255];
a.output(1).mf(1).name = 'Dark'
a.output(1).mf(1).type = 'gauss2mf';
a.output(1).mf(1).params = S(1,:); %[49 0 18 49];
a.output(1).mf(2).name = 'AmL';
a.output(1).mf(2).type = 'gauss2mf';
a.output(1).mf(2).params = S(2,:); %[18 151 18 199];
a.output(1).mf(3).name = 'Avg';
a.output(1).mf(3).type = 'gauss2mf';
a.output(1).mf(3).params = S(3,:); %[18 101 18 149];
a.output(1).mf(4).name = 'Light';
a.output(1).mf(4).type = 'gauss2mf';
a.output(1).mf(4).params = S(4,:); %[18 201 18 255];
a.output(1).mf(5).name = 'DmA';
a.output(1).mf(5).type = 'gauss2mf';
a.output(1).mf(5).params = S(5,:); %[18 51 18 99];
%Reglas--------------------------------------
a.rule(1).antecedent = [1 1];
a.rule(1).consequent = [1];
a.rule(1).weight = 1;
a.rule(1).connection = 1;
a.rule(2).antecedent = [1 2];
a.rule(2).consequent = [5];
a.rule(2).weight = 1;
a.rule(2).connection = 1;
a.rule(3).antecedent = [1 3];
a.rule(3).consequent = [3];
a.rule(3).weight = 1;
a.rule(3).connection = 1;
a.rule(4).antecedent = [2 1];
a.rule(4).consequent = [5];
a.rule(4).weight = 1;
a.rule(4).connection = 1;
a.rule(5).antecedent = [2 2];
a.rule(5).consequent = [3];
a.rule(5).weight = 1;
a.rule(5).connection = 1;
a.rule(6).antecedent = [2 3];
a.rule(6).consequent = [2];
a.rule(6).weight = 1;
a.rule(6).connection = 1;
a.rule(7).antecedent = [3 1];
a.rule(7).consequent = [3];
a.rule(7).weight = 1;
a.rule(7).connection = 1;
a.rule(8).antecedent = [3 2];
a.rule(8).consequent = [2];
a.rule(8).weight = 1;
a.rule(8).connection = 1;
a.rule(9).antecedent = [3 3];
a.rule(9).consequent = [4];
a.rule(9).weight = 1;
a.rule(9).connection = 1;
else
    %====================================
    %modificar Reglas de entrada - deja constantes la reglas de salida
    %====================================
    if flagSalida==0
a = newfis(nombre);
%Conj. Entrada P1----------------------------
a.input(1).name = 'P1';
a.input(1).range = [0 255];
a.input(1).mf(1).name = 'Dark';
a.input(1).mf(1).type = 'gauss2mf';
% a.input(1).mf(1).params = [50 0 18 50];
a.input(1).mf(1).params = S(1,:);
a.input(1).mf(2).name = 'Avg';
a.input(1).mf(2).type = 'gauss2mf';
% a.input(1).mf(2).params = [18 100 18 150];
a.input(1).mf(2).params = S(2,:);
a.input(1).mf(3).name = 'Light';
a.input(1).mf(3).type = 'gauss2mf';
% a.input(1).mf(3).params = [18 200 18 255];
a.input(1).mf(3).params = S(3,:);
%Conj. Entrada P2----------------------------
a.input(2).name = 'P2';
a.input(2).range = [0 255];
a.input(2).mf(1).name = 'Dark';
a.input(2).mf(1).type = 'gauss2mf';
% a.input(2).mf(1).params = [50 0 18 50];
a.input(2).mf(1).params = S(1,:);
a.input(2).mf(2).name = 'Avg';
a.input(2).mf(2).type = 'gauss2mf';
% a.input(2).mf(2).params = [18 100 18 150];
a.input(2).mf(2).params = S(2,:);
a.input(2).mf(3).name = 'Light';
a.input(2).mf(3).type = 'gauss2mf';
% a.input(2).mf(3).params = [18 200 18 255];
a.input(2).mf(3).params = S(3,:);

%Conjuntos Salida--------------------------------
%Este es el conjunto no sufre cambios 
a.output(1).name = 'Decision';
a.output(1).range = [0 255];
a.output(1).mf(1).name = 'Dark'
a.output(1).mf(1).type = 'gauss2mf';
% a.output(1).mf(1).params = S(4,:); %[49 0 18 49];
a.output(1).mf(1).params = [49 0 18 49];
a.output(1).mf(2).name = 'AmL';
a.output(1).mf(2).type = 'gauss2mf';
% a.output(1).mf(2).params = S(5,:); %[18 151 18 199];
a.output(1).mf(2).params = [18 151 18 199];
a.output(1).mf(3).name = 'Avg';
a.output(1).mf(3).type = 'gauss2mf';
% a.output(1).mf(3).params = S(6,:); %[18 101 18 149];
a.output(1).mf(3).params = [18 101 18 149];
a.output(1).mf(4).name = 'Light';
a.output(1).mf(4).type = 'gauss2mf';
% a.output(1).mf(4).params = S(7,:); %[18 201 18 255];
a.output(1).mf(4).params = [18 201 18 255];
a.output(1).mf(5).name = 'DmA';
a.output(1).mf(5).type = 'gauss2mf';
% a.output(1).mf(5).params = S(8,:); %[18 51 18 99];
a.output(1).mf(5).params = [18 51 18 99];

%Reglas--------------------------------------
a.rule(1).antecedent = [1 1];
a.rule(1).consequent = [1];
a.rule(1).weight = 1;
a.rule(1).connection = 1;
a.rule(2).antecedent = [1 2];
a.rule(2).consequent = [5];
a.rule(2).weight = 1;
a.rule(2).connection = 1;
a.rule(3).antecedent = [1 3];
a.rule(3).consequent = [3];
a.rule(3).weight = 1;
a.rule(3).connection = 1;
a.rule(4).antecedent = [2 1];
a.rule(4).consequent = [5];
a.rule(4).weight = 1;
a.rule(4).connection = 1;
a.rule(5).antecedent = [2 2];
a.rule(5).consequent = [3];
a.rule(5).weight = 1;
a.rule(5).connection = 1;
a.rule(6).antecedent = [2 3];
a.rule(6).consequent = [2];
a.rule(6).weight = 1;
a.rule(6).connection = 1;
a.rule(7).antecedent = [3 1];
a.rule(7).consequent = [3];
a.rule(7).weight = 1;
a.rule(7).connection = 1;
a.rule(8).antecedent = [3 2];
a.rule(8).consequent = [2];
a.rule(8).weight = 1;
a.rule(8).connection = 1;
a.rule(9).antecedent = [3 3];
a.rule(9).consequent = [4];
a.rule(9).weight = 1;
a.rule(9).connection = 1;    
    else
        %====================================
        % lee un sistema escrito desde disco de proseso anterior y sobre ese sistema modifica la salidas
        %====================================
        if flagSalida==2 % lee un sistema escrito desde disco por un proseso anterior y sobre ese sistema modifica la salidas
    a = readfis(nombre); %leo el sistema
%Conj. Salida--------------------------------
%Este es el conjunto que sufre los cambios
a.output(1).name = 'Decision';
a.output(1).range = [0 255];
a.output(1).mf(1).name = 'Dark'
a.output(1).mf(1).type = 'gauss2mf';
a.output(1).mf(1).params = S(1,:); %[49 0 18 49];
a.output(1).mf(2).name = 'AmL';
a.output(1).mf(2).type = 'gauss2mf';
a.output(1).mf(2).params = S(2,:); %[18 151 18 199];
a.output(1).mf(3).name = 'Avg';
a.output(1).mf(3).type = 'gauss2mf';
a.output(1).mf(3).params = S(3,:); %[18 101 18 149];
a.output(1).mf(4).name = 'Light';
a.output(1).mf(4).type = 'gauss2mf';
a.output(1).mf(4).params = S(4,:); %[18 201 18 255];
a.output(1).mf(5).name = 'DmA';
a.output(1).mf(5).type = 'gauss2mf';
a.output(1).mf(5).params = S(5,:); %[18 51 18 99];
        else 
    %====================================
    %modificar Reglas de entrada (conjuntos iguales) y reglas de salida
    %====================================
            if flagSalida==3
            a = newfis(nombre);
%Conjunto Entrada P1----------------------------
%Conj. Entrada P1----------------------------
a.input(1).name = 'P1';
a.input(1).range = [0 255];
a.input(1).mf(1).name = 'Dark';
a.input(1).mf(1).type = 'gauss2mf';
% a.input(1).mf(1).params = [50 0 18 50];
a.input(1).mf(1).params = S(1,:);
a.input(1).mf(2).name = 'Avg';
a.input(1).mf(2).type = 'gauss2mf';
% a.input(1).mf(2).params = [18 100 18 150];
a.input(1).mf(2).params = S(2,:);
a.input(1).mf(3).name = 'Light';
a.input(1).mf(3).type = 'gauss2mf';
% a.input(1).mf(3).params = [18 200 18 255];
a.input(1).mf(3).params = S(3,:);
%Conj. Entrada P2----------------------------
a.input(2).name = 'P2';
a.input(2).range = [0 255];
a.input(2).mf(1).name = 'Dark';
a.input(2).mf(1).type = 'gauss2mf';
% a.input(2).mf(1).params = [50 0 18 50];
a.input(2).mf(1).params = S(1,:);
a.input(2).mf(2).name = 'Avg';
a.input(2).mf(2).type = 'gauss2mf';
% a.input(2).mf(2).params = [18 100 18 150];
a.input(2).mf(2).params = S(2,:);
a.input(2).mf(3).name = 'Light';
a.input(2).mf(3).type = 'gauss2mf';
% a.input(2).mf(3).params = [18 200 18 255];
a.input(2).mf(3).params = S(3,:);
%Conj. Salida--------------------------------
%Este es el conjunto que sufre los cambios
a.output(1).name = 'Decision';
a.output(1).range = [0 255];
a.output(1).mf(1).name = 'Dark'
a.output(1).mf(1).type = 'gauss2mf';
a.output(1).mf(1).params = S(4,:); %[49 0 18 49];
a.output(1).mf(2).name = 'AmL';
a.output(1).mf(2).type = 'gauss2mf';
a.output(1).mf(2).params = S(5,:); %[18 151 18 199];
a.output(1).mf(3).name = 'Avg';
a.output(1).mf(3).type = 'gauss2mf';
a.output(1).mf(3).params = S(6,:); %[18 101 18 149];
a.output(1).mf(4).name = 'Light';
a.output(1).mf(4).type = 'gauss2mf';
a.output(1).mf(4).params = S(7,:); %[18 201 18 255];
a.output(1).mf(5).name = 'DmA';
a.output(1).mf(5).type = 'gauss2mf';
a.output(1).mf(5).params = S(8,:); %[18 51 18 99];
%Reglas--------------------------------------
a.rule(1).antecedent = [1 1];
a.rule(1).consequent = [1];
a.rule(1).weight = 1;
a.rule(1).connection = 1;
a.rule(2).antecedent = [1 2];
a.rule(2).consequent = [5];
a.rule(2).weight = 1;
a.rule(2).connection = 1;
a.rule(3).antecedent = [1 3];
a.rule(3).consequent = [3];
a.rule(3).weight = 1;
a.rule(3).connection = 1;
a.rule(4).antecedent = [2 1];
a.rule(4).consequent = [5];
a.rule(4).weight = 1;
a.rule(4).connection = 1;
a.rule(5).antecedent = [2 2];
a.rule(5).consequent = [3];
a.rule(5).weight = 1;
a.rule(5).connection = 1;
a.rule(6).antecedent = [2 3];
a.rule(6).consequent = [2];
a.rule(6).weight = 1;
a.rule(6).connection = 1;
a.rule(7).antecedent = [3 1];
a.rule(7).consequent = [3];
a.rule(7).weight = 1;
a.rule(7).connection = 1;
a.rule(8).antecedent = [3 2];
a.rule(8).consequent = [2];
a.rule(8).weight = 1;
a.rule(8).connection = 1;
a.rule(9).antecedent = [3 3];
a.rule(9).consequent = [4];
a.rule(9).weight = 1;
a.rule(9).connection = 1;
            else 
    %====================================
    %modificar Reglas de entrada (conjuntos distintios) y reglas de salida
    %====================================
                 if flagSalida==4
            a = newfis(nombre);
%Conjunto Entrada P1----------------------------
%Conj. Entrada P1----------------------------
a.input(1).name = 'P1';
a.input(1).range = [0 255];
a.input(1).mf(1).name = 'Dark';
a.input(1).mf(1).type = 'gauss2mf';
% a.input(1).mf(1).params = [50 0 18 50];
a.input(1).mf(1).params = S(1,:);
a.input(1).mf(2).name = 'Avg';
a.input(1).mf(2).type = 'gauss2mf';
% a.input(1).mf(2).params = [18 100 18 150];
a.input(1).mf(2).params = S(2,:);
a.input(1).mf(3).name = 'Light';
a.input(1).mf(3).type = 'gauss2mf';
% a.input(1).mf(3).params = [18 200 18 255];
a.input(1).mf(3).params = S(3,:);
%Conj. Entrada P2----------------------------
a.input(2).name = 'P2';
a.input(2).range = [0 255];
a.input(2).mf(1).name = 'Dark';
a.input(2).mf(1).type = 'gauss2mf';
% a.input(2).mf(1).params = [50 0 18 50];
a.input(2).mf(1).params = S(4,:);
a.input(2).mf(2).name = 'Avg';
a.input(2).mf(2).type = 'gauss2mf';
% a.input(2).mf(2).params = [18 100 18 150];
a.input(2).mf(2).params = S(5,:);
a.input(2).mf(3).name = 'Light';
a.input(2).mf(3).type = 'gauss2mf';
% a.input(2).mf(3).params = [18 200 18 255];
a.input(2).mf(3).params = S(6,:);
%Conj. Salida--------------------------------
%Este es el conjunto que sufre los cambios
a.output(1).name = 'Decision';
a.output(1).range = [0 255];
a.output(1).mf(1).name = 'Dark'
a.output(1).mf(1).type = 'gauss2mf';
a.output(1).mf(1).params = S(7,:); %[49 0 18 49];
a.output(1).mf(2).name = 'AmL';
a.output(1).mf(2).type = 'gauss2mf';
a.output(1).mf(2).params = S(8,:); %[18 151 18 199];
a.output(1).mf(3).name = 'Avg';
a.output(1).mf(3).type = 'gauss2mf';
a.output(1).mf(3).params = S(9,:); %[18 101 18 149];
a.output(1).mf(4).name = 'Light';
a.output(1).mf(4).type = 'gauss2mf';
a.output(1).mf(4).params = S(10,:); %[18 201 18 255];
a.output(1).mf(5).name = 'DmA';
a.output(1).mf(5).type = 'gauss2mf';
a.output(1).mf(5).params = S(11,:); %[18 51 18 99];
%Reglas--------------------------------------
a.rule(1).antecedent = [1 1];
a.rule(1).consequent = [1];
a.rule(1).weight = 1;
a.rule(1).connection = 1;
a.rule(2).antecedent = [1 2];
a.rule(2).consequent = [5];
a.rule(2).weight = 1;
a.rule(2).connection = 1;
a.rule(3).antecedent = [1 3];
a.rule(3).consequent = [3];
a.rule(3).weight = 1;
a.rule(3).connection = 1;
a.rule(4).antecedent = [2 1];
a.rule(4).consequent = [5];
a.rule(4).weight = 1;
a.rule(4).connection = 1;
a.rule(5).antecedent = [2 2];
a.rule(5).consequent = [3];
a.rule(5).weight = 1;
a.rule(5).connection = 1;
a.rule(6).antecedent = [2 3];
a.rule(6).consequent = [2];
a.rule(6).weight = 1;
a.rule(6).connection = 1;
a.rule(7).antecedent = [3 1];
a.rule(7).consequent = [3];
a.rule(7).weight = 1;
a.rule(7).connection = 1;
a.rule(8).antecedent = [3 2];
a.rule(8).consequent = [2];
a.rule(8).weight = 1;
a.rule(8).connection = 1;
a.rule(9).antecedent = [3 3];
a.rule(9).consequent = [4];
a.rule(9).weight = 1;
a.rule(9).connection = 1;
            end
        end
    end
end
%escribo sistema-----
if flagWrite
writefis(a,nombre);
end
end

