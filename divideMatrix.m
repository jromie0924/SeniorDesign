function [blocks] = divideMatrix(greyScaleImg)
   
    BLOCK_DIM_COLS = 10;
    BLOCK_DIM_COLS = 10;
    dims = size(greyScaleImg);
    length_rows = dims(1);
    length_cols = dims(2);
    blocks_index = 1;
    for rows = 1:10:length_rows - 9
        for cols = 1:10:length_cols - 9
            blocks(:, :, blocks_index) = {greyScaleImg(rows:rows+9, cols:cols+9)};
            blocks_index = blocks_index + 1;
        end
    end
end