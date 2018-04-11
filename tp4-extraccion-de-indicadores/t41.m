%% Preliminar: Seteo del ambiente
clear;
close all;
clc;

% NOTA: SETEAR LA VARIABLE ROOT CON EL PATH DONDE GUARDASTE LAS IM�GENES
% DEL PR�CTICO. ACORDARSE DE INCLUIR '\' AL FINAL.
%root = '...';
root = 'img/';

% Abro la imagen, la segmentaci�n de referencia y la m�scara
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

% Acomodamos la m�scara
mask(mask>0) = 1;
mask = double(mask);

figure('Name','Imagen Practico 4 Retinograf�a');
subplot(2,3,1);  imshow(imagenColor); title('Original');
subplot(2,3,2);  imshow(gt); title('Ground Truth');
subplot(2,3,3);  imshow(I/255); title('Canal Verde');
subplot(2,3,4);  imshow(double(fondo/255)); title('Fondo Canal Verde');
subplot(2,3,5);  imshow(Iprepro); title('Canal Verde Sin Fondo');
