
% -------------------------------------------------------------------------
% Taller de Imagenes Medicas
% Trabajo Practico Nro. 6
% Segmentacion supervisada
% 2019 - Jose Ignacio Orlando
% -------------------------------------------------------------------------

%% Preparamos el ambiente

% Cerramos todas las figuras y limpiamos el ambiente.
close all
clear
clc

% Configuramos VLFeat.
folder=uigetdir
run(strcat(folder,filesep,'vlfeat-0.9.21/toolbox/vl_setup'))
% Definimos la ruta de origen de los datos.
root_data_folder = strcat(folder,filesep,'/Data');

% Nos traemos los nombres de las imagenes de entrenamiento
training_image_filenames = dir(fullfile(root_data_folder, 'training', 'images', '*.jpg'));
training_image_filenames = {training_image_filenames.name};
% Nos traemos los nombres de los archivos con las labels
training_label_filenames = dir(fullfile(root_data_folder, 'training', 'labels', '*.bmp'));
training_label_filenames = {training_label_filenames.name};

% Nos traemos los nombres de las imagenes de validation
validation_image_filenames = dir(fullfile(root_data_folder, 'validation', 'images', '*.jpg'));
validation_image_filenames = {validation_image_filenames.name};
% Nos traemos los nombres de los archivos con las labels
validation_label_filenames = dir(fullfile(root_data_folder, 'validation', 'labels', '*.bmp'));
validation_label_filenames = {validation_label_filenames.name};

% Nos traemos los nombres de las imagenes de test
test_image_filenames = dir(fullfile(root_data_folder, 'test', 'images', '*.jpg'));
test_image_filenames = {test_image_filenames.name};
% Nos traemos los nombres de los archivos con las labels
test_label_filenames = dir(fullfile(root_data_folder, 'test', 'labels', '*.bmp'));
test_label_filenames = {test_label_filenames.name};

fprintf('\nTrabajo Practico Nro. 6 - Segmentacion supervisada\n');

%% Ejercicio 1. Construir la matriz X y la lista de etiquetas a partir de los datos de entrenamiento

fprintf('\nConstruyendo X sobre los datos de training\n');

% Inicializamos la matriz X y la de etiquetas y
X = [];
y = [];

% Por cada una de las imagenes...
for i = 1 : length(training_image_filenames)
    
    % Abrimos la imagen
    I = imread(fullfile(root_data_folder, 'training', 'images', training_image_filenames{i}));
    % Abrimos la mascara con las etiquetas por pixel
    labels = imread(fullfile(root_data_folder, 'training', 'labels', training_label_filenames{i})) > 0;
    
    % Calculamos las features
    current_X = compute_features(I);
    %current_X = compute_features_with_inpainting(I);
    
    % Estimamos su media y desv?o
    mean_ = mean(current_X);
    std_ = std(current_X);
    % Normalizamos las features a partir de estos valores
    current_X = bsxfun(@rdivide, bsxfun(@minus, current_X, mean_), std_);
    
    % Las concatenamos en la matriz X y la de etiquetas
    X = cat(1, X, current_X);
    y = cat(1, y, labels(:));
    
end

% Llevamos las etiquetas a (-1, 1)
y = 2 * y - 1;

fprintf('Matriz X terminada\n');

%% Ejercicio 2. Entrenamos un clasificador.

lambda_exp = 0;
fprintf('\nEntrenando una Support Vector Machine para lambda = 10^%d...\n', lambda_exp);

% Entrenamos la SVM para el valor de lambda dado
[W, bias] = vl_svmtrain(X', y', 10^lambda_exp);

fprintf('Support Vector Machine entrenada\n');

%% Ejercicio 3. Preparamos los datos de una imagen de validacion y los mostramos
fprintf('\nPreparamos la matriz X de una imagen de validacion\n');

% Abrimos la imagen
I = imread(fullfile(root_data_folder, 'validation', 'images', validation_image_filenames{1}));
% Abrimos la mascara con las etiquetas por pixel
labels = imread(fullfile(root_data_folder, 'validation', 'labels', validation_label_filenames{1})) > 0;
    
% Calculamos los indicadores (color)
validation_X = compute_features(I);
%validation_X = compute_features_with_inpainting(I);

% Estimamos la media y el desvio de los indicadores
mean_ = mean(validation_X);
std_ = std(validation_X);
% Normalizamos las intensidades
validation_X = bsxfun(@rdivide, bsxfun(@minus, validation_X, mean_), std_);

%% Ejercicio 4. Graficar diferentes pares de indicadores y analizar

% Graficar los descriptores
scatter_plots(X(:,1), X(:,2), labels);

%% Ejercicio 5. Usamos el modelo sobre la imagen de validacion para ver que obtuvimos

fprintf('\nEvaluando el modelo sobre una imagen de validacion\n');

% Estimamos un likelihood a partir del modelo que aprendimos
scores = validation_X * W + bias;
% Le damos la forma de la imagen que leimos
scores = reshape(scores, [size(I,1) size(I,2)]);

% Mostramos todo por pantalla
mostrar_todo(I, scores, labels);

%% Ejercicio 6. Calcular indicadores de calidad sobre la segmentacion

