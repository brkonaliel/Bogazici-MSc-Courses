% close all; clc; clear all;
% parameters
data_path = '/Users/burakonal/Desktop/edu_backup/ee-58j/vispera_loose_crop_all';
bin_size = 10;
NumNeighbors = 8;
image_size = [128 128];
window_size = [2 2];
norm_value = 1;
% getting class names into a cell array
names = dir(data_path);
j=1;
class_names = cell(180,1);
for i=1:length(names)
    if names(i).name(1) == '.'
        continue
    end
    class_names{j} = names(i).name;
    j = j+1;
end
for i=1:length(class_names)
    name = class_names{i};
    dir_path = strcat(data_path, '/', name, '/', 'test');
    files = dir(dir_path);
    test_set(i).name = name;
%         hsv_cell = cell(10,1);
%         hog_cell = cell(10,1);
%         lbp_cell = cell(10,1);
    cell_count = 0;
    for j=1:length(files)
        if length(files(j).name) < 4 || ~strcmp(files(j).name(1:4), 'img_')
            continue
        end
        cell_count = cell_count + 1;
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
%             lbp_histogram = lbp_histogram/calculate_p_norm(lbp_histogram,norm_value);
            LBP_descriptor(k,:) = lbp_histogram;
        end
        hsv_cell{cell_count} = HSV_descriptor/norm(HSV_descriptor, norm_value);
        hog_cell{cell_count} = HOG_descriptor/norm(HOG_descriptor, norm_value);
        lbp_cell{cell_count} = LBP_descriptor/norm(LBP_descriptor, norm_value);
    end
    test_set(i).hsv = hsv_cell;
    test_set(i).hog = hog_cell;
    test_set(i).lbp = lbp_cell;
    clear hsv_cell;
    clear hog_cell;
    clear hsv_cell;
end