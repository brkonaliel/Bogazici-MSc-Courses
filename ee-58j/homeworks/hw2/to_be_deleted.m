clc;clear;
data_path = '/Users/burakonal/Desktop/58j/hw3/PIRC2017_03';
image_size = [128, 128];
window_size = [8, 8];
class_names = cell(32,1);
names = dir(data_path);
class_number = 32;
train_number = 50;
% Filterbank
F = makeRFSfilters; 
sz = size(F);
filter_length = sz(3);
data_matrix = zeros(class_number*train_number, image_size(1)*image_size(2)*3*filter_length/(window_size(1)*window_size(2)));
j=1;

for k=1:length(names)
    if names(k).name(1) == '.'
        continue
    end
    class_names{j} = names(k).name;
    j = j+1;
end

for k=1:length(class_names)
    j=0;
    temp_path = strcat(data_path, '/', class_names{k});
    temp_path_rand_vector = strcat(temp_path, '/random_vector.mat');
    random_vector = load(temp_path_rand_vector);
    names = dir(temp_path);
    % train_set(k).name = class_names{k};
    % running over randomly selected images
    for ii=1:length(random_vector.random_vector)
%         temp = zeros(38*128, 128);
        temp = [];
        index = random_vector.random_vector(ii);
        % skip non image files
        if (names(index).name(1)=='.') || (names(index).name(1)=='r')
            continue
        end
        j = j+1;
        I = imread(strcat(temp_path, '/', names(index).name));
        I = imresize(I, image_size);
        % Red channel
        I_channels{1} = I(:,:,1);
        % Green channel
        I_channels{2} = I(:,:,2);
        % Blue channel
        I_channels{3} = I(:,:,3);
        for channel=1:length(I_channels)
            for filter=1:filter_length
            temp = [temp;conv2(I_channels{channel}, F(:,:,filter), 'same')];
            end
        end
        temp(find(temp<0))=0;
        temp = max_windowing(temp, window_size);
        sz = size(temp);
        temp = reshape(temp, [1, sz(1)*sz(2)]);
        data_matrix(k+j,:) = temp;
        if j == 50
            break
        end
    end
end
        
