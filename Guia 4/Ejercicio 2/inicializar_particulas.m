function[pos_particulas]=inicializar_particulas(delta,cant)
   pos_particulas=rand(size(delta,2),cant)*(delta(2)-delta(1))+delta(1);
end
