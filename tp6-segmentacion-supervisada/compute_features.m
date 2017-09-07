
function X = compute_features(I)

    % Inicializamos current_X 
    X = zeros(size(I, 1) * size(I, 2), 3);

    % Por cada banda de color
    for j = 1 : size(I, 3)
        % Nos quedamos con la banda
        current_band = I(:,:,j);
        % Lo colocamos en current_X
        X(:, j) = current_band(:);
    end

end