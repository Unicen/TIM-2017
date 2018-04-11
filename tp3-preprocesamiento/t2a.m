%% Ejercicio 2.a)
% Comparar las 3 bandas de color de la retinograf�a de ejemplo. �En cu�l 
% cree que ser� m�s f�cil segmentar los vasos sangu�neos? Explique por qu�.
close all;
clc;

% Abrir la imagen de la retina
I = imread(strcat('Data',filesep,'retinografia.tif'));

% Mostrar cada banda de color en pantalla
figure('name', 'Bandas de color de la retinograf�a');
subplot(2,2,1); imshow(I);
title('RGB');
subplot(2,2,2); imshow(I(:,:,1));
title('Rojo');
subplot(2,2,3); imshow(I(:,:,2));
title('Verde');
subplot(2,2,4), imshow(I(:,:,3));
title('Azul');
