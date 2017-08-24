%%
%UMBRALADO
%EJERCICIO 1
%Umbralado
I = imread('frame_01_0004_003.png');
I = I(:,:,1);
GT = imread('frame_01_0004_003_GT.png');

%Preprocesamiento - Probar con y sin preprocesamiento
sigma = 3;
h = fspecial('gaussian',ceil(3*sigma)+1,sigma);
I = imfilter(I,h);

%Probar varios umbrales
level = 20; %80 100
BW1 = I>level;
figure('Name','Umbralado1');
subplot(1,2,1); imshow(BW1);
subplot(1,2,2); imshow(GT);

%%
%EJERCICIO 2
%OTSU'S
I = imread('frame_01_0004_003.png');
I = I(:,:,1);
GT = imread('frame_01_0004_003_GT.png');

level = graythresh(I)
BW = im2bw(I,level);
figure('Name','Otsu Method');
subplot(1,2,1); imshow(BW);
subplot(1,2,2); imshow(GT);

%%

%EJERCICIO 3
%Region growing 
clear all;
clc;

Iorig = im2double(imread('medtest.png')); %Imagen
I = Iorig;
x=198; y=359; %Semilla

%Preprocesamiento - Probar con y sin preprocesamiento
% sigma = 4;
% h = fspecial('gaussian',2*ceil(3*sigma)+1,sigma);
% I = imfilter(Iorig,h);

%Variar distancia
distanciaIntensidad = 0.1; %0.1 0.2
J = regiongrowing(I,x,y,distanciaIntensidad); %Método

%Mostrar resultados
figure('Name','Region Growing');
subplot(1,3,1); imshow(Iorig);
subplot(1,3,2); imshow(J);
subplot(1,3,3); 
Irgb(:,:,1)=I;
Irgb(:,:,2)=I;
Irgb(:,:,3)=I+J;
imshow(Irgb,[]);

%%
%EJERCICIO 4
%Region growing

clear all;
clc;

Iorig = im2double(imread('frame_01_0004_003.png')); %Imagen
GT = imread('frame_01_0004_003_GT.png');
I = Iorig(:,:,1);
x=207; y=176; %Semilla

%Preprocesamiento - Probar con y sin preprocesamiento
sigma = 3;
h = fspecial('gaussian',ceil(3*sigma)+1,sigma);
I = imfilter(I,h);

%Variar distancia
distanciaIntensidad = 0.1; %0.01 0.1
J = regiongrowing(I,x,y,distanciaIntensidad); %Método

%Mostrar resultados
figure('Name','Region Growing');
subplot(2,2,1); imshow(Iorig);
subplot(2,2,2); imshow(GT);
subplot(2,2,3); imshow(J);
subplot(2,2,4); 
Irgb(:,:,1)=I;
Irgb(:,:,2)=I;
Irgb(:,:,3)=I+J;
imshow(Irgb,[]);

%%
%EJERCICIO 2
%Snakes

clear all;
clc;

I = im2double(imread('frame_01_0004_003.png')); %Imagen
I = I(:,:,1);
GT = imread('frame_01_0004_003_GT.png');

y=[134 192 240 243 199];
x=[160 121 122 189 216];
P=[x(:) y(:)];

% Opciones
Options=struct;
Options.Verbose=true;

%Variar un solo valor a la vez
Options.Alpha = 0.2; %2.0
Options.Beta = 0.2; %0.2
Options.Kappa = 6; %0.2 %Fuerza externa

Options.Iterations=350;
[O,J]=Snake2D(I,P,Options);

% Show the result
figure('Name','Snakes');
subplot(2,2,1); imshow(I);
subplot(2,2,2); imshow(GT);
subplot(2,2,3); imshow(J);
Irgb(:,:,1)=I;
Irgb(:,:,2)=I;
Irgb(:,:,3)=I+J;
subplot(2,2,4); imshow(I);
hold on;
plot([O(:,2);O(1,2)],[O(:,1);O(1,1)],'g');
hold off;
