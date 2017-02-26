% Load data

% Class numbers
% 1 = car
% 2 = flower
% 3 = lighthouse
% 4 = ship

clear all; clc;

carData = getGLCM('data/car/train');
flowerData = getGLCM('data/flower/train');
lighthouseData = getGLCM('data/lighthouse/train');
shipData = getGLCM('data/ship/train');

allFeatures = {carData, flowerData, lighthouseData, shipData};
%allFeatures = {carData, flowerData};

[train, classes] = separateData(allFeatures);

tree = fitcecoc(train, classes);

img = imread('data/car/test/29040.jpg');