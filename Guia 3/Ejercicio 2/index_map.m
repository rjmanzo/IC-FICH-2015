function [ mapeo ] = index_map(indice,act)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[~,m]=size(indice);
mapeo = zeros(1,m);
indx = 0;
for i=1:1:m
    indx = indice(1,i);
    mapeo(1,i) = act(1,indx);
end
end



