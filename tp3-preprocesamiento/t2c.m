
%% Ejercicio 2.c)
% Sustraer el fondo con bias a la imagen original. Comparar 
% cualitativamente con la imagen anterior en el contexto de la segmentaci�n
% de vasos sangu�neos.

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