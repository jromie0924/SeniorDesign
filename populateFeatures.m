function [redFeatures, greenFeatures, blueFeatures] = populateFeatures(imgR, concatR, imgG, concatG, imgB, concatB)
    % Populate all features of red channel
    redFeatures = haralickTextureFeatures(concatR);
    redBlocks = divideMatrix(imgR);
    redAvgEntropies = calculateAverageEntropy(redBlocks);
    redAvgSize = size(redAvgEntropies);
    index_counter = 15;
    idx = 1;
    for i = index_counter:index_counter + redAvgSize(2) - 1
        redFeatures(i) = redAvgEntropies(idx);
        idx = idx + 1;
    end

    % Populate all features of green channel
    greenFeatures = haralickTextureFeatures(concatG);
    greenBlocks = divideMatrix(imgG);
    greenAvgEntropies = calculateAverageEntropy(greenBlocks);
    greenAvgSize = size(greenAvgEntropies);
    index_counter = 15;
    idx = 1;
    for i = index_counter:index_counter + greenAvgSize(2) - 1
        greenFeatures(i) = greenAvgEntropies(idx);
        idx = idx + 1;
    end

    % Populate all features of blue channel
    blueFeatures = haralickTextureFeatures(concatB);
    blueBlocks = divideMatrix(imgB);
    blueAvgEntropies = calculateAverageEntropy(blueBlocks);
    blueAvgSize = size(blueAvgEntropies);
    index_counter = 15;
    idx = 1;
    for i = index_counter:index_counter + blueAvgSize(2) - 1
        blueFeatures(i) = blueAvgEntropies(idx);
        idx = idx + 1;
    end
end