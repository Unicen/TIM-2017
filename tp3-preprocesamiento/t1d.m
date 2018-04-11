%% Ejercicio 1.d)
% Corregir las intensidades del corte de la MRI T1 con contraste de 
% gadolinio utilizando la funci�n imadjust de Matlab. �Qu� cambios se 
% observan en la imagen? �Y en el histograma?

fprintf('\n\n Ejercicio 1.d) \n\n');

% Obtener el corte y el corte ajustado
slice = t1c;
[~,Fslice] = mode(slice(mask));
slice_ajustado = imadjust(slice);
[~,Fsliceajust] = mode(slice_ajustado(mask));

% Mostrar ambos cortes por pantalla
figure('name', 'Comparaci�n entre el histograma del corte original y el del corte ajustado');
subplot(2,2,1); imshow(slice, [min(slice(mask)) max(slice(mask))]);
title('Corte original');
subplot(2,2,2); imhist(slice(mask), 256); ylim([0 Fslice]);
title('Histograma del corte original');
subplot(2,2,3); imshow(slice_ajustado, [min(slice_ajustado(mask)) max(slice_ajustado(mask))]);
title('Corte ajustado');
subplot(2,2,4); imhist(slice_ajustado(mask), 256); ylim([0 Fsliceajust]);
title('Histograma del corte ajustado');
