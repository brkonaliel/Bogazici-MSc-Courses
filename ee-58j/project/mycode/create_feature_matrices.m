function create_feature_matrices()
    project_path = '/Users/burakonal/Desktop/edu/ee-58j/project';
    fname = fullfile(project_path, 'attribute_data', 'apascal_train.txt');
    [img_names_apascal_train, ~, bbox_apascal_train, ~] = read_att_data(fname);
    fname = fullfile(project_path, 'attribute_data', 'apascal_test.txt');
    [img_names_apascal_test, ~, bbox_apascal_test, ~] = read_att_data(fname);
    
    % feature matrices
    apascal_train = zeros(length(img_names_apascal_train), 9688);
    apascal_test = zeros(length(img_names_apascal_test), 9688);
    
    % hog
    hog_apascal_train = zeros(length(img_names_apascal_train), 7000);
    hog_apascal_test = zeros(length(img_names_apascal_test), 7000);
    
    % texton
    texton_apascal_train = zeros(length(img_names_apascal_train), 1792);
    texton_apascal_test = zeros(length(img_names_apascal_test), 1792);
    
    % color
    color_apascal_train = zeros(length(img_names_apascal_train), 896);
    color_apascal_test = zeros(length(img_names_apascal_test), 896);

    [apascal_train, hog_apascal_train, texton_apascal_train, color_apascal_train] = ... 
        extract_feature_vectors(img_names_apascal_train, project_path, ... 
        bbox_apascal_train, apascal_train, hog_apascal_train, ... 
        texton_apascal_train, color_apascal_train);
    [apascal_test, hog_apascal_test, texton_apascal_test, color_apascal_test] = ... 
        extract_feature_vectors(img_names_apascal_test, project_path, ... 
        bbox_apascal_test, apascal_test, hog_apascal_test, ... 
        texton_apascal_test, color_apascal_test);

%     save(fullfile(pwd, 'features', 'apascal_train'), 'apascal_train');
%     save(fullfile(pwd, 'features', 'hog_apascal_train'), 'hog_apascal_train');
%     save(fullfile(pwd, 'features', 'texton_apascal_train'), 'texton_apascal_train');
%     save(fullfile(pwd, 'features', 'color_apascal_train'), 'color_apascal_train');
%     save(fullfile(pwd, 'features', 'apascal_test'), 'apascal_test');
%     save(fullfile(pwd, 'features', 'hog_apascal_test'), 'hog_apascal_test');
%     save(fullfile(pwd, 'features', 'texton_apascal_test'), 'texton_apascal_test');
%     save(fullfile(pwd, 'features', 'color_apascal_test'), 'color_apascal_test');
end