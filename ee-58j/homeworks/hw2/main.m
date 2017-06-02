% [train_set, class_names] = create_train_histograms();
% [test_set, ~] = create_test_histograms();

% [truths, sift_histogram_100, sift_binary_histogram_100, dsift_histogram_100, dsift_binary_histogram_100, sift_histogram_500, sift_binary_histogram_500] = create_predictions(train_set.train_set, test_set.test_set);

% confusion matrices
[C_sift_histogram_100, order] = confusionmat(truths,sift_histogram_100);
C_sift_binary_histogram_100 = confusionmat(truths,sift_binary_histogram_100);
C_dsift_histogram_100 = confusionmat(truths, dsift_histogram_100);
C_dsift_binary_histogram_100 = confusionmat(truths,dsift_binary_histogram_100);
C_sift_histogram_500 = confusionmat(truths,sift_histogram_500);
C_sift_binary_histogram_500 = confusionmat(truths,sift_binary_histogram_500);

% precision
success_sift_histogram_100 = trace(C_sift_histogram_100)/sum(sum(C_sift_histogram_100));
success_sift_binary_histogram_100 = trace(C_sift_binary_histogram_100)/sum(sum(C_sift_binary_histogram_100));
success_dsift_histogram_100 = trace(C_dsift_histogram_100)/sum(sum(C_dsift_histogram_100));
success_dsift_binary_histogram_100 = trace(C_dsift_binary_histogram_100)/sum(sum(C_dsift_binary_histogram_100));
success_sift_histogram_500 = trace(C_sift_histogram_500)/sum(sum(C_sift_histogram_500));
success_sift_binary_histogram_500 = trace(C_sift_binary_histogram_500)/sum(sum(C_sift_binary_histogram_500));


% normalisation
for i=1:20
    C_sift_histogram_100_normalised(i,:) = C_sift_histogram_100(i,:)/sum(C_sift_histogram_100(i,:));
    C_sift_binary_histogram_100_normalised(i,:) = C_sift_binary_histogram_100(i,:)/sum(C_sift_binary_histogram_100(i,:));
    C_dsift_histogram_100_normalised(i,:) = C_dsift_histogram_100(i,:)/sum(C_dsift_histogram_100(i,:));
    C_dsift_binary_histogram_100_normalised(i,:) = C_dsift_binary_histogram_100(i,:)/sum(C_dsift_binary_histogram_100(i,:));
    C_sift_histogram_500_normalised(i,:) = C_sift_histogram_500(i,:)/sum(C_sift_histogram_500(i,:));
    C_sift_binary_histogram_500_normalised(i,:) = C_sift_binary_histogram_500(i,:)/sum(C_sift_binary_histogram_500(i,:));
end
HMobj = HeatMap(C_dsift_histogram_100_normalised);
addTitle(HMobj, 'Dsift with k=100');
HMobj = HeatMap(C_sift_histogram_500_normalised);
addTitle(HMobj, 'Sift with k=500');

