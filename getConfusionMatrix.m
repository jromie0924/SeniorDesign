function [confusionMatrix] = getConfusionMatrix(resultsList)
    length = size(resultsList);
    classes = length(1);
    classLength = length(2);
    
    for i = 1:classes
        confusionMatrix(i, 1:4) = 0;
        for j = 1:classLength
            prediction = resultsList(i,j);
            if strcmpi(prediction, 'car')
                confusionMatrix(i, 1) = confusionMatrix(i, 1) + 1;
                    
            elseif strcmpi(prediction, 'firework')
                confusionMatrix(i, 2) = confusionMatrix(i, 2) + 1;
                    
            elseif strcmpi(prediction, 'fish')
                confusionMatrix(i, 3) = confusionMatrix(i, 3) + 1;
                    
            elseif strcmpi(prediction, 'flower')
                confusionMatrix(i, 4) = confusionMatrix(i, 4) + 1;
            end
        end
    end
    
end