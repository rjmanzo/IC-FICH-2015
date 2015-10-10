%Ejer2
function []=graficar_conjunto(s,M)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
[n,m]=size(M);
hold on;
for j=1:n
for i=1:length(s)
 u(i)= membresia( s(i), M(j,:) );
end
plot( s , u );
end
end

