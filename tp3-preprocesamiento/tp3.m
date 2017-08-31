%%% PRÁCTICO Nº3 - TALLER DE IMÁGENES MÉDICAS - FACULTAD DE CIENCIAS
%%% EXACTAS - UNCPBA.

%% Preliminar: Seteo del ambiente
clear;
close all;
clc;


% Abro las imágenes
file_brain = strcat('Data', filesep, 'brains.mat');
load(file_brain);

% Me quedo con el corte 87 y muevo todas las intensidades al intervalo
% [0, 255]
numcorte = 87;
flair = flair(:,:,numcorte)';
flair = uint8(((flair - min(flair(:))) / (max(flair(:)) - min(flair(:)))) * 255);
t1 = t1(:,:,numcorte)';
t1 = uint8(((t1 - min(t1(:))) / (max(t1(:)) - min(t1(:)))) * 255);
t2 = t2(:,:,numcorte)';
t2 = uint8(((t2 - min(t2(:))) / (max(t2(:)) - min(t2(:)))) * 255);
t1c = t1c(:,:,numcorte)';
t1c = uint8(((t1c - min(t1c(:))) / (max(t1c(:)) - min(t1c(:)))) * 255);

%% Ejercicio 1.a)
% Obtener el histograma de la imagen de resonancia magnética de modalidad T1.
% Qué dificultad se encuentra al visualizar el histograma? 
[~,Ft1] = mode(t1(:));

% Muestro un corte de la imagen y el histograma
fprintf('\n\n Ejercicio 1.a) \n\n');

figure('name','Histograma de la modalidad T1')
subplot(1,2,1), imshow(t1);
subplot(1,2,2), imhist(t1,256); ylim([0 Ft1]);


%% Ejercicio 1.b)
% Obtener el histograma de cada modalidad de la imagen de resonancia 
% magnética, aplicando una máscara a cada una de ellas. 
% Discutir las características de cada uno y comparar brevemente.

% Armo una máscara sólo de la parte que nos interesa (el cerebro)
mask = single(flair) + single(t1) + single(t1c) + single(t2);
mask(mask>0) = 1;
mask = logical(mask);


fprintf('\n\n Ejercicio 1.b) \n\n');
[~,Ff] = mode(flair(mask));
[~,Ft1] = mode(t1(mask));
[~,Ft1c] = mode(t1c(mask));
[~,Ft2] = mode(t2(mask));
[~,Ff2] = mode(flair(:));

% Muestro un corte de la imagen y el histograma
figure('name','Histograma de la modalidad FLAIR')
subplot(1,2,1), imshow(flair);
subplot(1,2,2), imhist(flair(mask),256); ylim([0 Ff]);

% Muestro un corte de la imagen y el histograma
figure('name','Histograma de la modalidad T1')
subplot(1,2,1), imshow(t1);
subplot(1,2,2), imhist(t1(mask),256); ylim([0 Ft1]);

% Muestro un corte de la imagen y el histograma
figure('name','Histograma de la modalidad T1 con contraste de gadolinio')
subplot(1,2,1), imshow(t1c);
subplot(1,2,2), imhist(t1c(mask),256); ylim([0 Ft1c]);

% Muestro un corte de la imagen y el histograma
figure('name','Histograma de la modalidad T2')
subplot(1,2,1), imshow(t2);
subplot(1,2,2), imhist(t2(mask),256); ylim([0 Ft2]);

%% Ejercicio 1.c)
% Obtener las intensidades máxima, mínima y promedio de cada imagen. 
% Obtener la moda del histograma. ¿Coinciden la moda y la intensidad 
% máxima? ¿Por qué? Comparar los valores de moda obtenidos para cada 
% imagen.

close all;
fprintf('\n\n Ejercicio 1.c) \n\n');

% Calculo el máximo valor de intensidad dentro del cerebro
max_flair = max(flair(mask));
% Calculo el mínimo valor de intensidad dentro del cerebro
min_flair = min(flair(mask));
% Calculo el valor promedio de intensidad dentro del cerebro
mean_flair = mean(flair(mask));
% Calculo la moda de intensidad dentro del cerebro
mode_flair = mode(flair(mask));
% Muestro los valores por pantalla
fprintf(strcat('Flair: MAX=', num2str(max_flair), ' ; MIN=', num2str(min_flair), ' ; MEAN=', num2str(mean_flair), ' ; MODE=', num2str(mode_flair), '\n'));

%muestro los valores calculados sobre los histograma

figure('name','Histograma de la modalidad FLAIR')
subplot(1,2,1), imshow(flair);
subplot(1,2,2), imhist(flair(mask),256); ylim([0 Ff]); 

l_mean=line([mean_flair,mean_flair],[0 Ff],'Color','Yellow'); 
l_min=line([min_flair,min_flair],[0 Ff],'Color','Green');
l_max=line([max_flair,max_flair],[0 Ff],'Color','Red');
l_mode=line([mode_flair,mode_flair],[0 Ff],'Color','Magenta'); 
legend([l_mean,l_min,l_max,l_mode],'Mean','Min','Max','Mode')


