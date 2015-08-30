function [tasa_e,tasa_a,Yp,V]=calc_error_ejer4(W,patrones_entr,capas,cant_salidas)
     %Calculo  de tasa error de entrenamiento
      [n,m]=size(patrones_entr);
        X=[-1*ones(n,1) patrones_entr(:,1:end-cant_salidas)];
        for k=1:capas
            V=W{k}*X'; 
            Yp{k}=(sigmoidea_ejer4(V,1))';
            X=[-1*ones(n,1) Yp{k}];
        end
        V=signo_ejer4(Yp{capas});
        if (length(V(1,:))==1) %si tengo una sola salida
            aciertos=sum((V==patrones_entr(:,end-cant_salidas+1:end))); 
        else %si tengo muchas salidas
            % tenemos mas de una salida se deben comparar los vectores
            % salida y_p (pasadas por la signo) con las salidas deseadas y
            aciertos=sum(all(V'==patrones_entr(:,end-cant_salidas+1:end)'));
        end
        tasa_a=aciertos/n;
        tasa_e=1-tasa_a;
end