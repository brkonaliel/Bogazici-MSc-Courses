temp = fitensemble(train_data_features_8, train_data_labels, 'AdaBoostM2',1,'Tree');
temp_predict = predict(temp, test_data_features_8);

