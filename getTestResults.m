function [car_predictions, firework_predictions, fish_predictions, flower_predictions] = getTestResults(svm)
    carPath = 'data/car/test';
    fireworkPath = 'data/firework/test';
    fishPath = 'data/fish/test';
    flowerPath = 'data/flower/test';
    
    carTest = dir(carPath);
    fireworkTest = dir(fireworkPath);
    fishTest = dir(fishPath);
    flowerTest = dir(flowerPath);
    
    carSize = size(carTest);
    fireworkSize = size(fireworkTest);
    fishSize = size(fishTest);
    flowerSize = size(flowerTest);
    
    % Car
    car_listPos = 1;
    for i = 1:carSize
       imageName = carTest(i).name;
       
       try
          img = imread([carPath '/' imageName]);
          predictedClass = predictClass(img, svm);
          car_predictions(car_listPos) = {predictedClass};
          car_listPos = car_listPos + 1;
       catch MException
           %disp(MException);
           continue
       end
    end
    
    % Firework
    firework_listPos = 1;
    for i = 1:fireworkSize
       imageName = fireworkTest(i).name;
       
       try
          img = imread([fireworkPath '/' imageName]);
          predictedClass = predictClass(img, svm);
          firework_predictions(firework_listPos) = {predictedClass};
          firework_listPos = firework_listPos + 1;
       catch MException
           %disp(MException);
           continue
       end
    end
    
    % Fish
    fish_listPos = 1;
    for i = 1:fishSize
       imageName = fishTest(i).name;
       
       try
          img = imread([fishPath '/' imageName]);
          predictedClass = predictClass(img, svm);
          fish_predictions(fish_listPos) = {predictedClass};
          fish_listPos = fish_listPos + 1;
       catch MException
           %disp(MException);
           continue
       end
    end
    
    % Flower
    flower_listPos = 1;
    for i = 1:flowerSize
       imageName = flowerTest(i).name;
       
       try
          img = imread([flowerPath '/' imageName]);
          predictedClass = predictClass(img, svm);
          flower_predictions(flower_listPos) = {predictedClass};
          flower_listPos = flower_listPos + 1;
       catch MException
           %disp(MException);
           continue
       end
    end
    
end