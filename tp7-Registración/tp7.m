%%
%REGISTRACION BASADA EN INTENSIDAD
%S�LO PARA MATLAB CON IMAGE PROCCESING TOOLBOX

% Ejercicio 1
% Registraci�n basado en intensidades
clear
clc
close all
function e1()
  %Abrir imagen de referencia
  fixed  = imread('knee1.png');

  %Abrir imagen a transformar
  moving = imread('knee2.png');

  %Normalizar
  fixed = double(fixed);
  fixed = (fixed - min(fixed(:))) / (max(fixed(:)) - min(fixed(:)));
  moving = double(moving);
  moving = (moving - min(moving(:))) / (max(moving(:)) - min(moving(:)));

  %Mostrarlas una al lado de la otra para observar diferencia
  figure('Name','Dos imagenes'), 
  subplot(1,2,1); imshow(fixed); title('Fixed');
  subplot(1,2,2); imshow(moving);title('Moving');

  %Mostrar una sobre otra
  figure('Name','Una sobre otra'),
  subplot(1,2,1); imshow(fixed);
  subplot(1,2,2); imshow(moving);
  
  %�Cual tranformaci�n cree que ser� la m�s conveniente?
  %Verificar con MATLAB

  %Funcion de optimizacion
  [optimizer, metric] = imregconfig('multimodal'); %'monomodal' 'multimodal'

  %Cambiar par�metros en el optimizador y analizar su impacto en los
  %resultados

  %optimizer.Epsilon=0.00000015 %0.001 %0.0001
  %optimizer.MaximumIterations=250 %50 %400

  %Calcular otras transformaciones (r�gida, afin,...)

  %Similarity
  movingRegistered = imregister(moving, fixed, 'translation', optimizer, metric); %'rigid' 'translation' 'affine' 'rigid'
  figure('Name','T Traslacion'),
  subplot(1,2,1); imshow(fixed);
  subplot(1,2,2); imshow(movingRegistered);
  
endfunction

%%
%Ejercicio 2

%REGISTRACION BASADA EN LANDMARKS
function e2()
  %Abrir knee
  fixed  = imread('knee1.png');
  fixed = fixed(:,:,1);
  moving = imread('knee2.png');
  moving = moving(:,:,1);

  %Normalizar
  fixed = double(fixed);
  fixed = (fixed - min(fixed(:))) / (max(fixed(:)) - min(fixed(:)));
  moving = double(moving);
  moving = (moving - min(moving(:))) / (max(moving(:)) - min(moving(:)));

  figure('Name','Dos imagenes'), subplot(1,2,1);imshow(fixed);
  subplot(1,2,2); imshow(moving);

  %Herramienta para establecer landmarks en im�genes
  cpselect(moving, fixed);

  %%
  %Transformacion mediante landmarks
  %Calcular otras transformaciones, cambiando el parametro. Ver opciones
  %usando Help

  mytform = cp2tform(movingPoints, fixedPoints, 'affine'); %'polynomial' 'projective' 'similarity'
  registered = imtransform(moving, mytform);

  figure('Name','Transformacion Afin'), subplot(2,2,1);
  imshow(fixed);

  subplot(2,2,2);
  imshow(moving);

  subplot(2,2,3);
  imshow(registered);

  %Notar que cambio las dimensiones en la imagen registrada
  figure('Name','Affine');
  subplot(1,2,1);
  imshow(fixed);

  subplot(1,2,2);
  imshow(registered);


  %%
  %Correccion de la imagen registrada

  sizeMoving = size(moving);
  sizeRegistered = size(registered);

  diferencia = abs(sizeMoving - sizeRegistered);
  esquinaSupIzq = diferencia / 2;
  esquinaSupIzq = circshift(esquinaSupIzq,[0 -1]);
  rect = horzcat(ceil(esquinaSupIzq), sizeMoving-1);
  corregida = imcrop(registered,rect);

  %Muestra las imagenes
  figure('Name','Fixed y Registrada corregida');
  imshowpair(fixed,corregida, 'Scaling', 'joint');



endfunction