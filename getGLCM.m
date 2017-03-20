function [data] = getGLCM(directory)
    debug = false;
    offsets = [-1 0;-1 1;-1 -1;1 0;1 -1;1 1;0 -1;0 1];

    dirInfo = dir(directory);
    dirSize = size(dirInfo);

    a = 1;
    for idx = 1 : dirSize(1)
        imgName = dirInfo(idx).name;        
        
        try % If the statements inside this try fail, we continue, as it 
            % will be caused by a hidden file automatically-generated
            % by the file system.
            
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
            
            % Populate all features of red channel
            redFeatures = haralickTextureFeatures(concatR);
            redBlocks = divideMatrix(imgR);
            redAvgEntropy = calculateAverageEntropy(redBlocks);
            redFeatures(15) = redAvgEntropy;
            
            % Populate all features of green channel
            greenFeatures = haralickTextureFeatures(concatG);
            greenBlocks = divideMatrix(imgG);
            greenAvgEntropy = calculateAverageEntropy(greenBlocks);
            greenFeatures(15) = greenAvgEntropy;
            
            % Populate all features of blue channel
            blueFeatures = haralickTextureFeatures(concatB);
            blueBlocks = divideMatrix(imgB);
            blueAvgEntropy = calculateAverageEntropy(blueBlocks);
            blueFeatures(15) = blueAvgEntropy;

            data(:, :, a) = {concatR, redFeatures, concatG, greenFeatures, concatB, blueFeatures};

            a = a + 1;
        catch MException
            if debug
                disp(MException);
            end
            continue;
        end
    end

end
