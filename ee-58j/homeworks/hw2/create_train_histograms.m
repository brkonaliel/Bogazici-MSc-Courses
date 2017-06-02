function [train_set, class_names] = create_train_histograms()
    % parameters and variables
    data_path = '/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02';
    image_size = [128 128];
    sift_centers_100 = load('/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02/sift_centers_100.mat');
    sift_centers_500 = load('/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02/sift_centers_500.mat');
    dsift_centers_100 = load('/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02/dsift_centers_100.mat');
    % dsift_centers_500 = load('/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02/dsift_centers_500.mat');
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
    for k=1:length(class_names)
        temp_path = strcat(data_path, '/', class_names{k});
        temp_path_rand_vector = strcat(temp_path, '/random_vector.mat');
        random_vector = load(temp_path_rand_vector);
        train_set(k).name = class_names{k};
        names = dir(temp_path);
        sift_histogram_100 = [];
        sift_histogram_500= [];
        sift_binary_histogram_100 = [];
        sift_binary_histogram_500= [];
        dsift_histogram_100 = [];
        dsift_histogram_500= [];
        dsift_binary_histogram_100 = [];
        dsift_binary_histogram_500= [];
        j=0;
        for ii=1:length(random_vector.random_vector)
            index = random_vector.random_vector(ii);
            if (names(index).name(1)=='.') || (names(index).name(1)=='r')
                continue
            end
            j=j+1;
            I = imread(strcat(temp_path, '/', names(index).name));
            I = imresize(I, image_size);
            I = single(rgb2gray(I));
            [f,d] = vl_sift(I);
            [f_d,d_d] = vl_dsift(I);
            % sift descriptors (histogram and binary histogram) for k=100,500
            [h, h_b] = encoding(d, sift_centers_100.sift_centers, 100);
            sift_histogram_100 = [sift_histogram_100;h];
            sift_binary_histogram_100 = [sift_binary_histogram_100;h_b];
            [h, h_b] = encoding(d, sift_centers_500.sift_centers, 500);
            sift_histogram_500 = [sift_histogram_500;h];
            sift_binary_histogram_500 = [sift_binary_histogram_500;h_b];

            % dsift descriptors (histogram and binary histogram) for k=100,500
            [h, h_b] = encoding(d_d, dsift_centers_100.dsift_centers, 100);
            dsift_histogram_100 = [dsift_histogram_100;h];
            dsift_binary_histogram_100 = [dsift_binary_histogram_100;h_b];
    %         [h, h_b] = encoding(d_d, sift_centers_500.sift_centers, 500);
    %         sift_histogram_500 = [sift_histogram_500;h];
    %         sift_binary_histogram_500 = [sift_binary_histogram_500;h_b];
            if j == 20
                break
            end
        end
        train_set(k).sift_histogram_100 = sift_histogram_100;
        train_set(k).sift_histogram_500 = sift_histogram_500;
        train_set(k).sift_binary_histogram_100 = sift_binary_histogram_100;
        train_set(k).sift_binary_histogram_500 = sift_binary_histogram_500;
        train_set(k).dsift_histogram_100 = dsift_histogram_100;
        train_set(k).dsift_binary_histogram_100 = dsift_binary_histogram_100;
    end
    save('/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02/train_set.mat','train_set');
end