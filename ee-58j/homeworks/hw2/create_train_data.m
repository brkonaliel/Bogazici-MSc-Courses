clc;clear;
data_path = '/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02';
image_size = [128 128];
class_names = cell(20,1);
names = dir(data_path);
j=1;
for ii=1:length(names)
    if names(ii).name(1) == '.' || length(names(ii).name) > 4
        continue
    end
    class_names{j} = names(ii).name;
    j = j+1;
end
% running over the classes
% there are 20217 sift frames and 2560000 dsift frames in the training data.
% this is pre-calculated to speed up the procedure.
sift_descriptors = ones(image_size(1), 20217);
sift_frames= ones(4, 20217);
dsift_descriptors = ones(image_size(1), 2560000);
dsift_frames = ones(2, 2560000);
frame = 0;
frame_d = 0;
for k=1:length(class_names)
    j=0;
    temp_path = strcat(data_path, '/', class_names{k});
    temp_path_rand_vector = strcat(temp_path, '/random_vector.mat');
    random_vector = load(temp_path_rand_vector);
    names = dir(temp_path);
    % running over randomly selected images
    for ii=1:length(random_vector.random_vector)
        index = random_vector.random_vector(ii);
        if (names(index).name(1)=='.') || (names(index).name(1)=='r')
            continue
        end
        j = j+1;
        I = imread(strcat(temp_path, '/', names(index).name));
        I = imresize(I, image_size);
        I = single(rgb2gray(I));
        [f,d] = vl_sift(I);
        [f_d,d_d] = vl_dsift(I, 'size', 16);
        temp = size(d);
        temp_d = size(d_d);
        if k+j == 2
           sift_descriptors(:,1:temp(2)) = d;
           sift_frames(:,1:temp(2)) = f;
           dsift_descriptors(:,1:temp_d(2)) = d_d;
           dsift_frames(:,1:temp_d(2)) = f_d;
        else
           sift_descriptors(:,frame+1:frame+temp(2)) = d;
           sift_frames(:,frame+1:frame+temp(2)) = f;
           dsift_descriptors(:,frame_d+1:frame_d+temp_d(2)) = d_d;
           dsift_frames(:,frame_d+1:frame_d+temp_d(2)) = f_d;
        end
%         sift_descriptors = [sift_descriptors, d];
%         dsift_descriptors = [dsift_descriptors, d_d];
%         temp = size(f);
%         sift_frames = [sift_frames, temp(2)];
%         temp = size(f_d);
%         dsift_frames = [dsift_frames, temp(2)];
        frame = frame+temp(2);
        frame_d = frame_d+temp_d(2);
        if j == 20
            break
        end
    end
end

% saving descriptors
% save('/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02/sift_descriptors.mat', 'sift_descriptors');
% save('/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02/sift_frames.mat', 'sift_frames');
% save('/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02/dsift_descriptors.mat', 'dsift_descriptors');
% save('/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02/dsift_frames.mat', 'dsift_frames');

% kmeans of all the train data
for numClusters = 500:400:500
    [sift_centers, ~] = vl_kmeans(double(sift_descriptors), numClusters);
    disp('sift done');
    [dsift_centers, ~] = vl_kmeans(double(dsift_descriptors), numClusters);
    disp('dsift done');
    save(char(strcat('/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02/sift_centers_',string(numClusters), '.mat')), 'sift_centers');
    save(char(strcat('/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02/dsift_centers_',string(numClusters), '_', string(16), '.mat')), 'dsift_centers');
end