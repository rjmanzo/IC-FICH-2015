clear all;
close all;
M=[-20 -20 -10 -5;
    -10 -5 -5 -2;
    -5 -2 -2 0;
    -2 0 0 2;
    0 2 2 5;
    2 5 5 10;
    5 10 20 20];
cota=20;
paso=2;

d= matris_activacion(cota, paso, M );

