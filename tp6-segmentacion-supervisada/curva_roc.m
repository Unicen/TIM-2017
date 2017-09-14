
function [auc, tpr, fpr] = curva_roc(labels, scores, mostrar)

    [tpr, tnr, info] = vl_roc(2 * labels(:) - 1, scores(:));
    fpr = 1-tnr;
    auc = info.auc;
    % Mostramos la curva ROC en una figura
    if mostrar
        figure, plot(fpr, tpr, 'LineWidth', 2);
        xlabel('1 - Specificity');
        ylabel('Sensitivity');
        legend(['AUC = ', num2str(auc)]);
        grid on
        title('Curva ROC');
    end

end