%1 - Primero inicializamos este listado de comandos. Son para iniciar el
%conjunto de workers de paralelizacion
%--------------------------------------------------------------------------------
%Ini cluster
myCluster=parcluster('local');
%Delete previous Jobs
% delete(myCluster.Jobs)
%Set numbers of core workers
myCluster.NumWorkers=3;
%Tempory file directory
t=tempname();
mkdir(t);
%Set job location
c.JobStorageLocation=t;
%Execute parpool cluster
parpool(myCluster,2);
%--------------------------------------------------------------------------------

%2 - Ejecutas este pequeño ejemplo. Deberia de andar. Si no llega a tirar
%nada esta mal!
%--------------------------------------------------------------------------------
%Use created parallel pool 
gcp();
A = zeros(1,10000000);
parfor i = 1:length(A)
    A(i) = i;
end
%--------------------------------------------------------------------------------

% %3 - Cuando queremos parar el pool ejecutamos estas dos lineas
% %--------------------------------------------------------------------------------
% %Shutdowm parallel pool. 
% poolobj = gcp('nocreate');
% delete(poolobj);
% %--------------------------------------------------------------------------------


