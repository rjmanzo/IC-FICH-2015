function [a] = crear_sistema(nombre,M)
%CREAR_SISTEMA Summary of this function goes here
%   Detailed explanation goes here
a = newfis(nombre);
%Conj. Entrada P1----------------------------
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
a.output(1).mf(1).params = M(1,:); %[49 0 18 49];
a.output(1).mf(2).name = 'AmL';
a.output(1).mf(2).type = 'gauss2mf';
a.output(1).mf(2).params = M(2,:); %[18 151 18 199];
a.output(1).mf(3).name = 'Avg';
a.output(1).mf(3).type = 'gauss2mf';
a.output(1).mf(3).params = M(3,:); %[18 101 18 149];
a.output(1).mf(4).name = 'Light';
a.output(1).mf(4).type = 'gauss2mf';
a.output(1).mf(4).params = M(4,:); %[18 201 18 255];
a.output(1).mf(5).name = 'DmA';
a.output(1).mf(5).type = 'gauss2mf';
a.output(1).mf(5).params = M(5,:); %[18 51 18 99];
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
%escribo sistema-----
writefis(a,nombre);
end

