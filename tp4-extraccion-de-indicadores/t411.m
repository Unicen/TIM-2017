
%% Ejercicio 1
% Realizar un umbralado de la banda del verde preprocesada para obtener los
% vasos sangu�neos. �Qu� dificultades se observan en los resultados obtenidos?

% Modific� este valor con el que m�s te guste :)
threshold = 0.4;

% Segmentaci�n por umbralado
segm = Iprepro;
segm(Iprepro <= threshold) = 1;
segm(Iprepro > threshold) = 0;

% Muestro por pantalla
figure('name','Imagen preprocesada y su segmentación por umbralado');
subplot(1,3,1), imshow(Iprepro);
title('Imagen preprocesada');
subplot(1,3,2), imshow(segm);
title(strcat('Segmentación con t=',num2str(threshold)));
subplot(1,3,3), imshow(gt);
title('Segmentación de referencia');