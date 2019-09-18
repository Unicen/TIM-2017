%%
%REGISTRACION BASADA EN INTENSIDAD
%Sï¿½LO PARA MATLAB CON IMAGE PROCCESING TOOLBOX

% Ejercicio 1
% Registraciï¿½n basado en intensidades

clear
clc
close all
    
  %Abrir imagen de referencia
  fixed  = imread('knee1.png');
  fixed = rgb2gray(fixed);

  %Abrir imagen a transformar
  moving = imread('knee2.png');
  moving = rgb2gray(moving);
  
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
  imshowpair(fixed,moving,'Scaling', 'joint');
  
  %ï¿½Cual tranformaciï¿½n cree que serï¿½ la mï¿½s conveniente?

  %Funcion de optimizacion
  [optimizer, metric] = imregconfig('multimodal'); %'monomodal' 'multimodal'
  %Crear el optimizador y métrico, estableciendo la modalidad a 'multimodal' ya que las imágenes provienen de diferentes sensores

  %Cambiar parï¿½metros en el optimizador y analizar su impacto en los resultados

  optimizer.MaximumIterations= 500 %250 %50 %400
  %optimizer.Epsilon=0.00000015 %0.001 %0.0001
  %optimizer.InitialRadius = 0.009;
  %optimizer.GrowthFactor = 1.01;

  %Calcular otras transformaciones (rï¿½gida, afin,...)
  %Similarity
  movingRegistered = imregister(moving, fixed, 'affine', optimizer, metric); %'rigid' 'translation' 'affine' 

  figure('Name','T Traslacion'),
  subplot(1,2,1); imshow(fixed);
  subplot(1,2,2); imshow(movingRegistered);
 %Mostrar una sobre otra
  figure('Name','Una sobre otra - registradas'),
  imshowpair(fixed, movingRegistered,'Scaling','joint'); 

%  subplot(1,3,1); imshow(fixed);
%  subplot(1,3,2); imshow(movingRegistered);
%  subplot(1,3,3); imshowpair(fixed,movingRegistered,'Scaling', 'joint');
    
%%
%Ejercicio 2

%REGISTRACION BASADA EN LANDMARKS

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

  %Herramienta para establecer landmarks en imï¿½genes
  cpselect(moving, fixed);

  %%
  %Transformacion mediante landmarks
  %Calcular otras transformaciones, cambiando el parametro. Ver opciones usando Help

  mytform = cp2tform(movingPoints, fixedPoints, 'affine'); %'polynomial' 'projective' 'similarity' 'affine'
      %cp2tform - Infer spatial transformation from control point pairs
  registered = imtransform(moving, mytform);

  %Notar que cambio las dimensiones en la imagen registrada
%  figure('Name','Affine');
%  subplot(1,2,1);
%  imshow(moving);
%  subplot(1,2,2);
%  imshow(registered);

  %Correccion de la imagen registrada

  sizeMoving = size(moving);
  sizeRegistered = size(registered);

  diferencia = abs(sizeMoving - sizeRegistered);
  esquinaSupIzq = diferencia / 2;
  esquinaSupIzq = circshift(esquinaSupIzq,[0 -1]);
  rect = horzcat(ceil(esquinaSupIzq), sizeMoving-1);
  corregida = imcrop(registered,rect);

  %Muestra las imagenes
  figure('Name','Transformacion Afin')
  subplot(2,3,1);  imshow(fixed), title('Fixed');
  subplot(2,3,2);  imshow(moving), title('Moving');
  subplot(2,3,3);  imshow(registered), title('Registered');
  subplot(2,3,4); imshowpair(fixed,moving,'Scaling', 'joint'), title('Fixed-Moving');
  subplot(2,3,5); imshowpair(fixed,registered,'Scaling', 'joint'), title('Fixed-registered (sin correccion)');
  subplot(2,3,6); imshowpair(fixed,corregida, 'Scaling', 'joint'), title('Fixed-registered (con correccion)');
