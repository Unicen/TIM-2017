
function [auc, recall, precision] = curva_prre(labels, scores, mostrar)

    [recall, precision, info] = vl_pr(2 * labels(:) - 1, scores(:));
    auc = info.auc;
    % Mostramos la curva ROC en una figura
    if mostrar
        figure, plot(precision, recall, 'LineWidth', 2);
        xlabel('Precision');
        ylabel('Recall');
        legend(['AUC = ', num2str(auc)]);
        grid on
        title('Curva Precision/Recall');
    end

end