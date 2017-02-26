function [trainData features] = separateData(data)
    length = size(data);
    
    for a = 1:length(3)
        glcms = data(:,:,a);
        glcmRed = glcms{1};
        glcmGreen = glcms{3};
        glcmBlue = glcms{5};
        featuresRed = glcms{2};
        featuresGreen = glcms{4};
        featuresBlue = glcms{6};
        
        trainData(:,:,a) = {glcmRed glcmGreen glcmBlue};
        features(:,:,a) = {featuresRed featuresGreen featuresBlue};
    end
end