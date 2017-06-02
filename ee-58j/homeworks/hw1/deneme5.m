for window=1:3
    for binning=1:3
        window = 1;
        binning = 3;
        data_path = '/Users/burakonal/Desktop/edu_backup/ee-58j/vispera_loose_crop_all';
        bin_vector = [8,16,32];
        bin_size = bin_vector(binning);
        window_vector = {[1 1], [2 2], [4 4]};
        window_size = window_vector{window};
        NumNeighbors = 8;
        image_size = [128 128];
        norm_value = 1;
        distance_norm = 1;
        [data_set, class_names] = create_data_set(data_path, bin_size, NumNeighbors, image_size, window_size, norm_value);
        [truths, avg_predictions, avg_weighted_predictions, hsv_predictions, hog_predictions, lbp_predictions] = create_predictions(data_path, bin_size, NumNeighbors, image_size, window_size, norm_value, class_names, data_set, distance_norm);

        [C_avg_predictions,order] = confusionmat(truths,avg_predictions);
        C_avg_weighted_predictions = confusionmat(truths,avg_weighted_predictions);
        C_hsv_predictions = confusionmat(truths, hsv_predictions);
        C_hog_predictions = confusionmat(truths,hog_predictions);
        C_lbp_predictions = confusionmat(truths,lbp_predictions);

        for i=1:180
            avg_predictions_normalised(i,:) = C_avg_predictions(i,:)/sum(C_avg_predictions(i,:));
        end
        for i=1:180
            avg_weighted_predictions_normalised(i,:) = C_avg_weighted_predictions(i,:)/sum(C_avg_weighted_predictions(i,:));
        end
        for i=1:180
            hsv_predictions_normalised(i,:) = C_hsv_predictions(i,:)/sum(C_hsv_predictions(i,:));
        end
        for i=1:180
            hog_predictions_normalised(i,:) = C_hog_predictions(i,:)/sum(C_hog_predictions(i,:));
        end
        for i=1:180
            lbp_predictions_normalised(i,:) = C_lbp_predictions(i,:)/sum(C_lbp_predictions(i,:));
        end

        success_avg = trace(C_avg_predictions)/sum(sum(C_avg_predictions));
        success_weighted_avg = trace(C_avg_weighted_predictions)/sum(sum(C_avg_weighted_predictions));
        success_hsv = trace(C_hsv_predictions)/sum(sum(C_hsv_predictions));
        success_hog = trace(C_hog_predictions)/sum(sum(C_hog_predictions));
        success_lbp = trace(C_lbp_predictions)/sum(sum(C_lbp_predictions));
        sprintf('avg predictions for window size %d, binning %d is %.2f', window, binning, success_avg)
        sprintf('avg weighted predictions for window size %d, binning %d is %.2f', window, binning, success_weighted_avg)
        sprintf('hsv predictions for window size %d, binning %d is %.2f', window, binning, success_hsv)
        sprintf('hog predictions for window size %d, binning %d is %.2f', window, binning, success_hog)
        sprintf('lbp predictions for window size %d, binning %d is %.2f', window, binning, success_lbp)
        break
    end
    break
end

