%%% PR�CTICO N�2 - TALLER DE IM�GENES M�DICAS - FACULTAD DE CIENCIAS
%%% EXACTAS - UNCPBA.
%%

close all;
knee = imread(strcat('Data',filesep,'ultrasound_carotid.png'));
knee = knee(:,:,1); %imagen en tonos de gris
% realizar algunos de los ejercicios con la imagen de cerebro
% (mri_brain.jpg) o brain.png


% a) Incorporar ruido a la imagen de prueba.

% I - Salt and pepper.
% imnoise(I,'salt & pepper', d);
% d = densidad del ruido, afectando a d * numel(I) 
%d = 0.05;
%kneeimsp = imnoise(knee,'salt & pepper',d);
%figure(1), imshow(kneeimsp);
%titulo = strcat('Imagen con ruido salt&pepper (densidad del ruido: ',num2str(d), ')');
%title(titulo);

% II - Ruido gaussiano.
% imnoise(I,'gaussian', M, V);
% I = image, M = mean, V = variance
%mean = 0;
%variance = 0.01;
%kneegauss = imnoise(knee,'gaussian', mean, variance);
%figure(2), imshow(kneegauss);
%titulo = strcat('Imagen con ruido gaussiano (media: ',num2str(mean), ', varianza: ', num2str(variance), ')');
%title(titulo);

%%
% b) Calcular el error cuadr�tico introducido por el ruido
%disp('El error cuadr�tico medio que introduce el ruido salt&pepper es: ');
%msesp = ecm( knee, kneeimsp)
%disp('El error cuadr�tico medio que introduce el ruido gaussiano es: ');
%msegauss = ecm( knee, kneegauss)
%%% CALCULAR PSNR

%%
%c) 
%i)
n = 5; %tama�o de la ventana
f = fspecial('average',n);

imspgaussfiltered = imfilter(knee,f,'same');
% figure(3), imshow(imspgaussfiltered);
% titulo = strcat('Imagen con filtro de media ( tama�o de ventana: ',num2str(n), ')');
% title(titulo);
ecm( knee, imspgaussfiltered)
%%
%ii) Aplicar un filtro gaussiano sobre las im�genes.
%returns a rotationally symmetric Gaussian lowpass filter with standard deviation sigma (in pixels). 
%n is a 1-by-2 vector specifying the number of rows and columns in h. (n can also be a scalar, in which case h is n-by-n.) 

sigma = 0.5;
f = fspecial('gaussian',n,sigma);

imspgaussfiltered = imfilter(knee,f,'same');
% figure(3), imshow(imspgaussfiltered);
% titulo = strcat('Imagen con filtro gaussiano (media: ',num2str(mean), ', varianza: ', num2str(variance), ')');
% title(titulo);


ecm( knee, imspgaussfiltered)

%%
%iii) filtro de mediana
neighbourhood = [n n];
medfiltim = medfilt2(knee, neighbourhood);
% figure(5), imshow(medfiltim);
ecm( knee, medfiltim)
