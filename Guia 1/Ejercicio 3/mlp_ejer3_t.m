% Funcion de test para perceptron multicapa------

function tasa_e=mlp_ejer3_t(archivo,W,neuronas)
    %Inicializacion:
    capas=length(neuronas);
    cant_salidas=neuronas(end);
    %v_test=load(archivo);
    %[n,m]=size(v_test);
    M=csvread(archivo); 
    [n,~]=size(M);
    X=[-1*ones(n,1) M(:,1:end-cant_salidas)];
    for j=1:capas
        V=W{j}*X'; 
        Yp{j}=(sigmoidea_ejer3(V,1))';
        X=[-1*ones(n,1) Yp{j}];
    end
    V=signo_ejer3(Yp{capas});
    if (length(V(1,:))==1)
        cant_aciertos=sum((V==M(:,end-cant_salidas+1:end))); 
    else
        cant_aciertos=sum(all(V'==M(:,end-cant_salidas+1:end)')); %all perite que se comparen los vectores y no valor por valor
    end
    tasa_e=cant_aciertos/n;
    graph_mlp(V,M);
end