% Calculo el máximo valor de intensidad dentro del cerebro
max_t1 = max(t1(mask));
% Calculo el mínimo valor de intensidad dentro del cerebro
min_t1 = min(t1(mask));
% Calculo el valor promedio de intensidad dentro del cerebro
mean_t1 = mean(t1(mask));
% Calculo la moda de intensidad dentro del cerebro
mode_t1 = mode(t1(mask));
% Muestro los valores por pantalla
fprintf(strcat('T1: MAX=', num2str(max_t1), ' ; MIN=', num2str(min_t1), ' ; MEAN=', num2str(mean_t1), ' ; MODE=', num2str(mode_t1), '\n'));


% Muestro un corte de la imagen y el histograma
figure('name','Histograma de la modalidad T1')
subplot(1,2,1), imshow(t1);
subplot(1,2,2), imhist(t1(mask),256); ylim([0 Ft1]);

l_mean=line([mean_t1,mean_t1],[0 Ft1],'Color','Yellow'); 
l_min=line([min_t1,min_t1],[0 Ft1],'Color','Green');
l_max=line([max_t1,max_t1],[0 Ft1],'Color','Red');
l_mode=line([mode_t1,mode_t1],[0 Ft1],'Color','Magenta'); 
legend([l_mean,l_min,l_max,l_mode],'Mean','Min','Max','Mode')

% Calculo el máximo valor de intensidad dentro del cerebro
max_t1c = max(t1c(mask));
% Calculo el mínimo valor de intensidad dentro del cerebro
min_t1c = min(t1c(mask));
% Calculo el valor promedio de intensidad dentro del cerebro
mean_t1c = mean(t1c(mask));
% Calculo la moda de intensidad dentro del cerebro
mode_t1c = mode(t1c(mask));
% Muestro los valores por pantalla
fprintf(strcat('T1c: MAX=', num2str(max_t1c), ' ; MIN=', num2str(min_t1c), ' ; MEAN=', num2str(mean_t1c), ' ; MODE=', num2str(mode_t1c), '\n'));

% Muestro un corte de la imagen y el histograma
figure('name','Histograma de la modalidad T1 con contraste de gadolinio')
subplot(1,2,1), imshow(t1c);
subplot(1,2,2), imhist(t1c(mask),256); ylim([0 Ft1c]);

l_mean=line([mean_t1c,mean_t1c],[0 Ft1c],'Color','Yellow'); 
l_min=line([min_t1c,min_t1c],[0 Ft1c],'Color','Green');
l_max=line([max_t1c,max_t1c],[0 Ft1c],'Color','Red');
l_mode=line([mode_t1c,mode_t1c],[0 Ft1c],'Color','Magenta'); 
legend([l_mean,l_min,l_max,l_mode],'Mean','Min','Max','Mode')


% Calculo el máximo valor de intensidad dentro del cerebro
max_t2 = max(t2(mask));
% Calculo el mínimo valor de intensidad dentro del cerebro
min_t2 = min(t2(mask));
% Calculo el valor promedio de intensidad dentro del cerebro
mean_t2 = mean(t2(mask));
% Calculo la moda de intensidad dentro del cerebro
mode_t2 = mode(t2(mask));
% Muestro los valores por pantalla
fprintf(strcat('T2: MAX=', num2str(max_t2), ' ; MIN=', num2str(min_t2), ' ; MEAN=', num2str(mean_t2), ' ; MODE=', num2str(mode_t2), '\n'));

% Muestro un corte de la imagen y el histograma
figure('name','Histograma de la modalidad T2')
subplot(1,2,1), imshow(t2);
subplot(1,2,2), imhist(t2(mask),256); ylim([0 Ft2]);
l_mean=line([mean_t2,mean_t2],[0 Ft2],'Color','Yellow'); 
l_min=line([min_t2,min_t2],[0 Ft2],'Color','Green');
l_max=line([max_t2,max_t2],[0 Ft2],'Color','Red');
l_mode=line([mode_t2,mode_t2],[0 Ft2],'Color','Magenta'); 
legend([l_mean,l_min,l_max,l_mode],'Mean','Min','Max','Mode')

%% Ejercicio 1.d)
% Corregir las intensidades del corte de la MRI T1 con contraste de 
% gadolinio utilizando la función imadjust de Matlab. ¿Qué cambios se 
% observan en la imagen? ¿Y en el histograma?

fprintf('\n\n Ejercicio 1.d) \n\n');

% Obtener el corte y el corte ajustado
slice = t1c;
[~,Fslice] = mode(slice(mask));
slice_ajustado = imadjust(slice);
[~,Fsliceajust] = mode(slice_ajustado(mask));

