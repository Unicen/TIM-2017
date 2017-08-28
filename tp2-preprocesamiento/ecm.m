function [ error ] = ecm( imgorig, img )

    squaredif = (img - imgorig).^2;
    error = sqrt(sum(squaredif(:)) / numel(img));
    
end

