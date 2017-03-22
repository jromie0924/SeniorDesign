% Load data

% Class numbers
% 1 = car
% 2 = firework
% 3 = fish
% 4 = flower

clear all; clc;

carData = getFeatures('data/car/train');
fireworkData = getFeatures('data/firework/train');
fishData = getFeatures('data/fish/train');
flowerData = getFeatures('data/flower/train');

allFeatures = {carData, fireworkData, fishData, flowerData};

[train, classes] = separateData(allFeatures);

svm = fitcecoc(train, classes);

[car, firework, fish, flower] = getTestResults(svm);
allResults = [car; firework; fish; flower];
confusionMat = getConfusionMatrix(allResults);
