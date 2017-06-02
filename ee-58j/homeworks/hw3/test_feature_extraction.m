function result = test_feature_extraction(data_path, windowing_size)
%     data_path = '/Users/burakonal/Desktop/edu/58j/hw3/PIRC2017_03';
    image_size = [128 128];
    class_names = cell(32,1);
    names = dir(data_path);
    j=1;
    for ii=1:length(names)
        if names(ii).name(1) == '.'
            continue
        end
        class_names{j} = names(ii).name;
        j = j+1;
    end
    result = [];
    for k=1:length(class_names)
        j=0;
        temp_path = strcat(data_path, '/', class_names{k});
        temp_path_rand_vector = strcat(temp_path, '/random_vector.mat');
        random_vector = load(temp_path_rand_vector);
        names = dir(temp_path);
        % running over randomly selected images
        for ii=1:length(random_vector.random_vector)
            temp = zeros(38*128, 128);
            index = random_vector.random_vector(ii);
            if (names(index).name(1)=='.') || (names(index).name(1)=='r')
                continue
            end
            j = j+1;
            % take only the test images
            if j <= 50
                continue
            end
            I = imread(strcat(temp_path, '/', names(index).name));
            I = imresize(I, image_size);
            % Red channel
            I_channels{1} = I(:,:,1);
            % Green channel
            I_channels{2} = I(:,:,2);
            % Blue channel
            I_channels{3} = I(:,:,3);
            % Filterbank
            F = makeRFSfilters; 
            sz = size(F);
            for channel=1:length(I_channels)
                for filter=1:sz(3)
                    temp((((channel-1)*sz(3)+filter)-1)*128+1:((channel-1)*sz(3)+filter)*128,:) = conv2(I_channels{channel}, F(:,:,filter), 'same');
                end
            end
            % Relu
            temp(find(temp<0))=0;
            % max windowing
            temp = max_windowing(temp, windowing_size);
            sz = size(temp);
            temp = reshape(temp, [1, sz(1)*sz(2)]);
            result = [result; temp];
        end
    end
end