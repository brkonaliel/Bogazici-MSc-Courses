data_path = '/Users/burakonal/Desktop/edu/58j/hw3/PIRC2017_03';

% train data and test data feature extraction
train_data_features_8 = feature_extraction(data_path, [8 8]);
disp('train 8 completed')
test_data_features_8 = test_feature_extraction(data_path, [8 8]);
disp('test 8 completed')
save('/Users/burakonal/Desktop/edu/58j/hw3/train_data_features_8', 'train_data_features_8');
save('/Users/burakonal/Desktop/edu/58j/hw3/test_data_features_8', 'test_data_features_8');

% Classifier Training
ClassTreeEns_8_100 = fitensemble(train_data_features_8, train_data_labels, 'AdaBoostM2',100,'Tree');
disp('classifier 16 100 completed')
ClassTreeEns_8_500 = fitensemble(train_data_features_8, train_data_labels, 'AdaBoostM2',500,'Tree');
disp('classifier 16 500 completed')
% ClassTreeEns_8_1000 = fitensemble(train_data_features_8, train_data_labels, 'AdaBoostM2',1000,'Tree');
% disp('classifier 8 1000 completed')
% ClassTreeEns_8_5000 = fitensemble(train_data_features_8, train_data_labels, 'AdaBoostM2',5000,'Tree');
% disp('classifier 8 5000 completed')

% Predictions
test_data_predict_8_100 = predict(ClassTreeEns_8_100, test_data_features_8);
disp('prediction 16 100 completed')
test_data_predict_8_500 = predict(ClassTreeEns_8_500, test_data_features_8);
disp('prediction 16 500 completed')
% test_data_predict_8_1000 = predict(ClassTreeEns_8_1000, test_data_features_8);
% disp('prediction 8 1000 completed')
% test_data_predict_8_5000 = predict(ClassTreeEns_8_5000, test_data_features_8);
% disp('prediction 8 5000 completed')