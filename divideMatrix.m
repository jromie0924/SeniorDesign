function [blocks] = divideMatrix(greyScaleImg)
   
    DIM = 20;
    dims = size(greyScaleImg);
    length_rows = dims(1);
    length_cols = dims(2);
    blocks_index = 1;
    for rows = 1:DIM:length_rows - (DIM - 1)
        for cols = 1:DIM:length_cols - (DIM - 1)
            blocks(:, :, blocks_index) = {greyScaleImg(rows:rows+(DIM - 1), cols:cols+(DIM - 1))};
            blocks_index = blocks_index + 1;
        end
    end
end