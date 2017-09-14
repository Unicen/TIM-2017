
function X = compute_features_with_inpainting(I)

    % Inicializamos current_X 
    X = zeros(size(I, 1) * size(I, 2), 9);

    % Calculamos las features de color anteriores
    X(:, 1:3) = compute_features(I);
    
    % Obtenemos una segmentaci?n aproximada de los vasos
    soares = Soares2006(I(:,:,2));
    soares = (soares - min(soares(:))) / (max(soares(:)) - min(soares(:)));
    vessel_segm = soares > 0.3;
    
    % Vamos agregando cada banda con los vasos removidos
    for i = 1 : size(I, 3)
        inpainted_band = regionfill(I(:,:,i), vessel_segm);
        X(:,i+3) = inpainted_band(:);
    end
    
    % Calculamos las features de colores anteriores pero sobre la imagen
    % mejorada con CLAHE
    for i = 1 : size(I, 3)
        partial_color_band = adapthisteq(I(:,:,i));
        X(:, i+6) = partial_color_band(:);
    end

end