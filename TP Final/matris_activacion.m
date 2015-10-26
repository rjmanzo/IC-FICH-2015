function [ mm ] = matris_activacion(cota, paso, A )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
 x=-cota:paso:cota;
[n,m]=size(A);
for i=1:length(x)
mm(:,i) = grado_activacion(x(i),A )';
end
end

