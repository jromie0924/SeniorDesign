function [x] = haralickTextureFeatures(coOcMat, xFeatures)
%Calculates all Haralick Features.
%
% Source:           http://haralick.org/journals/TexturalFeatures.pdf
%
%
% input:            glcm - Co-Occurence-Matrix. see matlab documentation glcm
%                   merkmale (optional) - Feature, which should be
%                   calculated
%
% output:           x - vector with the following features:
%
%               x1  Angular Second Moment (Energy) [checked]
%               x2  Contrast [checked]
%               x3  Correlation [checked]
%               x4  Variance [checked]
%               x5  Inverse Difference Moment (Homogeneity) [checked]
%               x6  Sum Average [checked]
%               x7  Sum Variance [approxemitly (cut out zeros)]
%               x8  Sum Entropy [checked]
%               x9  Entropy [cut out zeros]
%               x10 Difference Variance [approxemitly]
%               x11 Difference Entropy [checked]
%               x12 Information Measure of Correlation I [checked]
%               x13 Information Measure of Correlation II [approxemitly]
%               x14 Maximal Correlation Coefficient [no reference]
%
%
% NOTES:        If x14 Maximal Correlation Coefficient is complex then the
%               magnitude of MCC will be calculate.
%               See the haralick paper to understand the code.
%
% Info:         ver_1.0


% check input
if nargin == 1
    xFeatures = 1 : 14;
end

% initialize x
x = zeros(14,1);

% normalize glcm
coOcMat = coOcMat./sum(coOcMat(:));

%% Some pre-calculation:
% columns and rows
if sum(xFeatures == 2) == 1 | ... % Contrast
        sum(xFeatures == 3) == 1 | ... % Correlation
        sum(xFeatures == 4) == 1 | ... % Variance
        sum(xFeatures == 5) == 1 | ... % Inverse Difference Moment
        sum(xFeatures == 6) == 1 | ... % Sum Average
        sum(xFeatures == 7) == 1 | ... % Sum Variance
        sum(xFeatures == 8) == 1 | ... % Sum Entropy
        sum(xFeatures == 10) == 1 | ...% Difference Variance
        sum(xFeatures == 11) == 1 | ...% Difference Entropy
        sum(xFeatures == 14) == 1 % Maximal Correlation Coefficient
    sizecoOcMat = size(coOcMat);
    [col,row] = meshgrid(1:sizecoOcMat(1),1:sizecoOcMat(2));
end

% average and standarddeviation
if sum(xFeatures == 3) == 1 | ... % correlation
        sum(xFeatures == 10) == 1 % difference variance
    
    
    rowMean =  sum( row(:).*coOcMat(:) );
    colMean = sum( col(:).*coOcMat(:) );
    rowStd = sqrt( sum( (row(:)-rowMean).^2 .* coOcMat(:) ) );
    colStd = sqrt( sum( (col(:)-colMean).^2 .* coOcMat(:) ) );
end

% sum of rows p_y(i) und sum of columns p_x(j)
if sum(xFeatures == 12) == 1 |...% Information Measures of Correlation I
        sum(xFeatures == 13) == 1|... % Information Measures of Correlation II
        sum(xFeatures == 14) == 1 % Maximal Correlation Coefficient
    
    rowCoOcMat = sum(coOcMat,2); %sum of rows p_y(i)
    colCoOcMat = sum(coOcMat); %sum of columns p_x(i)
end

% p_x+y
if sum(xFeatures == 6)==1 |... % Sum Average
        sum(xFeatures == 7)==1 |... % Sum Variance
        sum(xFeatures == 8)==1 % Sum Entropy
    
    start = -(sizecoOcMat(1) -1);
    stop = sizecoOcMat(1) -1;
    
    % Rotate Matrix 90�
    coOcMat90 = rot90(coOcMat);
    
    % Initilisiere p_x+y
    p_XplusY = zeros((2*sizecoOcMat(1))-1,1);
    
    k = 1;
    for index = start : stop
        p_XplusY(k) = sum( diag(coOcMat90,index) );
        k = k + 1;
    end
end

% Initialize  p_x-y
if sum(xFeatures == 10)==1 |... % Difference Variance
        sum(xFeatures == 11)==1 % Difference Entropy
    
    start = 1;
    stop = sizecoOcMat(1)-1;
    
    % Initialize p_XminusY
    p_XminusY = zeros(sizecoOcMat(1),1);
    p_XminusY(1) = sum (diag(coOcMat,0) );
    
    k = 2;
    for index = start : stop
        p_XminusY(k) = sum( [diag(coOcMat,index);
            diag(coOcMat,-index)] );
        k = k + 1;
    end
