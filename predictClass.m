function [class, status, commandOut] = predictClass(img, model)

    offsets = [-1 0;-1 1;-1 -1;1 0;1 -1;1 1;0 -1;0 1];
    imgR = img(:, :, 1);
    imgG = img(:, :, 2);
    imgB = img(:, :, 3);
   
    [glcmR, ~] = graycomatrix(imgR, 'Offset', offsets, 'G', [], 'NumLevels', 8);
    [glcmG, ~] = graycomatrix(imgG, 'Offset', offsets, 'G', [], 'NumLevels', 8);
    [glcmB, ~] = graycomatrix(imgB, 'Offset', offsets, 'G', [], 'NumLevels', 8);
    
    sz = size(glcmR);
    thirdDim = sz(3);
    concatR = zeros(thirdDim);
    concatG = zeros(thirdDim);
    concatB = zeros(thirdDim);

    for i = 1 : thirdDim
       concatR = concatR + glcmR(:, :, i);
       concatG = concatG + glcmG(:, :, i);
       concatB = concatB + glcmB(:, :, i);
    end

    redFeatures = haralickTextureFeatures(concatR);
    greenFeatures = haralickTextureFeatures(concatG);
    blueFeatures = haralickTextureFeatures(concatB);
    
    allFeatures = horzcat(redFeatures.', greenFeatures.', blueFeatures.');
    
    val = model.predict(allFeatures);
    
    switch val
        case 1
            class = 'car';
            
        case 2
            class = 'flower';
            
        case 3
            class = 'lighthouse';
            
        case 4
            class = 'ship';
    end
end