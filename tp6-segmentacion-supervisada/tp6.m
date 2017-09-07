
% Taller de Im?genes M?dicas
% Trabajo Pr?ctico N? 6
% Segmentaci?n supervisada

%% Preparamos el ambiente

clear
clc

% Armamos la ruta para los datos de entrada
root_data_folder = './Data';

% Agregamos las librer?as que necesitamos
addpath(genpath('./RF_Class_C'));

%% Ejercicio 0. Capturar los nombres de los archivos 

% Nos traemos los nombres de las im?genes
image_filenames = dir(fullfile(root_data_folder, 'images', '*.jpg'));
image_filenames = {image_filenames.name};
% Nos traemos los nombres de los archivos con las labels
label_filenames = dir(fullfile(root_data_folder, 'labels', '*.bmp'));
label_filenames = {label_filenames.name};

% Cantidad de im?genes
N = length(image_filenames);

%% Ejercicio 1. Dividir los datos en datos de entrenamiento/test

fprintf('Copiando las im?genes a diferentes directorios\n');

% Inicializamos un cell-array con los nombres de los directorios
folder_names = {'training', 'validation', 'test'};

% Y armamos otro arreglo con las proporciones para cada subset
% Training = 65%
% Validation = 10%
% Test = 25%
proportions = [0.65, 0.1, 0.25];

% Inicializamos una variable donde vamos a ir contando la cantidad de
% im?genes salvadas
already_saved_images = 1;
% Por cada subconjunto...
for i = 1 : length(folder_names)

    % Tomamos el nombre del subconjunto
    subset_name = folder_names{i};
    % Calculamos la cantidad de im?genes que nos vamos a traer
    N_ = round(N * proportions(i));
    % En caso de que nos pasemos, acomodamos ;)
    if (already_saved_images + N_) > N
        N_ = N - already_saved_images;
    end
    
    % Inicializamos los nombres de los directorios donde guardaremos 
    % las im?genes
    output_folder = fullfile(root_data_folder, folder_names{i});
    output_folder_images = fullfile(output_folder, 'images');
    output_folder_labels = fullfile(output_folder, 'labels');
    
    % Creamos los directorios
    mkdir(output_folder);
    mkdir(output_folder_images);
    mkdir(output_folder_labels);
    
    % Copiamos las im?genes y labels...
    for j = already_saved_images : already_saved_images + N_ - 1
        copyfile(fullfile(root_data_folder, 'images', image_filenames{j}), fullfile(output_folder_images, image_filenames{j}));
        copyfile(fullfile(root_data_folder, 'labels', label_filenames{j}), fullfile(output_folder_labels, label_filenames{j}));
    end
    
    % Avanzamos el iterador
    already_saved_images = already_saved_images + N_;
    
end

fprintf('Copia terminada\n');

