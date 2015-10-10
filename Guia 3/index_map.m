function [ Mapeo ] = index_map(indice,M)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[n,m]=size(M);
Mapeo = zeros(n,m);
indx = 0;
for i=1:n
    conjuntoi = M(indice(i),:);
    Mapeo(i,:) = conjuntoi;
end
end



