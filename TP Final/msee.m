function [ salida ] = msee( original,modificada)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[n,m]=size(original);
sum=0;
for i=1:n
    for j=2:m
      sum=sum+(double(original(i,j))-double(modificada(i,j)))^2;  

    end
end
salida=sum/(n*m);
end
