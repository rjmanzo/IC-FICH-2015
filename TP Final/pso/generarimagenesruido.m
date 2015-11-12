path_imagen = 'Datos/lena.tif';
original = imresize(imread(path_imagen),0.5);
imwrite(original,'Datos/lena150x150.tif' )
%imshow(original)
%histogram(original)
% 
% original = rgb2gray(imresize(imread(path_imagen),[100 100]));
% imwrite(original,'Datos/bone100x100.tif' )
% 
 ruidosa = imnoise(original,'salt & pepper',0.01);
% 
 imwrite(ruidosa,'Datos/lenaRuido150x150_1por.tif' )
