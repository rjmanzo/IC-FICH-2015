porcentaje_ruido = 0.5;

for i =1:7
    path_imagen = strcat('Datos/4.paper_jaiio/128/img_',num2str(i-1),'_128x128.tif');
    original = imread(path_imagen);
    [rows columns numberOfColorBands] = size(original);
    %%Guardo la original y la ruidosa en escala de grises
    if (numberOfColorBands>1)
    original_gray = rgb2gray(original);
    else
        original_gray = original;
    end
    ruidosa = imnoise(original_gray,'salt & pepper',porcentaje_ruido);
    %imwrite(original_gray,strcat('Datos/4.paper_jaiio/128/gray/img_',num2str(i),'.tif'));
    imwrite(ruidosa,strcat('Datos/4.paper_jaiio/128/gray_noise_50/img_',num2str(i-1),'_128x128_50por.tif'));
    
    %Guardo la imagen en 128 y su ruidosa
    %gray_resize = imresize(original_gray,[128 128]);
    %ruidosa_128 = imnoise(gray_resize,'salt & pepper',porcentaje_ruido);
    %imwrite(gray_resize,strcat('Datos/4.paper/128/img_',num2str(i),'_128x128.tif'));
    %imwrite(ruidosa_128,strcat('Datos/4.paper/128/gray_noise/img_',num2str(i),'_128x128_5por.tif'));
    
    %
end
