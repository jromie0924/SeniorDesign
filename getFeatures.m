function [data] = getFeatures(directory)
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
            
            [redFeatures, greenFeatures, blueFeatures] = populateFeatures(imgR, concatR, imgG, concatG, imgB, concatB);

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
