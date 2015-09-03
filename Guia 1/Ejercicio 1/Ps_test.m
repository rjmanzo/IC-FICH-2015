%%------------- Funcion de prueba (Test) para Perceptron Simple--------

function ep = Ps_test(archivo,W)
    %Inicializacion:
    v_test=load(archivo);
    [n,m]=size(v_test);
    M= zeros(n,m+1); %% Creo la matriz expandida
    M(:,1)=-1; %% Primera fila todos -1 (Ref. X0)
    M(:,2:end)=v_test; %%Reemplazo mi matriz de prueba
    
    %Prueba:
    v=M(:,1:end-1)*W';
    y=f_signo(v);
    e=M(:,end)-y;
    ne=sum(e~=0);
    ep=ne/n;
    
    %%Grafico la solucion al finalizar la epoca
    %figure(3)
    %graph('Test',W,M,2,0.2, 5)
    
    
end

