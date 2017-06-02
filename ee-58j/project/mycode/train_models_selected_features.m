% function train_models_selected_features()
    project_path = '/Users/burakonal/Desktop/edu/ee-58j/project/';
    % apascal train
    [~, img_classes_apascal_train, ~, attributes_apascal_train] = read_att_data(fullfile(project_path, 'attribute_data', 'apascal_train.txt'));
    img_classes = unique(img_classes_apascal_train);
    for i=1:64
%         model_apascal_weights = zeros(20, 9688);
%         model_hog_weights = zeros(20, 7000);
%         model_texton_weights  = zeros(20, 1792);
%         model_color_weights  = zeros(20, 896);
        model_apascal_weights = [];
        model_hog_weights = [];
        model_texton_weights  = [];
        model_color_weights  = [];
        for j=1:length(img_classes)
            class_name = img_classes(j);
            indices = strcmp(img_classes_apascal_train, class_name);
            attribute_train = attributes_apascal_train(indices, i)*2-1;
            % load feature matrices;
            temp = load(fullfile(pwd, 'class_features', strcat(char(class_name), '_apascal_train')));
            apascal_train = temp.apascal_train;
            temp = load(fullfile(pwd, 'class_features', strcat(char(class_name), '_hog_apascal_train')));
            hog_apascal_train = temp.hog_apascal_train;
            temp = load(fullfile(pwd, 'class_features', strcat(char(class_name), '_texton_apascal_train')));
            texton_apascal_train = temp.texton_apascal_train;
            temp = load(fullfile(pwd, 'class_features', strcat(char(class_name), '_color_apascal_train')));
            color_apascal_train = temp.color_apascal_train;
            model_apascal = train(attribute_train, sparse(apascal_train), '-s 6');
            model_hog = train(attribute_train, sparse(hog_apascal_train), '-s 6');
            model_texton = train(attribute_train, sparse(texton_apascal_train), '-s 6');
            model_color = train(attribute_train, sparse(color_apascal_train), '-s 6');
%             model_apascal_weights(j,:) = model_apascal.w;
%             model_hog_weights(j,:) = model_hog.w;
%             model_texton_weights(j,:) = model_texton.w;
%             model_color_weights(j,:) = model_color.w;
            model_apascal_weights = [model_apascal_weights, find(model_apascal.w)];
            model_hog_weights = [model_hog_weights, find(model_hog.w)];
            model_texton_weights = [model_texton_weights, find(model_texton.w)];
            model_color_weights = [model_color_weights, find(model_color.w)];
        end
        temp = load(fullfile(pwd, 'features', 'apascal_train'));
        apascal_train = temp.apascal_train;
        temp = load(fullfile(pwd, 'features', 'hog_apascal_train'));
        hog_apascal_train = temp.hog_apascal_train;
        temp = load(fullfile(pwd, 'features', 'texton_apascal_train'));
        texton_apascal_train = temp.texton_apascal_train;
        temp = load(fullfile(pwd, 'features', 'color_apascal_train'));
        color_apascal_train = temp.color_apascal_train;
        attribute_train = attributes_apascal_train(:, i)*2-1;
        
        uniqued = unique(model_apascal_weights);
        save(fullfile(pwd, 'selected_features', strcat('model_apascal_', int2str(i))), 'uniqued');
        model = train(attribute_train, sparse(apascal_train(:, uniqued)));
        save(fullfile(pwd, 'models_selected_features', strcat('model_apascal_', int2str(i))), 'model');
        uniqued = unique(sort(model_hog_weights));
        save(fullfile(pwd, 'selected_features', strcat('model_hog_', int2str(i))), 'uniqued');
        model = train(attribute_train, sparse(hog_apascal_train(:, uniqued)));
        save(fullfile(pwd, 'models_selected_features', strcat('model_hog_', int2str(i))), 'model');
        uniqued = unique(sort(model_texton_weights));
        save(fullfile(pwd, 'selected_features', strcat('model_texton_', int2str(i))), 'uniqued');
        model = train(attribute_train, sparse(texton_apascal_train(:, uniqued)));
        save(fullfile(pwd, 'models_selected_features', strcat('model_texton_', int2str(i))), 'model');
        uniqued = unique(sort(model_color_weights));
        save(fullfile(pwd, 'selected_features', strcat('model_color_', int2str(i))), 'uniqued');
        model = train(attribute_train, sparse(color_apascal_train(:, uniqued)));
        save(fullfile(pwd, 'models_selected_features', strcat('model_color_', int2str(i))), 'model');
%         return
    end
% end
