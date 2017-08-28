%%% PRÁCTICO Nº2 - TALLER DE IMÁGENES MÉDICAS - FACULTAD DE CIENCIAS
%%% EXACTAS - UNCPBA.
%%
close all;
knee = imread(strcat('Data',filesep,'knee.jpg'));
knee = knee(:,:,1); %imagen en tonos de gris
% realizar algunos de los ejercicios con la imagen de cerebro
% (mri_brain.jpg) o brain.png


% a) Incorporar ruido a la imagen de prueba.

% I - Salt and pepper.
% imnoise(I,'salt & pepper', d);
% d = densidad del ruido, afectando a d * numel(I) 
d = 0.05;
kneeimsp = imnoise(knee,'salt & pepper',d);
figure(1), imshow(kneeimsp);
titulo = strcat('Imagen con ruido salt&pepper (densidad del ruido: ',num2str(d), ')');
title(titulo);

% II - Ruido gaussiano.
% imnoise(I,'gaussian', M, V);
% I = image, M = mean, V = variance
mean = 0;
variance = 0.01;
kneegauss = imnoise(knee,'gaussian', mean, variance);
figure(2), imshow(kneegauss);
titulo = strcat('Imagen con ruido gaussiano (media: ',num2str(mean), ', varianza: ', num2str(variance), ')');
title(titulo);

%%
% b) Calcular el error cuadrático introducido por el ruido
disp('El error cuadrático medio que introduce el ruido salt&pepper es: ');
msesp = ecm( knee, kneeimsp)
disp('El error cuadrático medio que introduce el ruido gaussiano es: ');
msegauss = ecm( knee, kneegauss)
%%% CALCULAR PSNR

%%
%c) 
%i)
n = 3; %tamaño de la ventana
f = fspecial('average',n);

imspgaussfiltered = imfilter(knee,f,'same');
figure(3), imshow(imspgaussfiltered);
titulo = strcat('Imagen con filtro de media ( tamaño de ventana: ',num2str(n), ')');
title(titulo);

%%
%ii) Aplicar un filtro gaussiano sobre las imágenes.
%returns a rotationally symmetric Gaussian lowpass filter with standard deviation sigma (in pixels). 
%n is a 1-by-2 vector specifying the number of rows and columns in h. (n can also be a scalar, in which case h is n-by-n.) 

n = 3;
sigma = 0.5;
f = fspecial('gaussian',n,sigma);

imspgaussfiltered = imfilter(knee,f,'same');
figure(3), imshow(imspgaussfiltered);
titulo = strcat('Imagen con filtro gaussiano (media: ',num2str(mean), ', varianza: ', num2str(variance), ')');
title(titulo);



%%
%iii) filtro de mediana
neighbourhood = [3 3];
medfiltim = medfilt2(knee, neighbourhood);
figure(5), imshow(medfiltim);
