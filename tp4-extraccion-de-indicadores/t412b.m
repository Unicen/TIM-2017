%% Ejercicio 2.b) Bordes.
% Obtener las componentes Gx y Gy del vector gradiente utilizando la 
% funci�n gradient de Matlab. �Qu� bordes resalta cada una de las 
% coordenadas? Obtener el m�dulo y la direcci�n. �Qu� bordes destaca 
% el m�dulo?

% Poner ac� la imagen que quer�s usar para calcular el gradiente
ImagenParaGradiente = Inorm;

% Calculo las componentes en x e y del vector gradiente
[gx, gy] = gradient(ImagenParaGradiente);

% Calculo la norma euclidea del vector gradiente
moduloGradiente = sqrt(gx.^2 + gy.^2);

% Muestro todo en pantalla
figure('name', 'Vector gradiente');
subplot(2, 2, 1), imshow(ImagenParaGradiente);
title('Imagen');
subplot(2, 2, 2), imshow(moduloGradiente .* double(mask), [min(moduloGradiente(:)) max(moduloGradiente(:))]);
title('Modulo de \nabla I');
subplot(2, 2, 3), imshow(gx, [min(gx(:)) max(gx(:))]);
title('Gx');
subplot(2, 2, 4), imshow(gy, [min(gy(:)) max(gy(:))]);
title('Gy');