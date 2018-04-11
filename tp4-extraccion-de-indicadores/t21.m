%% Preliminar: Seteo del ambiente
clear;
close all;
clc;

% NOTA: SETEAR LA VARIABLE ROOT CON EL PATH DONDE GUARDASTE LAS IM�GENES
% DEL PR�CTICO. ACORDARSE DE INCLUIR '\' AL FINAL.
%root = '...';
root = 'img/';

% Abro la imagen, la segmentaci�n de referencia y la m�scara
I = imread(strcat(root, 'ivus.png'));
I = double(I)/255;
gt = imread(strcat(root, 'ivus_manual1.png'));
mask = imread(strcat(root, 'ivus_mask.png'));
mask = double(mask(:,:,1));

% Acomodamos la m�scara
mask(mask>0) = 1;
mask = double(mask);

figure('Name','Imagen Practico 4 IVUS');
subplot(1,3,1);  imshow(I); title('Original');
subplot(1,3,2);  imshow(gt); title('Ground Truth');
subplot(1,3,3);  imshow(mask); title('Mascara');

%% Ejercicio 1
% Realizar un umbralado de la banda del verde preprocesada para obtener los
% vasos sangu�neos. �Qu� dificultades se observan en los resultados obtenidos?

% Modific� este valor con el que m�s te guste :)
threshold = 0.4;

% Segmentaci�n por umbralado
segm = I;
segm(I <= threshold) = 1;
segm(I > threshold) = 0;

%Diferencia con Parte 1 - Filtrado
segmFiltrado = I;

%Cambiar el tama�o de ventana
ladoVentana = 20;

Ifiltrada = medfilt2(I, [ladoVentana ladoVentana]);
segmFiltrado(Ifiltrada <= threshold) = 1;
segmFiltrado(Ifiltrada > threshold) = 0;

% Muestro por pantalla
figure('name','Imagen preprocesada y su segmentación por umbralado');
subplot(2,3,1), imshow(I);
title('Imagen preprocesada');
subplot(2,3,2), imshow(segm);
title(strcat('Segmentación con t=',num2str(threshold)));
subplot(2,3,3), imshow(gt);
title('Segmentación de referencia');
subplot(2,3,4), imshow(Ifiltrada);
title('Imagen Filtrada');
subplot(2,3,5), imshow(segmFiltrado);
title(strcat('Segmentación de I filtrada con t=',num2str(threshold)));