% Mostrar ambos cortes por pantalla
figure('name', 'Comparación entre el histograma del corte original y el del corte ajustado');
subplot(2,2,1); imshow(slice, [min(slice(mask)) max(slice(mask))]);
title('Corte original');
subplot(2,2,2); imhist(slice(mask), 256); ylim([0 Fslice]);
title('Histograma del corte original');
subplot(2,2,3); imshow(slice_ajustado, [min(slice_ajustado(mask)) max(slice_ajustado(mask))]);
title('Corte ajustado');
subplot(2,2,4); imhist(slice_ajustado(mask), 256); ylim([0 Fsliceajust]);
title('Histograma del corte ajustado');

%% Ejercicio 1.e)
% Ajustar nuevamente las intensidades del corte, pero utilizando la función
% adapthisteq. Comparar con el ajuste anterior. ¿Hubo mejoras respecto a la
% identificación de la región necrótica? ¿Y respecto a los demás tejidos?

% Ajustar el corte usando la técnica CLAHE
slice_ajustado_CLAHE = adapthisteq(slice);
[~,Fclahe] = mode(slice_ajustado_CLAHE(mask));

% Graficar los dos slices ajustados y sus histogramas
figure('name', 'Comparación entre el histograma de la imagen ajustada con imadjust y el del corte ajustado con CLAHE');
subplot(2,2,1); imshow(slice_ajustado, [min(slice_ajustado(mask)) max(slice_ajustado(mask))]);
title('Corte ajustado con imadjust');
subplot(2,2,2); imhist(slice_ajustado(mask), 256); ylim([0 Fsliceajust]);
title('Histograma del corte ajustado con imadjust');
subplot(2,2,3); imshow(slice_ajustado_CLAHE, [min(slice_ajustado_CLAHE(mask)) max(slice_ajustado_CLAHE(mask))]);
title('Corte ajustado con CLAHE');
subplot(2,2,4); imhist(slice_ajustado_CLAHE(mask), 256); ylim([0 Fclahe]);
title('Histograma del corte ajustado con CLAHE');



%% Ejercicio 2.a)
% Comparar las 3 bandas de color de la retinografía de ejemplo. ¿En cuál 
% cree que será más fácil segmentar los vasos sanguíneos? Explique por qué.
close all;
clc;

% Abrir la imagen de la retina
I = imread(strcat('Data',filesep,'\retinografia.tif'));

% Mostrar cada banda de color en pantalla
figure('name', 'Bandas de color de la retinografía');
subplot(2,2,1); imshow(I);
title('RGB');
subplot(2,2,2); imshow(I(:,:,1));
title('Rojo');
subplot(2,2,3); imshow(I(:,:,2));
title('Verde');
subplot(2,2,4), imshow(I(:,:,3));
title('Azul');

%% Ejercicio 2.b)
% Estimar el bias del fondo de la retinografía de ejemplo utilizando un 
% filtro de mediana con ventanas de lado 40.

% Obtener el canal verde de la imagen
verde = I(:,:,2);

% Estimar el fondo usando un filtro de mediana de tamaño 40
fondo = medfilt2(verde, [40 40]);

% Mostrar el fondo en pantalla
figure('name', 'Fondo estimado a partir del canal verde');
subplot(1,2,1); imshow(verde);
title('Banda verde');
subplot(1,2,2); imshow(fondo);
title('Fondo estimado');

%% Ejercicio 2.c)
% Sustraer el fondo con bias a la imagen original. Comparar 
% cualitativamente con la imagen anterior en el contexto de la segmentación
% de vasos sanguíneos.

% Sustraerle el fondo al canal verde
sinfondo = double(verde) - double(fondo);

% Mostrar el canal verde original y el canal verde sin fondo
figure
subplot(1, 3, 1); imshow(verde);
title('Canal verde original');
subplot(1, 3, 2); imshow(fondo);
title('Fondo');
subplot(1, 3, 3); imshow(sinfondo, [min(sinfondo(:)) max(sinfondo(:))]);
title('Canal verde con fondo removido');

%% Ejercicio 2.d)
% Estudiar cualitativamente cómo variaría la segmentación a medida que se 
% achican o se agrandan los vecindarios utilizados.

% Setear los tamaños de ventana
ventanas = [10 25 40 70];

% Mostrar por pantalla el fondo estimado y cada imagen sin fondo
numsubplot = 1;
figure('name', 'Fondos estimados con diferentes tamaños de ventana');
for v = ventanas
    % Estimar un fondo usando un vecindario de tamaño v
    fondo = medfilt2(verde, [v v]);
    % Sustraerle el fondo al canal verde
    sinfondo = double(verde) - double(fondo);
    % Mostrar el resultado
    subplot(2, length(ventanas), numsubplot); imshow(sinfondo, [min(sinfondo(:)) max(sinfondo(:))]);
    title(strcat('w=',num2str(v)));
    subplot(2, length(ventanas), numsubplot+length(ventanas)); imshow(fondo, [min(fondo(:)) max(fondo(:))]);
    numsubplot = numsubplot + 1;
end