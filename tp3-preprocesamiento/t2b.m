
%% Ejercicio 2.b)
% Estimar el bias del fondo de la retinograf�a de ejemplo utilizando un 
% filtro de mediana con ventanas de lado 40.

% Obtener el canal verde de la imagen
verde = I(:,:,2);

% Estimar el fondo usando un filtro de mediana de tama�o 40
fondo = medfilt2(verde, [40 40]);

% Mostrar el fondo en pantalla
figure('name', 'Fondo estimado a partir del canal verde');
subplot(1,2,1); imshow(verde);
title('Banda verde');
subplot(1,2,2); imshow(fondo);
title('Fondo estimado');
