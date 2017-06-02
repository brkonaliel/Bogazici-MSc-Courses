clc;clear all;
data_path = '/Users/burakonal/Desktop/edu/58j/hw3/PIRC2017_03';

% train data and test data feature extraction
train_data_features_8 = feature_extraction(data_path, [8 8]);
disp('train 8 completed')
figure
imagesc(train_data_features_8)
train_data_features_16 = feature_extraction(data_path, [16 16]);
disp('train 16 completed')
figure
imagesc(train_data_features_16)
train_data_features_32 = feature_extraction(data_path, [32 32]);
disp('train 32 completed')
imagesc(train_data_features_32)
test_data_features_8 = test_feature_extraction(data_path, [8 8]);
disp('test 8 completed')
test_data_features_16 = test_feature_extraction(data_path, [16 16]);
disp('test 16 completed')
test_data_features_32 = test_feature_extraction(data_path, [32 32]);
disp('test 32 completed')
save('/Users/burakonal/Desktop/edu/58j/hw3/train_data_features_8', 'train_data_features_8');
save('/Users/burakonal/Desktop/edu/58j/hw3/test_data_features_8', 'test_data_features_8');
save('/Users/burakonal/Desktop/edu/58j/hw3/train_data_features_16', 'train_data_features_16');
save('/Users/burakonal/Desktop/edu/58j/hw3/train_data_features_32', 'train_data_features_32');
save('/Users/burakonal/Desktop/edu/58j/hw3/test_data_features_16', 'test_data_features_16');
save('/Users/burakonal/Desktop/edu/58j/hw3/test_data_features_32', 'test_data_features_32');

% loading train data
% temp = load('train_data_features_8');
% train_data_features_8 = temp.train_data_features_8;
% temp = load('train_data_features_16');
% train_data_features_16 = temp.train_data_features_16;
% temp = load('train_data_features_32');
% train_data_features_32 = temp.train_data_features_32;
% temp = load('test_data_features_8');
% test_data_features_8 = temp.test_data_features_8;
% temp = load('test_data_features_16');
% test_data_features_16 = temp.test_data_features_16;
% temp = load('test_data_features_32');
% test_data_features_32 = temp.test_data_features_32;

% label creation
train_data_labels = ones(1600,1);
for i=51:50:1601
    train_data_labels(i-50:i-1) = (i-1)/50;
end
test_data_labels = test_label_creation(data_path);

% Classifier Training
ClassTreeEns_16_100 = fitensemble(train_data_features_16, train_data_labels, 'AdaBoostM2',100,'Tree');
disp('classifier 16 100 completed')
% save('/Users/burakonal/Desktop/edu/58j/hw3/ClassTreeEns_16_100', 'ClassTreeEns_16_100')
ClassTreeEns_16_500 = fitensemble(train_data_features_16, train_data_labels, 'AdaBoostM2',500,'Tree');
disp('classifier 16 500 completed')
% save('/Users/burakonal/Desktop/edu/58j/hw3/ClassTreeEns_16_500', 'ClassTreeEns_16_500')
ClassTreeEns_16_1000 = fitensemble(train_data_features_16, train_data_labels, 'AdaBoostM2',1000,'Tree');
disp('classifier 16 1000 completed')
% save('/Users/burakonal/Desktop/edu/58j/hw3/ClassTreeEns_16_1000', 'ClassTreeEns_16_1000')
ClassTreeEns_16_5000 = fitensemble(train_data_features_16, train_data_labels, 'AdaBoostM2',5000,'Tree');
disp('classifier 16 5000 completed')
% save('/Users/burakonal/Desktop/edu/58j/hw3/ClassTreeEns_16_5000', 'ClassTreeEns_16_5000')
ClassTreeEns_32_100 = fitensemble(train_data_features_32, train_data_labels, 'AdaBoostM2',100,'Tree');
disp('classifier 32 100 completed')
% save('/Users/burakonal/Desktop/edu/58j/hw3/ClassTreeEns_32_100', 'ClassTreeEns_32_100')
ClassTreeEns_32_500 = fitensemble(train_data_features_32, train_data_labels, 'AdaBoostM2',500,'Tree');
disp('classifier 32 500 completed')
% save('/Users/burakonal/Desktop/edu/58j/hw3/ClassTreeEns_32_500', 'ClassTreeEns_32_500')
ClassTreeEns_32_1000 = fitensemble(train_data_features_32, train_data_labels, 'AdaBoostM2',1000,'Tree');
disp('classifier 32 1000 completed')
% save('/Users/burakonal/Desktop/edu/58j/hw3/ClassTreeEns_32_1000', 'ClassTreeEns_32_1000')
ClassTreeEns_32_5000 = fitensemble(train_data_features_32, train_data_labels, 'AdaBoostM2',5000,'Tree');
disp('classifier 32 5000 completed')
% save('/Users/burakonal/Desktop/edu/58j/hw3/ClassTreeEns_32_5000', 'ClassTreeEns_32_5000')
ClassTreeEns_8_100 = fitensemble(train_data_features_8, train_data_labels, 'AdaBoostM2',100,'Tree');
disp('classifier 8 100 completed')
% save('/Users/burakonal/Desktop/edu/58j/hw3/ClassTreeEns_8_100', 'ClassTreeEns_8_100')
ClassTreeEns_8_500 = fitensemble(train_data_features_8, train_data_labels, 'AdaBoostM2',500,'Tree');
disp('classifier 8 500 completed')
% save('/Users/burakonal/Desktop/edu/58j/hw3/ClassTreeEns_8_500', 'ClassTreeEns_8_500')
ClassTreeEns_8_1000 = fitensemble(train_data_features_8, train_data_labels, 'AdaBoostM2',1000,'Tree');
disp('classifier 8 1000 completed')
% save('/Users/burakonal/Desktop/edu/58j/hw3/ClassTreeEns_8_1000', 'ClassTreeEns_8_1000')

