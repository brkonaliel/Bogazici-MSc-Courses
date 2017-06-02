function [feat_matrix, feat_hog_matrix, feat_texton_matrix, feat_color_matrix] = ... 
    extract_feature_vectors_selected_features(img_names, project_path, bbox, img_classess, class_name)
    indices = find(strcmp(img_classess, class_name));
    % feature matrices
    feat_matrix = zeros(length(indices), 9688);
    % hog
    feat_hog_matrix = zeros(length(indices), 7000);
    % texton
    feat_texton_matrix = zeros(length(indices), 1792);
    % color
    feat_color_matrix = zeros(length(indices), 896);
    for i=1:length(indices)
        img_name = img_names{indices(i)};
        hog = load(fullfile(project_path, 'images', 'processed', 'hog', strcat(img_name(1:11), '_hog.mat')));
        tc = load(fullfile(project_path, 'images', 'processed', 'tc2', strcat(img_name(1:11), '_tc.mat')));
        box = bbox(indices(i),:);
        [feat, feat_c, feat_t, feat_hog] = extract_vectors2(hog, tc, box);
        feat_matrix(i,:) = feat';
        feat_hog_matrix(i, :) = feat_hog';
        feat_texton_matrix(i, :) = feat_t';
        feat_color_matrix(i, :) = feat_c';
    end
end
