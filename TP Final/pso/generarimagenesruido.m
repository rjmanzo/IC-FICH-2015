path_imagen = 'Datos/2.mandril_distintos_%_ruido/mandril.tif';
original = imread(path_imagen);
%imwrite(original,'Datos/prueba2/lena_150x150.tif' )
%imshow(original)
histogram(original)
title('mandril - histograma')
% 
% original = rgb2gray(imresize(imread(path_imagen),[100 100]));
% imwrite(original,'Datos/bone100x100.tif' )
% 
% ruidosa = imnoise(original,'salt & pepper',0.2);
% 
 %imwrite(ruidosa,'Datos/2.blonde_distintos_%_ruido/blonde_20por.tif' )
