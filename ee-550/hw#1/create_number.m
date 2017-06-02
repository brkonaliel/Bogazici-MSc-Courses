function [result_matrix, result_vector] = create_number(number, size)
% Takes number and size of the matrix as input, returns sizexsize matrix 
% and a size*sizex1 vector with 1 and 0 depending on the shape of the digit. 
raw = ones(size)*-1;

if number == 0
    raw(:,1) = 1;
    raw(:,size) = 1;
    raw(1,:) = 1;
    raw(size,:) = 1;
elseif number == 1
    raw(:,ceil(size/2)) = 1;

elseif number == 2
    raw(1,:) = 1;
    raw(size,:) = 1;
    raw(1:ceil(size/2),size) = 1;
    raw(ceil(size/2):size,1) = 1;
    raw(ceil(size/2),:) = 1;
elseif number == 3
    raw(size,:) = 1;
    raw(ceil(size/2),:) = 1;
    raw(1,:) = 1;
    raw(:,size) = 1;
elseif number == 4
    raw(:,size) = 1;
    raw(ceil(size/2)-1,:) = 1;
    raw(1:ceil(size/2)-1,1) = 1;
elseif number == 5
    raw = fliplr(create_number(2, size));
elseif number == 6
    raw(:,1) = 1;
    raw(1,:) = 1;
    raw(size,:) = 1;
    raw(ceil(size/2),:) = 1;
    raw(ceil(size/2):size,size) = 1;
elseif number == 7
    raw(1,3:6) = 1;
    raw(:,6) = 1;
    raw(4,4:7) = 1;
elseif number == 8
    raw = create_number(0, size);
    raw(ceil(size/2+1),:) = 1;
elseif number == 9
    raw = fliplr(flipud(create_number(6, size)));
end
result_matrix = raw;
result_vector = reshape(result_matrix,[size*size,1]);