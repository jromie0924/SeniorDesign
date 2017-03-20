function [avg_entropy] = calculateAverageEntropy(block_data)
    sizeOfData = size(block_data);
    sizeOfData = sizeOfData(3);
    accumulator = 0;
    for idx = 1:sizeOfData
       currentDataCell = block_data(:,:,idx);
       cellContents = currentDataCell{1};
       cellEntropy = entropy(cellContents);
       accumulator = accumulator + cellEntropy;
    end
    
    avg_entropy = accumulator / sizeOfData;
end