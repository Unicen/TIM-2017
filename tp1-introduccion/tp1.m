
% Taller de Im?genes M?dicas
% Trabajo Pr?ctico N? 1
% Evaluaci?n de herramientas de an?lisis de im?genes m?dicas

%% Ejecutar estas sentencias para resetear el ambiente

% Cierra todas las ventanas
close all; 
% Borra las variables del entorno
clear;
% Limpia la consola
clc;

%% Ejercicio 1

% Se lee el primer corte de una MRI en formato DICOM
I = dicomread('Data1/IM-0106-0016.dcm');
% Se establece un colormap gris 
colormap('Gray');
% Se va a mostrar una gr?fica de 3 x 1
subplot(1,3,1);
% En la primera se muestra el corte correspondiente
%imshow(I);
imshow(I, []);
title('Corte de IM-0106');

%% Ejercicio 1.a.i

% Determinar la columna a extraer
n_columna = 128;

% Graficar en la segunda area
subplot(1,3,2);
% Extraemos la columna de la imagen
columna = I(:, n_columna);
% Graficar la columna 128 dela imagen
plot(columna);
title(['Columna ', num2str(n_columna)])
xlim([1 length(columna)])

%% Ejercicio 1.a.ii

% Convertir la imagen a double primero
%I = double(I);

% Calcular la m?xima intensidad de la imagen
max_i = max(I(:));
% Calcular la m?nima intensidad de la imagen
min_i = min(I(:));

% Normalizar la intensidad de la imagen usando los valores precalculados
% Recordar pasar a double!
% Modificar ---------------
Inorm = I;
% -------------------------

% Graficar la imagen resultante
subplot(1, 3, 3)
%imshow(Inorm)
imshow(Inorm, [])
title('Corte normalizado')

%% Ejercicio 1.a.iii

% Calcular la dimensi?n de la imagen
[N,M] = size(I);

% Calcular el promedio de las intensidades
mean_i = sum(I(:)) / (N*M);
fprintf('Media calculada por nosotros: %f\n', mean_i);
% Tambi?n se puede usar la funci?n de Matlab
mean_i = mean(I(:));
fprintf('Media calculada por Matlab: %f\n\n', mean_i);

% Calcular el desv?o est?ndar
desv_estandar = sqrt( sum(sum((I - mean_i).^2)) / ((N * M) - 1) );
fprintf('Desv?o est?ndar calculado por nosotros: %f\n', desv_estandar);
% Tambi?n se puede hacer usando la funci?n de Matlab
desv_estandar = std(double(I(:)));
fprintf('Desv?o est?ndar calculado por Matlab: %f\n', desv_estandar);

%% Ejercicio 1.b.i

P = 100;
I3 = zeros(N,M,P);
for ii=1:P
    Itmp = dicomread(sprintf('Data1/IM-0106-%04d.dcm',ii));
    I3(:,:,ii) = Itmp;
end
figure(2);
imshow3D(uint8(I3));
