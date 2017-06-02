function [truths, sift_histogram_100, sift_binary_histogram_100, dsift_histogram_100, dsift_binary_histogram_100, sift_histogram_500, sift_binary_histogram_500] = create_predictions(train_set, test_set)    
    counter = 1;
    for k=1:length(test_set)
       true_label = test_set(k).name;
       temp = size(test_set(k).sift_histogram_100);
       for ii=1:temp(1)
           sift_max_histogram_100=0;
           sift_max_binary_histogram_100=0;
           sift_max_histogram_500=0;
           sift_max_binary_histogram_500=0;
           dsift_max_histogram_100=0;
           dsift_max_binary_histogram_100=0;
%            dsift_max_histogram_100=0;
%            dsift_max_binary_histogram_100=0;
           for n=1:length(train_set)
               for j=1:20
                  % sift histogram_100
                  score=histogram_intersection(test_set(k).sift_histogram_100(ii,:), train_set(n).sift_histogram_100(j,:)); 
                  if score > sift_max_histogram_100
                      sift_histogram_100_label=train_set(n).name;
                      sift_max_histogram_100 = score;
                  end
                  % sift_binary_histogram_100
                  score=histogram_intersection(test_set(k).sift_binary_histogram_100(ii,:), train_set(n).sift_binary_histogram_100(j,:)); 
                  if score > sift_max_binary_histogram_100
                      sift_binary_histogram_100_label=train_set(n).name;
                      sift_max_binary_histogram_100 = score;
                  end
                  % dsift_histogram_100
                  score=histogram_intersection(test_set(k).dsift_histogram_100(ii,:), train_set(n).dsift_histogram_100(j,:)); 
                  if score > dsift_max_histogram_100
                      dsift_histogram_100_label=train_set(n).name;
                      dsift_max_histogram_100 = score;
                  end
                  % dsift_max_binaryhistogram_100
                  score=histogram_intersection(test_set(k).dsift_binary_histogram_100(ii,:), train_set(n).dsift_binary_histogram_100(j,:)); 
                  if score > dsift_max_binary_histogram_100
                      dsift_binary_histogram_100_label=train_set(n).name;
                      dsift_max_binary_histogram_100 = score;
                  end
                  % sift histogram_500
                  score=histogram_intersection(test_set(k).sift_histogram_500(ii,:), train_set(n).sift_histogram_500(j,:)); 
                  if score > sift_max_histogram_500
                      sift_histogram_500_label=train_set(n).name;
                      sift_max_histogram_500 = score;
                  end
                  % sift binary_histogram_500
                  score=histogram_intersection(test_set(k).sift_binary_histogram_500(ii,:), train_set(n).sift_binary_histogram_500(j,:)); 
                  if score > sift_max_binary_histogram_500
                      sift_binary_histogram_500_label=train_set(n).name;
                      sift_max_binary_histogram_500 = score;
                  end
               end
           end
           truths{counter}=true_label;
           sift_histogram_100{counter}=sift_histogram_100_label;
           sift_binary_histogram_100{counter}=sift_binary_histogram_100_label;
           dsift_histogram_100{counter}=dsift_histogram_100_label;
           dsift_binary_histogram_100{counter}=dsift_binary_histogram_100_label;
           sift_histogram_500{counter}=sift_histogram_500_label;
           sift_binary_histogram_500{counter}=sift_binary_histogram_500_label;
           counter = counter + 1;
       end
    end