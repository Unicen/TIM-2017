
function scatter_plots(feature_1, feature_2, labels)

    % Nos quedamos con todas las etiquetas diferentes que haya
    unique_labels = unique(labels(:));
    legends_ = cell(size(unique_labels));
    
    % Las graficamos como puntos en el espacio
    figure;
    hold on
    for i = 1 : length(unique_labels)
        scatter(feature_1(labels==unique_labels(i), :), feature_2(labels==unique_labels(i), :));
        legends_{i} = num2str(unique_labels(i));
    end
    hold off
    
    % Armamos una leyenda
    legend(legends_);
    % Y terminamos de armar la imagen
    box on
    grid on

end