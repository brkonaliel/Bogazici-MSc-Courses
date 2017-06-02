function create_charts()
    project_path = '/Users/burakonal/Desktop/edu/ee-58j/project/';
    attribute_names = importdata(fullfile(project_path, 'attribute_data', 'attribute_names.txt'));
    
    % all features
    temp = load(fullfile(pwd, 'predictions_all_features', 'roc_early_fusion'), 'roc_early_fusion');
    roc_early_fusion = temp.roc_early_fusion;
    temp = load(fullfile(pwd, 'predictions_all_features', 'roc_late_fusion'), 'roc_late_fusion');
    roc_late_fusion = temp.roc_late_fusion;
    temp = load(fullfile(pwd, 'predictions_all_features', 'roc_hog'), 'roc_hog');
    roc_hog = temp.roc_hog;
    temp = load(fullfile(pwd, 'predictions_all_features', 'roc_color'), 'roc_color');
    roc_color = temp.roc_color;
    temp = load(fullfile(pwd, 'predictions_all_features', 'roc_texton'), 'roc_texton');
    roc_texton = temp.roc_texton;
    [sval, sindn] = sort(roc_early_fusion);
    figure
    plot(sval, 'bx', 'MarkerSize',10)
    a = attribute_names(sindn);
    set(gca,'XTick', 1:64, 'XTickLabel',a);
    h = gca;
    h.XTickLabelRotation = 90;
    hold on;
    pause;
    plot(roc_hog(sindn), 'r*', 'MarkerSize',10);
    hold on;
    pause;
    plot(roc_texton(sindn), 'c*', 'MarkerSize',10);
    hold on;
    pause;
    plot(roc_color(sindn), 'g*', 'MarkerSize',10);
    pause;
    plot(roc_late_fusion(sindn), 'k+', 'MarkerSize',10);
    legend('Location','northwest')
    legend ('show');
    legend('early fusion', 'hog', 'texton', 'color', 'late fusion');
    title('AUC Comparison');
    
    % selected features
    temp = load(fullfile(pwd, 'predictions_selected_features', 'roc_early_fusion'), 'roc_early_fusion');
    roc_early_fusion = temp.roc_early_fusion;
    temp = load(fullfile(pwd, 'predictions_selected_features', 'roc_late_fusion'), 'roc_late_fusion');
    roc_late_fusion = temp.roc_late_fusion;
    temp = load(fullfile(pwd, 'predictions_selected_features', 'roc_hog'), 'roc_hog');
    roc_hog = temp.roc_hog;
    temp = load(fullfile(pwd, 'predictions_selected_features', 'roc_color'), 'roc_color');
    roc_color = temp.roc_color;
    temp = load(fullfile(pwd, 'predictions_selected_features', 'roc_texton'), 'roc_texton');
    roc_texton = temp.roc_texton;
%     [sval, sindn] = sort(roc_early_fusion);
    figure
    plot(roc_early_fusion(sindn), 'bx', 'MarkerSize',10)
    a = attribute_names(sindn);
    set(gca,'XTick', 1:64, 'XTickLabel',a);
    h = gca;
    h.XTickLabelRotation = 90;
    hold on;
    pause;
    plot(roc_hog(sindn), 'r*', 'MarkerSize',10);
    hold on;
    pause;
    plot(roc_texton(sindn), 'c*', 'MarkerSize',10);
    hold on;
    pause;
    plot(roc_color(sindn), 'g*', 'MarkerSize',10);
    pause;
    plot(roc_late_fusion(sindn), 'k+', 'MarkerSize',10);
    legend('Location','northwest')
    legend ('show');
    legend('early fusion', 'hog', 'texton', 'color', 'late fusion');
    title('AUC Comparison');
    
end