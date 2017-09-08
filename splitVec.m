function [subVec,subIndex] = splitVec(vec)

% Kacper Grzedzinski
% 06/09/2017

% Finds the largest subvector within a vector vec that contains consecutive
% elements that are not NaNs.

% If multiple sub-vectors have the same length then the firs largest
% sub-vector within is assigned to subVec.

% If vec is:
% [NaN 1 NaN 2 4 3 NaN 12 10 9];

% subVec is then:
% [2 4 3];

% Ouputs
% subVec - Largest sub-vector with consecutive non-NaN elemetns
% subIndex - Vector of indicies from original vec vector

% Inputs
% vec - Vector to be split into sub-vector

%% Function constants

% Counter for number of elements within sub-vector
count = 0;

% Pre-allocating values for pairs of indices
% (startIndex,endIndex,numElements)

indexPairs = zeros(length(vec),3);

% First and second column indicate the start and end index of sub-vector in
% vec
% Third column used for counting number of elements in sub-vector

%% Input Checks

if all(isnan(vec))
    
    error('Cannot extract sub-vector from a vector of NaNs')
    
end

%% Assembling indexPairs Array

for i = 1:length(vec)
    
    % First sub-vector encounter
    
    if ~isnan(vec(i)) && count == 0
        
        count = count + 1;
        
        indexPairs(i,1) = i;
        
        j = i; % Storing sub-vector initial index
        
    % Iterating through encountered sub-vector
    
    elseif ~isnan(vec(i)) && count ~= 0
    
        count = count + 1;
        
        % If last element of vector, then it must also be the end of
        % sub-vector
        
        if i == length(vec)
            
            indexPairs(j,2) = i;
            indexPairs(j,3) = count;
            
        end
        
    % End of sub-vector
    
    elseif isnan(vec(i)) && count ~= 0
    
        indexPairs(j,2) = i-1;
        indexPairs(j,3) = count;
        count = 0;
        j = 0;
        
    % No sub-vector
    
    else 
       
        count = 0;    

    end
    
end

%% Finding largest sub-vector within vec

% Position of first largest vector obtained
[~,rowSelect] = max(indexPairs(:,3));

% Extract subVector
subIndex = indexPairs(rowSelect,1):indexPairs(rowSelect,2);
subVec = vec(subIndex);

end
