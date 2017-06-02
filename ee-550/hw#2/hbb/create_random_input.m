function [sample_matrix] = create_random_input(size, features)
sample_matrix = zeros(size,4);
for i=1:size/2
    for j=1:features
        sample_matrix(i,j) = 5*rand;
    end
    sample_matrix(i,features+1) = 1;
end
for i=size/2+1:size
    for j=1:features
        sample_matrix(i,j) = 5*(rand-1);
    end
    sample_matrix(i,features+1) = 0;
end
% shuffling the rows of the resulting matrix
sample_matrix = sample_matrix(randsample(1:length(sample_matrix),length(sample_matrix)),:);
end
