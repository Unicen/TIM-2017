
%% Ejercicio 2.a) Bordes.
% Estudiar las caracter�sticas de los bordes de los vasos sangu�neos en 
% algunos sectores de la imagen de fondo de ojo. �A cu�l de los bordes que 
% vimos anteriormente se parece m�s?

Inorm = (I - min(I(:))) / (max(I(:)) - min(I(:)));
figure('name','Seleccion� el perfil de intensidades de un vaso y puls� doble clic');
imshow(Inorm);
improfile