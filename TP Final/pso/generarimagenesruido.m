path_imagen = 'Datos/prueba2/lena_150x150.tif';
original = imread(path_imagen);
%imwrite(original,'Datos/prueba2/lena_150x150.tif' )
%imshow(original)
%histogram(original)
% 
% original = rgb2gray(imresize(imread(path_imagen),[100 100]));
% imwrite(original,'Datos/bone100x100.tif' )
% 
 ruidosa = imnoise(original,'salt & pepper',0.2);
% 
 imwrite(ruidosa,'Datos/prueba2/lena_150x150_20por.tif' )
