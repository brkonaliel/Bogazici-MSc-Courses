function make_predictions()    
    project_path = '/Users/burakonal/Desktop/edu/ee-58j/project/';
    attribute_names = importdata(fullfile(project_path, 'attribute_data', 'attribute_names.txt'));
    % test features
    temp = load(fullfile(pwd, 'features', 'apascal_test'));
    apascal_test = temp.apascal_test;
    temp = load(fullfile(pwd, 'features', 'hog_apascal_test'));
    hog_apascal_test = temp.hog_apascal_test;
    temp = load(fullfile(pwd, 'features', 'texton_apascal_test'));
    texton_apascal_test = temp.texton_apascal_test;
    temp = load(fullfile(pwd, 'features', 'color_apascal_test'));
    color_apascal_test = temp.color_apascal_test;
    % test labels
    [img_names_apascal_test, img_classes_apascal_test, bbox_apascal_test, attributes_apascal_test] = read_att_data(fullfile(project_path, 'attribute_data', 'apascal_test.txt'));
%     [img_names_ayahoo_test, img_classes_ayahoo_test, bbox_ayahoo_test, attributes_ayahoo_test] = read_att_data(fullfile(project_path, 'attribute_data', 'ayahoo_test.txt'));
    early_fusion_labels = zeros(length(img_names_apascal_test), 64);
    late_fusion_labels = zeros(length(img_names_apascal_test), 64);
    hog_labels = zeros(length(img_names_apascal_test), 64);
    texton_labels = zeros(length(img_names_apascal_test), 64);
    color_labels = zeros(length(img_names_apascal_test), 64);
    n = length(img_names_apascal_test);
    
    % accuracy
    accuracy_early_fusion = zeros(1,64);
    accuracy_hog = zeros(1,64);
    accuracy_texton = zeros(1,64);
    accuracy_color = zeros(1,64);
    accuracy_late_fusion = zeros(1,64);
    
    % roc
    roc_early_fusion = zeros(1,64);
    roc_hog = zeros(1,64);
    roc_texton = zeros(1,64);
    roc_color = zeros(1,64);
    roc_late_fusion = zeros(1,64);

    for i=1:64
        % load trained models
        temp = load(fullfile(pwd, 'models', strcat('model_apascal_', int2str(i))));
        model_apascal = temp.model_apascal;
        temp = load(fullfile(pwd, 'models', strcat('model_hog_', int2str(i))));
        model_hog = temp.model_hog;
        temp = load(fullfile(pwd, 'models', strcat('model_texton_', int2str(i))));
        model_texton = temp.model_texton;
        temp = load(fullfile(pwd, 'models', strcat('model_color_', int2str(i))));
        model_color = temp.model_color;
        
        % get predictions and probabilities
        attribute_test = attributes_apascal_test(:,i)*2-1;
        [labels, ~, early_fusion_prob] = predict(attribute_test, sparse(apascal_test), model_apascal, '-b 1');
        early_fusion_labels(:, i) = labels;
        [labels, ~, hog_prob] = predict(attribute_test, sparse(hog_apascal_test), model_hog, '-b 1');
        hog_labels(:, i) = labels;
        [labels, ~, texton_prob] = predict(attribute_test, sparse(texton_apascal_test), model_texton, '-b 1');
        texton_labels(:, i) = labels;
        [labels, ~, color_prob] = predict(attribute_test, sparse(color_apascal_test), model_color, '-b 1');
        color_labels(:, i) = labels;
        late_fusion_labels(:,i) = perform_late_fusion(hog_prob, texton_prob, color_prob);
        accuracy_early_fusion(i) = length(find(2*attributes_apascal_test(:,i)-1 - early_fusion_labels(:,i)==0))/n;
        accuracy_hog(i) = length(find(2*attributes_apascal_test(:,i)-1 - hog_labels(:,i)==0))/n;
        accuracy_texton(i) = length(find(2*attributes_apascal_test(:,i)-1 - texton_labels(:,i)==0))/n;
        accuracy_color(i) = length(find(2*attributes_apascal_test(:,i)-1 - color_labels(:,i)==0))/n;
        accuracy_late_fusion(i) = length(find(2*attributes_apascal_test(:,i)-1 - late_fusion_labels(:,i)==0))/n;
        
        % calculate rocs
        scores_early_fusion = apascal_test*model_apascal.w';
        temp = computeROC(scores_early_fusion, attribute_test);
        roc_early_fusion(i) = temp.area;
        scores_hog = hog_apascal_test*model_hog.w';
        temp = computeROC(scores_hog, attribute_test);
        roc_hog(i) = temp.area;
        scores_texton = texton_apascal_test*model_texton.w';
        temp = computeROC(scores_texton, attribute_test);
        roc_texton(i) = temp.area;
        scores_color = color_apascal_test*model_color.w';
        temp = computeROC(scores_color, attribute_test);
        roc_color(i) = temp.area;
        scores_late_fusion = (scores_early_fusion + scores_hog + scores_texton + scores_color)/3;
        temp = computeROC(scores_late_fusion, attribute_test);
        roc_late_fusion(i) = temp.area;
%         break;
    end
    save(fullfile(pwd, 'predictions_all_features', 'early_fusion_labels'), 'early_fusion_labels');
    save(fullfile(pwd, 'predictions_all_features', 'late_fusion_labels'), 'late_fusion_labels');
    save(fullfile(pwd, 'predictions_all_features', 'hog_labels'), 'hog_labels');
    save(fullfile(pwd, 'predictions_all_features', 'color_labels'), 'color_labels');
    save(fullfile(pwd, 'predictions_all_features', 'texton_labels'), 'texton_labels');
    save(fullfile(pwd, 'predictions_all_features', 'roc_early_fusion'), 'roc_early_fusion');
    save(fullfile(pwd, 'predictions_all_features', 'roc_hog'), 'roc_hog');
    save(fullfile(pwd, 'predictions_all_features', 'roc_color'), 'roc_color');
    save(fullfile(pwd, 'predictions_all_features', 'roc_texton'), 'roc_texton');
    save(fullfile(pwd, 'predictions_all_features', 'roc_late_fusion'), 'roc_late_fusion');
end