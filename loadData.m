% Load data

% Class numbers
% 1 = car
% 2 = firework
% 3 = fish
% 4 = flower

clear all; clc;

carData = getGLCM('data/car/train');
fireworkData = getGLCM('data/firework/train');
fishData = getGLCM('data/fish/train');
flowerData = getGLCM('data/flower/train');

allFeatures = {carData, fireworkData, fishData, flowerData};

[train, classes] = separateData(allFeatures);

svm = fitcecoc(train, classes);