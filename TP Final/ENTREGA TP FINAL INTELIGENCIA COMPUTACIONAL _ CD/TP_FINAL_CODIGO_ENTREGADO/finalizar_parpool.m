function [ ] = finalizar_parpool()

%3 - Cuando queremos parar el pool ejecutamos estas dos lineas
%--------------------------------------------------------------------------------
%Shutdowm parallel pool. 
poolobj = gcp('nocreate');
delete(poolobj);
%--------------------------------------------------------------------------------

end

