%% Ejercicio 1.e)
% Ajustar nuevamente las intensidades del corte, pero utilizando la funci�n
% adapthisteq. Comparar con el ajuste anterior. �Hubo mejoras respecto a la
% identificaci�n de la regi�n necr�tica? �Y respecto a los dem�s tejidos?

% Ajustar el corte usando la t�cnica CLAHE
slice_ajustado_CLAHE = adapthisteq(slice);
[~,Fclahe] = mode(slice_ajustado_CLAHE(mask));

% Graficar los dos slices ajustados y sus histogramas
figure('name', 'Comparaci�n entre el histograma de la imagen ajustada con imadjust y el del corte ajustado con CLAHE');
subplot(2,2,1); imshow(slice_ajustado, [min(slice_ajustado(mask)) max(slice_ajustado(mask))]);
title('Corte ajustado con imadjust');
subplot(2,2,2); imhist(slice_ajustado(mask), 256); ylim([0 Fsliceajust]);
title('Histograma del corte ajustado con imadjust');
subplot(2,2,3); imshow(slice_ajustado_CLAHE, [min(slice_ajustado_CLAHE(mask)) max(slice_ajustado_CLAHE(mask))]);
title('Corte ajustado con CLAHE');
subplot(2,2,4); imhist(slice_ajustado_CLAHE(mask), 256); ylim([0 Fclahe]);
title('Histograma del corte ajustado con CLAHE');