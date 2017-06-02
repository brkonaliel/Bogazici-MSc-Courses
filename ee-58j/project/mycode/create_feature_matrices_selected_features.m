function create_feature_matrices_selected_features()
    project_path = '/Users/burakonal/Desktop/edu/ee-58j/project';
    fname = fullfile(project_path, 'attribute_data', 'apascal_train.txt');
    [img_names_apascal_train, img_classes_apascal_train, bbox_apascal_train, ~] = read_att_data(fname);
    fname = fullfile(project_path, 'attribute_data', 'apascal_test.txt');
    [img_names_apascal_test, img_classes_apascal_test, bbox_apascal_test, ~] = read_att_data(fname);
    img_classes = unique(img_classes_apascal_train);
    for i=1:20
        [apascal_train, hog_apascal_train, texton_apascal_train, color_apascal_train] = ... 
            extract_feature_vectors_selected_features(img_names_apascal_train, project_path, ... 
            bbox_apascal_train, img_classes_apascal_train, img_classes(i));
        [apascal_test, hog_apascal_test, texton_apascal_test, color_apascal_test] = ... 
            extract_feature_vectors_selected_features(img_names_apascal_test, project_path, ... 
            bbox_apascal_test, img_classes_apascal_test, img_classes(i));
        
        save(fullfile(pwd, 'selected_features', strcat(char(img_classes(i)), '_apascal_train')), 'apascal_train');
        save(fullfile(pwd, 'selected_features', strcat(char(img_classes(i)), '_hog_apascal_train')), 'hog_apascal_train');
        save(fullfile(pwd, 'selected_features', strcat(char(img_classes(i)), '_texton_apascal_train')), 'texton_apascal_train');
        save(fullfile(pwd, 'selected_features', strcat(char(img_classes(i)), '_color_apascal_train')), 'color_apascal_train');
        save(fullfile(pwd, 'selected_features', strcat(char(img_classes(i)), '_apascal_test')), 'apascal_test');
        save(fullfile(pwd, 'selected_features', strcat(char(img_classes(i)), '_hog_apascal_test')), 'hog_apascal_test');
        save(fullfile(pwd, 'selected_features', strcat(char(img_classes(i)), '_texton_apascal_test')), 'texton_apascal_test');
        save(fullfile(pwd, 'selected_features', strcat(char(img_classes(i)), '_color_apascal_test')), 'color_apascal_test');
    end

end