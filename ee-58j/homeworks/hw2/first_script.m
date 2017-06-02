% [train_set, class_names] = create_train_set('/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02', [128 128], 100);

data_path = '/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02';
image_size = [128 128];
cluster_number = 100;

for k=1:length(class_names)
    temp_path = strcat(data_path, '/', class_names{k});
    temp_path_rand_vector = strcat(temp_path, '/random_vector.mat');
    random_vector = load(temp_path_rand_vector);
    j = 0;
    for i=1:length(random_vector.random_vector)
        index = random_vector.random_vector(i);
        if (names(index).name(1)=='.') || (names(index).name(1)=='r')
            continue
        end
        j = j + 1;
        if j > 20
            I = imread(strcat(temp_path, '/', names(index).name));
            I = imresize(I, image_size);
            I = single(rgb2gray(I));
            [f, d] = vl_sift(I);
            d = d';
            class_names(k).sift_kmeans
            
            
        end
    end
    
end