end


%% Haralick Feature Calculations
for f = xFeatures
    switch f
        case 1 % Energy (Angular Second Moment)
            x(1) = sum( coOcMat(:).^2 );
            
        case 2  % Contrast
            matrix = ( abs(row - col).^2 ) .* coOcMat;
            x(2) = sum( matrix(:) );
            
        case 3  % Correlation
            zaehler = sum ((row(:) - rowMean) .*...
                (col(:) - colMean) .*  coOcMat(:));
            denominator = rowStd * colStd;
            x(3) = zaehler/denominator;
            
        case 4 % Variance
            x(4) = sum( (row(:)-mean(coOcMat(:))).^2 .*coOcMat(:) );
            
        case 5 % Inverse Difference Moment
            x(5) = sum( coOcMat(:) ./ ( 1+ (row(:)-col(:)).^2 ) );
            
        case 6 % Sum Average
            x(6) = sum( (2:(2*sizecoOcMat(1)))' .* p_XplusY );
            
        case 7 % Sum Variance
            x(8) = - sum( p_XplusY(p_XplusY~=0) .* ...
                log(p_XplusY(p_XplusY~=0)) );
            
            x(7) = sum( ((2:(2*sizecoOcMat(1)))' -...
                x(12)).^2 .* p_XplusY  );
            
        case 8 % Sum Entropy
            if ~x(8) % if it is not calculate in case 7
                x(8) = - sum( p_XplusY(p_XplusY~=0) .*...
                    log(p_XplusY(p_XplusY~=0)) );
            end
            
        case 9 % Entropy
            x(9) = - sum( coOcMat(coOcMat~=0) .*...
                log2(coOcMat(coOcMat~=0)) );
            
        case 10 % Difference Variance
            x(10) = sum( ((0:sizecoOcMat(1)-1)' -...
                mean(p_XminusY)).^2 .* p_XminusY);
            
        case 11 % Difference Entropy
            x(11) = - sum( p_XminusY(p_XminusY~=0) .*...
                log(p_XminusY(p_XminusY~=0)) );
            
        case 12 % Information Measures of Correlation I
            if x(12)
                x(9) = - sum( coOcMat(coOcMat~=0) .*...
                    log2(coOcMat(coOcMat~=0)) );
            end
            % Cuto out all zeros:
            logrc  = log2( rowCoOcMat*colCoOcMat ); % 256x1 * 1x256
            %Matrixmultiplication
            logrc(logrc == -Inf) = 0; % cut out Inf
            HXY1 = - sum( coOcMat(:).* logrc(:) ); %product of elements
            % between co-occurence-matrix and the logarithmetic matrix
            numerator = x(9) - HXY1;
            
            % calculate off HX, Entropy of sum of columns
            logc = log2(colCoOcMat);
            logc(logc==-Inf) = 0;
            HX = - sum( colCoOcMat .* logc );
            
            % calculate off HY, Entropy of sum of columns
            logr = log2( rowCoOcMat );
            logr(logr==-Inf) = 0;
            HY = - sum( rowCoOcMat .* logr );
            
            % max value
            denominator = max([HX HY]);
            x(12) = numerator / denominator;
            
        case 13 % Information Measures of Correlation II
            if x(9)
                x(9) = - sum( coOcMat(coOcMat~=0) .*...
                    log2(coOcMat(coOcMat~=0)) );
            end
            logrc  = log2( rowCoOcMat*colCoOcMat ); % 256x1 * 1x256
            %Matrixmultiplication
            logrc(logrc == -Inf) = 0;
            HXY2 = - sum( sum( (rowCoOcMat * colCoOcMat) .* logrc ));
            x(13) =  (  ( 1 - exp(-2*(HXY2 - x(9))) )  ).^(1/2);
            
        case 14 % Maximal Correlation Coefficient
            
            % Initialise Q
            Q = zeros(sizecoOcMat(1),sizecoOcMat(2));
            
            for i = 1 : sizecoOcMat(1)
                Q(i,:) = ( coOcMat(i,:)./rowCoOcMat(i) ) .*...
                    sum( coOcMat(i,:).*colCoOcMat );
            end
            
            % cut out nans
            Q(isnan(Q)) = 0;
            
            eigenvec = eig(Q);
            
            % Find largest eigenvec and delete
            eigenvec(eigenvec==max(eigenvec))=[];
            
            % Sqrt of second largest eigenvec
            x(14) = sqrt( max(eigenvec) );
            
            % calculate magnitude of Maximal Correlation Coefficient
            if imag(x(14))
                x(14) = abs(x(14));
            end
            
    end
end
end