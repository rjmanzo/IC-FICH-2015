% ============ ENTRADAS
% patrones -> patrones a graficar
function graficar_patrones( archivo )
patrones=load(archivo);
[n,m] = size(patrones);
axis([-5 5 -5 5]);

% ============ Grafico los patrones  =======================
figure('Name', 'Patrones');
title('Conjunto de patrones a clasificar');
hold on;
scatter(patrones(patrones(:,3)==-1,1),patrones(patrones(:,3)==-1,2),'red');
scatter(patrones(patrones(:,3)==1,1),patrones(patrones(:,3)==1,2),'blue','x');
hold off;
pause(1);
end