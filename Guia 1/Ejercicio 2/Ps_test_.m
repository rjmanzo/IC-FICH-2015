%%------------- Funcion de prueba (Test) para Perceptron Simple--------

function ep = Ps_test_(archivo,W)
    %Inicializacion:
    v_test=load(archivo);
    [n,m]=size(v_test);
    M= zeros(n,m+1); %% Creo la matriz expandida
    M(:,1)=-1; %% Primera fila todos -1 (Ref. X0)
    M(:,2:end)=v_test; %%Reemplazo mi matriz de prueba
    
    %Prueba:
    v=M(:,1:end-1)*W';
    y=f_signo_(v);
    e=M(:,end)-y;
    ne=sum(e~=0);
    ep=ne/n;
end

