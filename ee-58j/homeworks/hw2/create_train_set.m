function [train_set, class_names] = create_train_set(data_path, image_size, cluster_number)
clc;
% parameters
% data_path = '/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02';
% image_size = [128 128];
% cluster_number = 100;
class_names = cell(20,1);
names = dir(data_path);
j=1;
for i=1:length(names)
    if names(i).name(1) == '.'
        continue
    end
    class_names{j} = names(i).name;
    j = j+1;
end
for k=1:length(class_names)
    temp_path = strcat(data_path, '/', class_names{k});
    temp_path_rand_vector = strcat(temp_path, '/random_vector.mat');
    random_vector = load(temp_path_rand_vector);
    train_set(k).name = class_names{k};
    names = dir(temp_path);
    sift_descriptors = [];
    sift_frames= [];
    dsift_descriptors = [];
    dsift_frames = [];
    for i=1:length(random_vector.random_vector)
        index = random_vector.random_vector(i);
        if (names(index).name(1)=='.') || (names(index).name(1)=='r')
            continue
        end
        I = imread(strcat(temp_path, '/', names(index).name));
        I = imresize(I, image_size);
        I = single(rgb2gray(I));
        [f,d] = vl_sift(I);
        d = d';
        sift_descriptors = [sift_descriptors; d];
        temp = size(f);
        sift_frames = [sift_frames, temp(2)];
        [f_d,d_d] = vl_dsift(I);
        d_d = d_d';
        dsift_descriptors = [dsift_descriptors; d_d];
        temp = size(f_d);
        dsift_frames = [dsift_frames, temp(2)];
        if length(sift_frames) == 20
            break
        end
    end    
    [sift_index, sift_kmeans] = kmeans(double(sift_descriptors), cluster_number);
%     [dsift_index, dsift_kmeans] = kmeans(double(dsift_descriptors), cluster_number);
    train_set(k).sift_index = sift_index;
    train_set(k).sift_kmeans = sift_kmeans;
    train_set(k).sift_frames = sift_frames;
    train_set(k).sift_descriptors = sift_descriptors;
%     train_set(k).dsift_index = dsift_index;
%     train_set(k).dsift_kmeans = dsift_kmeans;
%     train_set(k).dsift_frames = dsift_frames;
    train_set(k).dsift_descriptors = dsift_descriptors;

    % re-iterating over the images for histogram and binary encoding
    last_point = 0;
    sift_histogram = [];
    sift_binary_histogram = [];
    dsift_histogram = [];
    dsift_binary_histogram = [];
    for i=1:length(sift_frames)
        temp = zeros(1, cluster_number);
        logic_vector = ones(1, cluster_number);
        if i == 1
           temp_index = sift_index(1:sift_frames(1));
        else
           temp_index = sift_index(last_point:last_point+sift_frames(i));
        end
       for j=1:length(temp_index)
          temp(temp_index(j)) = temp(temp_index(j))+1; 
       end
       temp_binary = double(temp&logic_vector);
       sift_histogram = [sift_histogram; temp];
       sift_binary_histogram = [sift_binary_histogram; temp_binary];
%        dsift_histogram = [dsift_histogram; temp];
%        dsift_binary_histogram = [dsift_binary_histogram; temp_binary];
       last_point = sift_frames(1)+1;
    end
    train_set(k).sift_histogram = sift_histogram;
    train_set(k).sift_binary_histogram = sift_binary_histogram;
end
end