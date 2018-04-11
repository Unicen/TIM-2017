close all;
fprintf('\n\n Ejercicio 1.c) \n\n');

% Calculo el m�ximo valor de intensidad dentro del cerebro
max_flair = max(flair(mask));
% Calculo el m�nimo valor de intensidad dentro del cerebro
min_flair = min(flair(mask));
% Calculo el valor promedio de intensidad dentro del cerebro
mean_flair = mean(flair(mask));
% Calculo la moda de intensidad dentro del cerebro
mode_flair = mode(flair(mask));
% Muestro los valores por pantalla
fprintf(strcat('Flair: MAX=', num2str(max_flair), ' ; MIN=', num2str(min_flair), ' ; MEAN=', num2str(mean_flair), ' ; MODE=', num2str(mode_flair), '\n'));

%muestro los valores calculados sobre los histograma

figure('name','Histograma de la modalidad FLAIR')
subplot(1,2,1), imshow(flair);
subplot(1,2,2), imhist(flair(mask),256); ylim([0 Ff]); 

l_mean=line([mean_flair,mean_flair],[0 Ff],'Color','Yellow'); 
l_min=line([min_flair,min_flair],[0 Ff],'Color','Green');
l_max=line([max_flair,max_flair],[0 Ff],'Color','Red');
l_mode=line([mode_flair,mode_flair],[0 Ff],'Color','Magenta'); 
legend([l_mean,l_min,l_max,l_mode],'Mean','Min','Max','Mode')


% Calculo el m�ximo valor de intensidad dentro del cerebro
max_t1 = max(t1(mask));
% Calculo el m�nimo valor de intensidad dentro del cerebro
min_t1 = min(t1(mask));
% Calculo el valor promedio de intensidad dentro del cerebro
mean_t1 = mean(t1(mask));
% Calculo la moda de intensidad dentro del cerebro
mode_t1 = mode(t1(mask));
% Muestro los valores por pantalla
fprintf(strcat('T1: MAX=', num2str(max_t1), ' ; MIN=', num2str(min_t1), ' ; MEAN=', num2str(mean_t1), ' ; MODE=', num2str(mode_t1), '\n'));


% Muestro un corte de la imagen y el histograma
figure('name','Histograma de la modalidad T1')
subplot(1,2,1), imshow(t1);
subplot(1,2,2), imhist(t1(mask),256); ylim([0 Ft1]);

l_mean=line([mean_t1,mean_t1],[0 Ft1],'Color','Yellow'); 
l_min=line([min_t1,min_t1],[0 Ft1],'Color','Green');
l_max=line([max_t1,max_t1],[0 Ft1],'Color','Red');
l_mode=line([mode_t1,mode_t1],[0 Ft1],'Color','Magenta'); 
legend([l_mean,l_min,l_max,l_mode],'Mean','Min','Max','Mode')

% Calculo el m�ximo valor de intensidad dentro del cerebro
max_t1c = max(t1c(mask));
% Calculo el m�nimo valor de intensidad dentro del cerebro
min_t1c = min(t1c(mask));
% Calculo el valor promedio de intensidad dentro del cerebro
mean_t1c = mean(t1c(mask));
% Calculo la moda de intensidad dentro del cerebro
mode_t1c = mode(t1c(mask));
% Muestro los valores por pantalla
fprintf(strcat('T1c: MAX=', num2str(max_t1c), ' ; MIN=', num2str(min_t1c), ' ; MEAN=', num2str(mean_t1c), ' ; MODE=', num2str(mode_t1c), '\n'));

% Muestro un corte de la imagen y el histograma
figure('name','Histograma de la modalidad T1 con contraste de gadolinio')
subplot(1,2,1), imshow(t1c);
subplot(1,2,2), imhist(t1c(mask),256); ylim([0 Ft1c]);

l_mean=line([mean_t1c,mean_t1c],[0 Ft1c],'Color','Yellow'); 
l_min=line([min_t1c,min_t1c],[0 Ft1c],'Color','Green');
l_max=line([max_t1c,max_t1c],[0 Ft1c],'Color','Red');
l_mode=line([mode_t1c,mode_t1c],[0 Ft1c],'Color','Magenta'); 
legend([l_mean,l_min,l_max,l_mode],'Mean','Min','Max','Mode')


% Calculo el m�ximo valor de intensidad dentro del cerebro
max_t2 = max(t2(mask));
% Calculo el m�nimo valor de intensidad dentro del cerebro
min_t2 = min(t2(mask));
% Calculo el valor promedio de intensidad dentro del cerebro
mean_t2 = mean(t2(mask));
% Calculo la moda de intensidad dentro del cerebro
mode_t2 = mode(t2(mask));
% Muestro los valores por pantalla
fprintf(strcat('T2: MAX=', num2str(max_t2), ' ; MIN=', num2str(min_t2), ' ; MEAN=', num2str(mean_t2), ' ; MODE=', num2str(mode_t2), '\n'));

% Muestro un corte de la imagen y el histograma
figure('name','Histograma de la modalidad T2')
subplot(1,2,1), imshow(t2);
subplot(1,2,2), imhist(t2(mask),256); ylim([0 Ft2]);
l_mean=line([mean_t2,mean_t2],[0 Ft2],'Color','Yellow'); 
l_min=line([min_t2,min_t2],[0 Ft2],'Color','Green');
l_max=line([max_t2,max_t2],[0 Ft2],'Color','Red');
l_mode=line([mode_t2,mode_t2],[0 Ft2],'Color','Magenta'); 
legend([l_mean,l_min,l_max,l_mode],'Mean','Min','Max','Mode')