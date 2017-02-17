clear all; clc;

offsets = [-1 0;-1 1;-1 -1;1 0;1 -1;1 1;0 -1;0 1];

img= [1, 1, 2, 1, 2;
    1, 2, 1, 7, 7;
    2, 1, 5, 8, 1;
    3, 3, 4, 6, 6;
    3, 4, 4, 2, 8];

expectedGLCM = [14, 11, 2, 1, 2, 2, 5, 2;
    11, 4, 2, 2, 1, 2, 3, 1;
    2, 2, 6, 5, 1, 0, 0, 0;
    1, 2, 5, 6, 1, 2, 0, 1;
    2, 1, 1, 1, 0, 1, 1, 1;
    2, 2, 0, 2, 1, 2, 0, 4;
    5, 3, 0, 0, 1, 0, 2, 2;
    2, 1, 0, 1, 1, 4, 2, 0];

[glcmParts, si] = graycomatrix(img, 'Offset', offsets, 'G', []);

sz = size(glcmParts);
thirdDim = sz(3);
concatenated = zeros(thirdDim);

for a = 1:thirdDim
    concatenated = concatenated + glcmParts(:, :, a);
end

if concatenated == expectedGLCM
   fprintf('The resulting GLCM is valid.\n'); 
end
