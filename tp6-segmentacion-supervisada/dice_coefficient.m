
function dice = dice_coefficient(labels, predicted)

    labels = logical(labels);
    predicted = logical(predicted);
    
    intersection = length(find(labels .* predicted));
    sum_ = length(find(labels)) + length(find(predicted));
    
    dice = 2 * intersection / sum_;

end