function train_models()
    project_path = '/Users/burakonal/Desktop/edu/ee-58j/project/';
    % apascal train
    [~, ~, ~, attributes_apascal_train] = read_att_data(fullfile(project_path, 'attribute_data', 'apascal_train.txt'));
    % load feature matrices;
    temp = load(fullfile(pwd, 'features', 'apascal_train'));
    apascal_train = temp.apascal_train;
    temp = load(fullfile(pwd, 'features', 'hog_apascal_train'));
    hog_apascal_train = temp.hog_apascal_train;
    temp = load(fullfile(pwd, 'features', 'texton_apascal_train'));
    texton_apascal_train = temp.texton_apascal_train;
    temp = load(fullfile(pwd, 'features', 'color_apascal_train'));
    color_apascal_train = temp.color_apascal_train;
    for i=1:64
        attribute_train = attributes_apascal_train(:,i)*2-1;
        model_apascal = train(attribute_train, sparse(apascal_train), '-s 6');
%         save(fullfile(pwd, 'models', strcat('model_apascal_', int2str(i))), 'model_apascal');
        model_hog = train(attribute_train, sparse(hog_apascal_train), '-s 6');
%         save(fullfile(pwd, 'models', strcat('model_hog_', int2str(i))), 'model_hog');
        model_texton = train(attribute_train, sparse(texton_apascal_train), '-s 6');
%         save(fullfile(pwd, 'models', strcat('model_texton_', int2str(i))), 'model_texton');
        model_color = train(attribute_train, sparse(color_apascal_train), '-s 6');
%         save(fullfile(pwd, 'models', strcat('model_color_', int2str(i))), 'model_color');
        break
    end
end
