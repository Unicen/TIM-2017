
function mostrar_todo(I, scores, labels)

    % Mostramos todo por pantalla
    figure, subplot(2, 2, 1);
    % Primero la imagen sobre la que probamos
    imshow(I);
    title('Imagen')
    % Luego el mapa de scores
    subplot(2, 2, 2);
    %imshow(scores, []);
    imagesc(scores), axis equal
    title('Scores')
    % Ahora el mapa umbralado (en una SVM, positivo vs negativo)
    subplot(2, 2, 3);
    imshow(scores > 0);
    title('Segmentacion');
    % Y finalmente el ground truth
    subplot(2, 2, 4);
    imshow(labels>0);
    title('Ground truth');

end