%Ejer2
function [ output_args ] = graficar_conjunto(x,titulo,M)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
[n,m]=size(M);

if(m==4)
    hold on
    plot( M , [ 0 1 1 0 ] );
    title(titulo);
    scatter(x,0,600,'.');
else
    hold on
    for i=1:1:n
        g = M(i,1)-M(i,2):1:M(i,1)+M(i,2);
        y = gaussmf(g,[M(i,1),M(i,2)]);
        plot(g,y);
    end
end
end

