function [feat_matrix, feat_hog_matrix, feat_texton_matrix, feat_color_matrix] = ... 
    extract_feature_vectors(img_names, project_path, bbox, ... 
    feat_matrix, feat_hog_matrix, feat_texton_matrix, feat_color_matrix)
    
    for i=1:length(img_names)
        img_name = img_names{i};
        hog = load(fullfile(project_path, 'images', 'processed', 'hog', strcat(img_name(1:11), '_hog.mat')));
        tc = load(fullfile(project_path, 'images', 'processed', 'tc2', strcat(img_name(1:11), '_tc.mat')));
        box = bbox(i,:);
        [feat, feat_c, feat_t, feat_hog] = extract_vectors2(hog, tc, box);
        feat_matrix(i,:) = feat';
        feat_hog_matrix(i, :) = feat_hog';
        feat_texton_matrix(i, :) = feat_t';
        feat_color_matrix(i, :) = feat_c';
    end
end