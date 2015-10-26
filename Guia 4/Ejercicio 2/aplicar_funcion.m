%Funciones: Seleccion el tipo de funcion a aplicar.
function[salidas]=aplicar_funcion(Nfunc,pos)
    switch(Nfunc)
        case 1
            salidas=-pos.*sin(sqrt(abs(pos)));
        case 2
            salidas=pos+5*sin(3*pos)+8*cos(5*pos);
        otherwise
            salidas=((pos(1,:).^2+pos(2,:).^2).^0.25).*(sin(50*(pos(1,:).^2+pos(2,:).^2).^0.1).^2+1);
            
    end

end