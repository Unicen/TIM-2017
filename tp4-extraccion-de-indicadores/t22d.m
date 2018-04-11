%% Ejercicio 2.d) Bordes.
% Calcular el Laplaciano de la imagen. Segmentar la imagen utilizando 
% umbralado �Qu� caracter�sticas del filtro se observan respecto al ruido?
close all

% Poner ac� la imagen que quer�s usar para calcular el gradiente
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

% Modific� este valor con el que m�s te guste :)
threshold = 0.48;

% Segmentaci�n por umbralado
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
