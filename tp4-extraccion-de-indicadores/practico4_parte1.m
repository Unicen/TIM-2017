%% Preliminar: Seteo del ambiente
clear;
close all;
clc;

% NOTA: SETEAR LA VARIABLE ROOT CON EL PATH DONDE GUARDASTE LAS IMÁGENES
% DEL PRÁCTICO. ACORDARSE DE INCLUIR '\' AL FINAL.
%root = '...';
root = 'imágenes\';

% Abro la imagen, la segmentación de referencia y la máscara
imagenColor = imread(strcat(root, 'retinografia.tif'));
I = double(imagenColor(:,:,2));
gt = imread(strcat(root, 'retinografia_manual1.gif'));
mask = imread(strcat(root, 'retinografia_mask.gif'));

% Preprocesamos la imagen
fondo = medfilt2(I, [40 40]);
Iprepro = double(I) - double(fondo);
Iprepro = (Iprepro - min(Iprepro(:))) / (max(Iprepro(:)) - min(Iprepro(:)));

% Acomodamos el ground truth
gt(gt>0) = 1;
gt = double(gt);

% Acomodamos la máscara
mask(mask>0) = 1;
mask = double(mask);

figure('Name','Imagen Practico 4 Retinografía');
subplot(2,3,1);  imshow(imagenColor); title('Original');
subplot(2,3,2);  imshow(gt); title('Ground Truth');
subplot(2,3,3);  imshow(I/255); title('Canal Verde');
subplot(2,3,4);  imshow(double(fondo/255)); title('Fondo Canal Verde');
subplot(2,3,5);  imshow(Iprepro); title('Canal Verde Sin Fondo');

%% Ejercicio 1
% Realizar un umbralado de la banda del verde preprocesada para obtener los
% vasos sanguíneos. ¿Qué dificultades se observan en los resultados obtenidos?

% Modificá este valor con el que más te guste :)
threshold = 0.4;

% Segmentación por umbralado
segm = Iprepro;
segm(Iprepro <= threshold) = 1;
segm(Iprepro > threshold) = 0;

% Muestro por pantalla
figure('name','Imagen preprocesada y su segmentación por umbralado');
subplot(1,3,1), imshow(Iprepro);
title('Imagen preprocesada');
subplot(1,3,2), imshow(segm);
title(strcat('Segmentación con t=',num2str(threshold)));
subplot(1,3,3), imshow(gt);
title('Segmentación de referencia');


%% Ejercicio 2.a) Bordes.
% Estudiar las características de los bordes de los vasos sanguíneos en 
% algunos sectores de la imagen de fondo de ojo. ¿A cuál de los bordes que 
% vimos anteriormente se parece más?

Inorm = (I - min(I(:))) / (max(I(:)) - min(I(:)));
figure('name','Seleccioná el perfil de intensidades de un vaso y pulsá doble clic');
imshow(Inorm);
improfile

%% Ejercicio 2.b) Bordes.
% Obtener las componentes Gx y Gy del vector gradiente utilizando la 
% función gradient de Matlab. ¿Qué bordes resalta cada una de las 
% coordenadas? Obtener el módulo y la dirección. ¿Qué bordes destaca 
% el módulo?

% Poner acá la imagen que querés usar para calcular el gradiente
ImagenParaGradiente = Inorm;

% Calculo las componentes en x e y del vector gradiente
[gx, gy] = gradient(ImagenParaGradiente);

% Calculo la norma euclidea del vector gradiente
moduloGradiente = sqrt(gx.^2 + gy.^2);

% Muestro todo en pantalla
figure('name', 'Vector gradiente');
subplot(2, 2, 1), imshow(ImagenParaGradiente);
title('Imagen');
subplot(2, 2, 2), imshow(moduloGradiente .* double(mask), [min(moduloGradiente(:)) max(moduloGradiente(:))]);
title('Modulo de \nabla I');
subplot(2, 2, 3), imshow(gx, [min(gx(:)) max(gx(:))]);
title('Gx');
subplot(2, 2, 4), imshow(gy, [min(gy(:)) max(gy(:))]);
title('Gy');

%% Ejercicio 2.c) Bordes.
% Calcular el gradiente de Sobel de la imagen. Realizar un umbralado. ¿Qué
% resultados se obtienen?

% Poner acá la imagen que querés usar para calcular el gradiente
ImagenParaGradiente = Inorm;

% Obtener el gradiente de Sobel (magnitud y dirección)
[gmag, gdir] = imgradient(ImagenParaGradiente, 'sobel');

