function[]=resutlado_parcial(cantIter,mejorGlobalVal,mejorGlobalPos)
if (length(mejorGlobalPos)==2)
      display(strcat('Iteraci�n N� ',num2str(cantIter),', Mejor Global = ',num2str(mejorGlobalVal),...
        ' en posicion (',num2str(mejorGlobalPos(1)),',',num2str(mejorGlobalPos(2)),');'));
else
      display(strcat('Iteraci�n N� ',num2str(cantIter),', Mejor Global = ',num2str(mejorGlobalVal),...
        ' en posicion x=',num2str(mejorGlobalPos)));
end
end