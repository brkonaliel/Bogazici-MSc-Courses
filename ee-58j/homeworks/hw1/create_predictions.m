function [truths, avg_predictions, avg_weighted_predictions, hsv_predictions, hog_predictions, lbp_predictions] = create_predictions(data_path, bin_size, NumNeighbors, image_size, window_size, norm_value, class_names, test_data, distance_norm)
counter = 1;
for i=1:length(class_names)
% for i=1:10
    true_label = class_names{i};
    dir_path = strcat(data_path, '/', true_label, '/', 'test');
    files = dir(dir_path);
    for j=1:length(files)
        if length(files(j).name) < 4 || ~strcmp(files(j).name(1:4), 'img_')
            continue
        end
        % build the file path
        file_path = strcat(dir_path, '/', files(j).name);
        % read the train image
        image = imread(file_path);
        % resize the image
        image = imresize(image,image_size);
        % arrange windowing
        rows = image_size(1)/window_size(1)*ones(1,window_size(1));
        columns = rows;
        image = mat2cell(image, rows, columns, 3);
        HSV_descriptor = ones(length(image)*length(image),3*bin_size);
        HOG_descriptor = ones(length(image)*length(image),bin_size);
        LBP_descriptor = ones(length(image)*length(image),bin_size);
        for k=1:length(image)*length(image)
            % HSV 
            image_HSV = rgb2hsv(image{k});
            image_HSV_H = histcounts(image_HSV(:,:,1), bin_size);
%             image_HSV_H = image_HSV_H/norm(image_HSV_H, norm_value);
            image_HSV_S = histcounts(image_HSV(:,:,2), bin_size);
%             image_HSV_S = image_HSV_S/norm(image_HSV_S, norm_value);
            image_HSV_V = histcounts(image_HSV(:,:,3), bin_size);
%             image_HSV_V = image_HSV_V/norm(image_HSV_V, norm_value);
            image_HSV_all = [image_HSV_H,image_HSV_S,image_HSV_V];
%             image_HSV_all = image_HSV_all/norm(image_HSV_all, norm_value);
            HSV_descriptor(k,:) = image_HSV_all;
            % HOG
            image_grayscale = rgb2gray(image{k});
            [Gx, Gy] = imgradientxy(image_grayscale);
            [Gmag, Gdir] = imgradient(Gx, Gy);
            Gdir = Gdir/360;
            Gdir_histogram = histcounts(Gdir, bin_size);
%             Gdir_histogram = Gdir_histogram/norm(Gdir_histogram,norm_value);
            HOG_descriptor(k,:) = Gdir_histogram;
            % LBP
            lbp = extractLBPFeatures(image_grayscale, 'NumNeighbors', NumNeighbors);
            lbp_histogram = histcounts(lbp, bin_size);
%             lbp_histogram = lbp_histogram/norm(lbp_histogram,norm_value);
            LBP_descriptor(k,:) = lbp_histogram;
        end
        HSV_descriptor = HSV_descriptor/norm(HSV_descriptor, norm_value);
        HOG_descriptor = HOG_descriptor/norm(HOG_descriptor, norm_value);
        LBP_descriptor = LBP_descriptor/norm(LBP_descriptor, norm_value);
        min_avg_distance = inf;
        min_avg_weighted_distance = inf;
        min_hsv_distance = inf;
        min_hog_distance = inf;
        min_lbp_distance = inf;
 
        for k=1:length(test_data)
           for l=1:length(test_data(k).hsv)
               hsv_distance = norm((HSV_descriptor - test_data(k).hsv{l}), distance_norm);
               hog_distance = norm((HOG_descriptor - test_data(k).hog{l}), distance_norm);
               lbp_distance = norm((LBP_descriptor - test_data(k).lbp{l}), distance_norm);
               avg_distance = (hsv_distance + hog_distance + lbp_distance)/3;
               avg_weighted_distance = (0.5*hsv_distance + 0.25*hog_distance + 0.25*lbp_distance)/3;
               
               if hsv_distance < min_hsv_distance
                  min_hsv_label = test_data(k).name;
                  min_hsv_distance = hsv_distance;
               end
               if hog_distance < min_hog_distance
                  min_hog_label = test_data(k).name;
                  min_hog_distance = hog_distance;
               end
               if lbp_distance < min_lbp_distance
                  min_lbp_label = test_data(k).name;
                  min_lbp_distance = lbp_distance;
               end
               if avg_distance < min_avg_distance
                   min_avg_label = test_data(k).name;
                   min_avg_distance = avg_distance;
               end
               if avg_weighted_distance < min_avg_weighted_distance
                   min_avg_weighted_label = test_data(k).name;
                   min_avg_weighted_distance = avg_weighted_distance;
               end
           end
        end
        truths{counter} = true_label;
        avg_predictions{counter} = min_avg_label;
        avg_weighted_predictions{counter} = min_avg_weighted_label;
        hsv_predictions{counter} = min_hsv_label;
        hog_predictions{counter} = min_hog_label;
        lbp_predictions{counter} = min_lbp_label;
        counter = counter + 1;
    end
%     break
end