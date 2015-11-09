path_imagen = 'Datos/bone.tif';
original = rgb2gray(imread(path_imagen));

original = rgb2gray(imresize(imread(path_imagen),[100 100]));
imwrite(original,'Datos/bone100x100.tif' )

ruidosa = imnoise(original,'salt & pepper',0.01);

imwrite(ruidosa,'Datos/boneRuido100x100_1por.tif' )