% Area bajo la curva ROC
auc = curva_roc(labels, scores, true);
fprintf('AUC curva ROC = %d\n', auc);
% Area bajo la curva PR/RE
auc_pr = curva_prre(labels, scores, true);
fprintf('AUC curva PR/RE = %d\n', auc);
% Dice coefficient
dice = dice_coefficient(labels, scores > 0);
fprintf('Dice = %d\n', dice);

%% Ejercicio 7. Entrenamos como se debe!
fprintf('\nArmamos los datos de validacion\n');

% Preparamos los datos de validacion como corresponde
validation_images = cell(size(validation_image_filenames));
validation_labels = cell(size(validation_image_filenames));
validation_features = cell(size(validation_image_filenames));

% Por cada una de las imagenes...
for i = 1 : length(validation_image_filenames)
    fprintf('.');
    
    % Abrimos la imagen
    I = imread(fullfile(root_data_folder, 'validation', 'images', validation_image_filenames{i}));
    % Abrimos la mascara con las etiquetas por pixel
    labels = imread(fullfile(root_data_folder, 'validation', 'labels', validation_label_filenames{i})) > 0;
    
    % Calcular los indicadores (color)
    validation_X = compute_features(I);
    %validation_X = compute_features_with_inpainting(I);
    mean_ = mean(validation_X);
    std_ = std(validation_X);
    % Restamos media y dividimos por el desvio en los datos de
    % entrenamiento
    validation_X = bsxfun(@rdivide, bsxfun(@minus, validation_X, mean_), std_);
    
    % Almacenamos las imagenes
    validation_images{i} = I;
    validation_labels{i} = labels;
    validation_features{i} = validation_X;
    
end
fprintf('\n');


fprintf('\nEntrenamos el modelo para distintos valores de lambda\n');
% Armamos el espacio de busqueda de exponentes
espacio_busqueda = -5:1:5;
% Armamos un vector donde iremos acumulando las calidades y los modelos
calidades = zeros(size(espacio_busqueda));
Ws = cell(size(espacio_busqueda));
Biases = cell(size(espacio_busqueda));

% Por cada valor en el espacio de busqueda
for i = 1 : length(espacio_busqueda)
    % Me quedo con el exponente lambda actual
    lambda_exp = espacio_busqueda(i);
    % Entrenamos la SVM para el valor de lambda dado
    [Ws{i}, Biases{i}] = vl_svmtrain(X', y', 10^lambda_exp);
    
    calidades(i) = 0;
    for j = 1 : length(validation_features)
        % Calculamos los scores sobre la imagen actual de validacion
        scores = validation_features{j} * Ws{i} + Biases{i};
        % Le damos la forma de la imagen que leimos
        scores = reshape(scores, [size(validation_images{j},1) size(validation_images{j},2)]);
        % Calculamos el AUC
        calidades(i) = calidades(i) + curva_roc(validation_labels{j}, scores, false);
    end
    % Y seteamos el promedio
    calidades(i) = calidades(i) / length(validation_features);
    
    fprintf('Lambda = 10^%d. \t\t AUC promedio = %d\n', espacio_busqueda(i), calidades(i));
    
end

% Buscamos el valor optimo
[max_auc, idx] = max(calidades);
fprintf('\nEl mejor modelo es el lambda = 10^%d\n', espacio_busqueda(idx));

%% Ejercicio 8. Evaluamos sobre los datos de test
fprintf('\nEvaluamos sobre los datos de test\n');

% Inicializamos un arreglo en el que ir colocando las calidades
test_calidades = zeros(size(test_image_filenames));
aucs_ = zeros(size(test_image_filenames));
aucs_pr = zeros(size(test_image_filenames));
dices_ = zeros(size(test_image_filenames));

% Por cada una de las imagenes...
for i = 1 : length(test_image_filenames)
    
    % Abrimos la imagen
    I = imread(fullfile(root_data_folder, 'test', 'images', test_image_filenames{i}));
    % Abrimos la mascara con las etiquetas por pixel
    labels = imread(fullfile(root_data_folder, 'test', 'labels', test_label_filenames{i})) > 0;
    
    % Calcular los indicadores (color)
    test_X = compute_features(I);
    %test_X = compute_features_with_inpainting(I);
    
    % Calculamos media y desvio de los indicadores para esta imagen
    mean_ = mean(test_X);
    std_ = std(test_X);
    % Normalizamos todo
    test_X = bsxfun(@rdivide, bsxfun(@minus, test_X, mean_), std_);
    
    % Calculamos los scores
    scores = test_X * Ws{idx} + Biases{idx};
    % Le damos la forma de la imagen que leimos
    scores = reshape(scores, [size(I,1) size(I,2)]);
    
    % Calculamos los indicadores de calidad
    aucs_(i) = curva_roc(labels, scores, false);
    aucs_pr(i) = curva_prre(labels, scores, false);
    dices_(i) = dice_coefficient(labels, scores > 0);
     
    % Nos quedamos con el que queremos para hacer el ajuste
    test_calidades(i) = aucs_(i);
    
    % Mostramos todo por pantalla
    mostrar_todo(I, scores, labels);
    title(['AUC = ', num2str(test_calidades(i))]);
    
end

% Imprimimos por pantalla los resultados finales
fprintf('Evaluacion terminada\n');
fprintf('AUC ROC promedio = %d\n', mean(aucs_));
fprintf('AUC PR/RE promedio = %d\n', mean(aucs_pr));
fprintf('Dice promedio = %d\n\n', mean(dices_));
