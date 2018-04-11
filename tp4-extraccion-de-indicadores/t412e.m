%% Ejercicio 2.e) Bordes.
% Calcular el LOG de la imagen. �Que cambios se observan respecto al
% Laplaciano? Obtener una nueva segmentaci�n de los vasos sangu�neos por
% umbralado.
close all

% Poner ac� la imagen que quer�s usar para calcular el gradiente
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

% Modific� este valor con el que m�s te guste :)
threshold = 0.57;

% Segmentaci�n por umbralado
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