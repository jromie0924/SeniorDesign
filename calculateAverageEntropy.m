function [avg_entropy_list] = calculateAverageEntropy(block_data)
    sizeOfData = size(block_data);
    sizeOfData = sizeOfData(3);
    accumulator = [];
    
    for idx = 1:sizeOfData
       currentDataCell = block_data(:,:,idx);
       cellContents = currentDataCell{1};
       cellEntropy = entropy(cellContents);
       accumulator(idx) = cellEntropy;
    end
    
    index_count = 1;
    for a = 1:sizeOfData - 3
        avg_entropy_list(index_count) = sum(accumulator(a : a + 3));
        index_count = index_count + 1;
    end
end