% Predictions
test_data_predict_16_100 = predict(ClassTreeEns_16_100, test_data_features_16);
disp('prediction 16 100 completed')
test_data_predict_16_500 = predict(ClassTreeEns_16_500, test_data_features_16);
disp('prediction 16 500 completed')
test_data_predict_16_1000 = predict(ClassTreeEns_16_1000, test_data_features_16);
disp('prediction 16 1000 completed')
test_data_predict_16_5000 = predict(ClassTreeEns_16_5000, test_data_features_16);
disp('prediction 16 5000 completed')
test_data_predict_32_100 = predict(ClassTreeEns_32_100, test_data_features_32);
disp('prediction 32 100 completed')
test_data_predict_32_500 = predict(ClassTreeEns_32_500, test_data_features_32);
disp('prediction 32 500 completed')
test_data_predict_32_1000 = predict(ClassTreeEns_32_1000, test_data_features_32);
disp('prediction 32 1000 completed')
test_data_predict_32_5000 = predict(ClassTreeEns_32_5000, test_data_features_32);
disp('prediction 32 5000 completed')
test_data_predict_8_100 = predict(ClassTreeEns_8_100, test_data_features_8);
disp('prediction 8 100 completed')
test_data_predict_8_500 = predict(ClassTreeEns_8_500, test_data_features_8);
disp('prediction 8 500 completed')

% confusion matrices
[C_test_data_predict_16_100, ~] = confusionmat(test_data_labels, test_data_predict_16_100);
[C_test_data_predict_16_500, ~] = confusionmat(test_data_labels, test_data_predict_16_500);
[C_test_data_predict_16_1000, ~] = confusionmat(test_data_labels, test_data_predict_16_1000);
[C_test_data_predict_16_5000, ~] = confusionmat(test_data_labels, test_data_predict_16_5000);
[C_test_data_predict_32_100, ~] = confusionmat(test_data_labels, test_data_predict_32_100);
[C_test_data_predict_32_500, ~] = confusionmat(test_data_labels, test_data_predict_32_500);
[C_test_data_predict_32_1000, ~] = confusionmat(test_data_labels, test_data_predict_32_1000);
[C_test_data_predict_32_5000, ~] = confusionmat(test_data_labels, test_data_predict_32_5000);
[C_test_data_predict_8_100, ~] = confusionmat(test_data_labels, test_data_predict_8_100);
[C_test_data_predict_8_500, ~] = confusionmat(test_data_labels, test_data_predict_8_500);

% precision
precision_16_100 = trace(C_test_data_predict_16_100)/sum(sum(C_test_data_predict_32_100));
disp('precision 16 100')
precision_16_500 = trace(C_test_data_predict_16_500)/sum(sum(C_test_data_predict_32_500));
disp('precision 16 500')
precision_16_1000 = trace(C_test_data_predict_16_1000)/sum(sum(C_test_data_predict_32_1000));
disp('precision 16 1000')
precision_16_5000 = trace(C_test_data_predict_16_5000)/sum(sum(C_test_data_predict_32_1000));
disp('precision 16 5000')
precision_32_100 = trace(C_test_data_predict_32_100)/sum(sum(C_test_data_predict_32_100));
disp('precision 32 100')
precision_32_500 = trace(C_test_data_predict_32_500)/sum(sum(C_test_data_predict_32_500));
disp('precision 32 500')
precision_32_1000 = trace(C_test_data_predict_32_1000)/sum(sum(C_test_data_predict_32_1000));
disp('precision 32 1000')
precision_32_5000 = trace(C_test_data_predict_32_5000)/sum(sum(C_test_data_predict_32_1000));
disp('precision 32 5000')
precision_8_100 = trace(C_test_data_predict_8_100)/sum(sum(C_test_data_predict_32_100));
disp('precision 8 100')
precision_8_500 = trace(C_test_data_predict_8_500)/sum(sum(C_test_data_predict_32_500));
disp('precision 8 500')