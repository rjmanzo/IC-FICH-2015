function [fitness,mejorAptitud,posMejor]= evaluarFitness(x,f)
    if(size(x,2)==1)
        fitness=f(x);
        [mejorAptitud,posMejor]=max(fitness);
    elseif(size(x,2)==2)
        fitness=f(x(:,1),x(:,2));
        [mejorAptitud,posMejor]=max(fitness);
    end
end

