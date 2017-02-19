function [data] = getGLCM(directory)

    %data;
    offsets = [-1 0;-1 1;-1 -1;1 0;1 -1;1 1;0 -1;0 1];

    %category = 'car';
    
    dirInfo = dir(directory);
    dirSize = size(dirInfo);
    
    a = 1;
    for idx = 4 : dirSize(1)
        imgName = dirInfo(idx).name;

        img = imread([directory '/' imgName]);
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
        
        %data(:, :, a) = {concatR concatG concatB};
        data(:, :, a) = {concatR, redFeatures, concatG, greenFeatures, concatB, blueFeatures};
        
        a = a + 1;
        %data = [data; concatR concatG concatB];
    end
    
end