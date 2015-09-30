% ============ ENTRADAS
% patrones -> patrones a graficar
function graficar_patrones( archivo )
patrones=load(archivo);
[n,m] = size(patrones);
axis([-5 5 -5 5]);

% ============ Grafico los patrones  =======================
hold on;
scatter(patrones(patrones(:,3)==-1,1),patrones(patrones(:,3)==-1,2),'red');
scatter(patrones(patrones(:,3)==1,1),patrones(patrones(:,3)==1,2),'blue','x');
hold off;
pause(1);
end