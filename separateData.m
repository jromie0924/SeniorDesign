function [features, classes] = separateData(allData)
    counter = 1;
    length = size(allData);
    for a = 1:length(2)
        data = allData(a);
        data = data{1};
        currentLength = size(data);
        for b = 1:currentLength(3)
            featureData = data(:,:,b);
            featuresRed = featureData{2};
            featuresGreen = featureData{4};
            featuresBlue = featureData{6};
            
            allFeatures = horzcat(featuresRed.', featuresGreen.', featuresBlue.');
            features(counter,:) = allFeatures;
            
            classes(counter) = a;
            counter = counter + 1;
        end
    end
end