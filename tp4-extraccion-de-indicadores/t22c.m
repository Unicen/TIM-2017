%% Ejercicio 2.c) Bordes.
% Calcular el gradiente de Sobel de la imagen. Realizar un umbralado. �Qu�
% resultados se obtienen?

% Poner ac� la imagen que quer�s usar para calcular el gradiente
ImagenParaGradiente = Inorm;

% Obtener el gradiente de Sobel (magnitud y direcci�n)
[gmag, gdir] = imgradient(ImagenParaGradiente, 'sobel');

% Mostrar el gradiente
figure('name','Gradiente de Sobel');
subplot(1,2,1), imshow(ImagenParaGradiente);
title('Imagen original');
subplot(1,2,2), imshow(gmag, [min(gmag(:)) max(gmag(:))]);
title('Gradiente de Sobel');

% Modific� este valor con el que m�s te guste :)
threshold = 0.4;

% Segmentaci�n por umbralado
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