data_path = '/Users/burakonal/Desktop/edu/58j/hw3/PIRC2017_03';
test_data_labels = test_label_creation(data_path);
temp = load(fullfile(pwd, 'test_data_features_32'));
test_data_features_32 = temp.test_data_features_32;
temp = load(fullfile(pwd, 'ClassTreeEns_32_5000'));
ClassTreeEns_32_5000 = temp.ClassTreeEns_32_5000;
test_data_predict_32_5000 = predict(ClassTreeEns_32_5000, test_data_features_32);
[C_test_data_predict_32_5000, ~] = confusionmat(test_data_labels, test_data_predict_32_5000);

for i=1:32
    C_test_data_predict_32_5000(i,:) = C_test_data_predict_32_5000(i,:)/sum(C_test_data_predict_32_5000(i,:));
end

HMobj = HeatMap(C_test_data_predict_32_5000);
addTitle(HMobj, 'Windowing 32x32 with k=5000');