function [T] = create_T_matrix(list, size)

% creation of T matrix based on input patterns
len = length(list);
T = zeros(size*size);
for j=1:size*size
    for k=1:size*size
        temp = 0;
        for i=1:len
            if j~=k
                temp = temp + list{i}(j)*list{i}(k);
            end
        end
        if j~=k
           T(j,k) = temp; 
        end
    end
end
    
