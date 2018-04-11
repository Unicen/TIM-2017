%% Ejercicio 2.f) Bordes.
% Obtener los bordes de la imagen utilizando el filtro de Canny. 
% Comparar con la segmentaci�n de referencia e indicar diferencias.
close all

% Poner ac� la imagen que quer�s usar para calcular el gradiente
ImagenParaGradiente = Inorm;

% Calculo el filtro de Canny
cannyedges = edge(I/255,'canny');

% Mostrar el gradiente
figure('name','Filtro de Canny');
subplot(1,3,1), imshow(ImagenParaGradiente, [min(ImagenParaGradiente(:)) max(ImagenParaGradiente(:))]);
title('Imagen');
subplot(1,3,2), imshow(cannyedges);
title('Filtro de Canny');
subplot(1,3,3), imshow(gt);
title('Segmentaci�n de referencia');