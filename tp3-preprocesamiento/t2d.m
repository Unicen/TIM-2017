
%% Ejercicio 2.d)
% Estudiar cualitativamente c�mo variar�a la segmentaci�n a medida que se 
% achican o se agrandan los vecindarios utilizados.

% Setear los tama�os de ventana
ventanas = [10 25 40 70];

% Mostrar por pantalla el fondo estimado y cada imagen sin fondo
numsubplot = 1;
figure('name', 'Fondos estimados con diferentes tama�os de ventana');
for v = ventanas
    % Estimar un fondo usando un vecindario de tama�o v
    fondo = medfilt2(verde, [v v]);
    % Sustraerle el fondo al canal verde
    sinfondo = double(verde) - double(fondo);
    % Mostrar el resultado
    subplot(2, length(ventanas), numsubplot); imshow(sinfondo, [min(sinfondo(:)) max(sinfondo(:))]);
    title(strcat('w=',num2str(v)));
    subplot(2, length(ventanas), numsubplot+length(ventanas)); imshow(fondo, [min(fondo(:)) max(fondo(:))]);
    numsubplot = numsubplot + 1;
end