% Mostrar el gradiente
figure('name','Gradiente de Sobel');
subplot(1,2,1), imshow(ImagenParaGradiente);
title('Imagen original');
subplot(1,2,2), imshow(gmag, [min(gmag(:)) max(gmag(:))]);
title('Gradiente de Sobel');

% Modificá este valor con el que más te guste :)
threshold = 0.1;

% Segmentación por umbralado
segm = gmag;
segm(gmag >= threshold) = 1;
segm(gmag < threshold) = 0;

% Muestro por pantalla
figure('name','Filtro de Sobel y su segmentación por umbralado');
subplot(1,3,1), imshow(gmag, [min(gmag(:)) max(gmag(:))]);
title('Gradiente de Sobel');
subplot(1,3,2), imshow(segm);
title(strcat('Segmentación con t=',num2str(threshold)));
subplot(1,3,3), imshow(gt);
title('Segmentación de referencia');

%% Ejercicio 2.d) Bordes.
% Calcular el Laplaciano de la imagen. Segmentar la imagen utilizando 
% umbralado ¿Qué características del filtro se observan respecto al ruido?
close all

% Poner acá la imagen que querés usar para calcular el gradiente
ImagenParaGradiente = Inorm;

% Calculo el Laplaciano
H = fspecial('laplacian');
laplaciano = imfilter(I,H);
laplaciano = (laplaciano - min(laplaciano(:))) / (max(laplaciano(:)) - min(laplaciano(:)));

% Mostrar el gradiente
figure('name','Laplaciano');
subplot(1,2,1), imshow(ImagenParaGradiente);
title('Imagen original');
subplot(1,2,2), imshow(laplaciano, [min(laplaciano(:)) max(laplaciano(:))]);
title('Laplaciano');

% Modificá este valor con el que más te guste :)
threshold = 0.48;

% Segmentación por umbralado
segm = laplaciano;
segm(laplaciano > threshold) = 1;
segm(laplaciano <= threshold) = 0;

% Muestro por pantalla
figure('name','Laplaciano y su segmentación por umbralado');
subplot(1,3,1), imshow(laplaciano, [min(laplaciano(:)) max(laplaciano(:))]);
title('Laplaciano');
subplot(1,3,2), imshow(segm);
title(strcat('Segmentación con t=',num2str(threshold)));
subplot(1,3,3), imshow(gt);
title('Segmentación de referencia');

%% Ejercicio 2.e) Bordes.
% Calcular el LOG de la imagen. ¿Que cambios se observan respecto al
% Laplaciano? Obtener una nueva segmentación de los vasos sanguíneos por
% umbralado.
close all

% Poner acá la imagen que querés usar para calcular el gradiente
ImagenParaGradiente = Inorm;

% Calculo el LOG
sigma = 2;
H = fspecial('log', ceil(2 * sigma + 1), sigma);
log_ = imfilter(ImagenParaGradiente,H);
log_ = (log_ - min(log_(:))) / (max(log_(:)) - min(log_(:)));

% Mostrar el gradiente
figure('name','Laplaciano');
subplot(1,2,1), imshow(laplaciano, [min(laplaciano(:)) max(laplaciano(:))]);
title('Laplaciano');
subplot(1,2,2), imshow(log_, [min(log_(:)) max(log_(:))]);
title('LOG');

% Modificá este valor con el que más te guste :)
threshold = 0.57;

% Segmentación por umbralado
segm = log_;
segm(log_ > threshold) = 1;
segm(log_ <= threshold) = 0;

% Muestro por pantalla
figure('name','LOG y su segmentación por umbralado');
subplot(1,3,1), imshow(log_, [min(log_(:)) max(log_(:))]);
title('LOG');
subplot(1,3,2), imshow(segm);
title(strcat('Segmentación con t=',num2str(threshold)));
subplot(1,3,3), imshow(gt);
title('Segmentación de referencia');

%% Ejercicio 2.f) Bordes.
% Obtener los bordes de la imagen utilizando el filtro de Canny. 
% Comparar con la segmentación de referencia e indicar diferencias.
close all

% Poner acá la imagen que querés usar para calcular el gradiente
ImagenParaGradiente = Inorm;

% Calculo el filtro de Canny
cannyedges = edge(I,'canny');

% Mostrar el gradiente
figure('name','Filtro de Canny');
subplot(1,3,1), imshow(ImagenParaGradiente, [min(ImagenParaGradiente(:)) max(ImagenParaGradiente(:))]);
title('Imagen');
subplot(1,3,2), imshow(cannyedges);
title('Filtro de Canny');
subplot(1,3,3), imshow(gt);
title('Segmentación de referencia');