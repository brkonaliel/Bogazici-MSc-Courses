close all; clc; clear;
%% Parameters

number_of_pattern = 450;
number_of_feature = 3;
number_of_cluster = 3;
eta = 0.1;
% how much spread we want
sd = 5;
%% Creation of random input patterns.

%  There are 450 input patterns, each having a random value between -1 and
%  1 on spherical coordinate system.
for i = 1:number_of_pattern
    if i <= number_of_pattern/3
        azimuth = 0;
        polar_angle = 0;
        cluster = 1;
    elseif i > number_of_pattern/3 && i <= 2*number_of_pattern/3
        azimuth = 120;
        polar_angle = 60;
        cluster = 2;
    else
        azimuth = 240;
        polar_angle = 120;
        cluster = 3;
    end
    azimuth = azimuth+randn*sd;
    polar_angle = polar_angle+randn*sd;
    input_patterns(i,:) = generate(azimuth, polar_angle);
end
%% Creation of random weight_matrix

% There are 3 clusters. Weight matrix will be 3x3
weight_matrix = rand(number_of_cluster,number_of_feature);
for i=1:number_of_cluster
    weight_matrix(i,:) = weight_matrix(i,:)/norm(weight_matrix(i,:));    
end
weight_matrix_record{1} = weight_matrix;
%% Main algorithm for unsupervised competitive learning. 

weight1_difference = 0;
weight2_difference = 0;
weight3_difference = 0;
% shuffle input points
input_patterns = input_patterns(randperm(end),:);

for i=1:number_of_pattern
    % maximum index
    [x,index] = max(weight_matrix*input_patterns(i,:)');
    % update rule
    weight_matrix(index,:) = weight_matrix(index,:)+eta*(input_patterns(i,:)-weight_matrix(index,:));
    weight_matrix(index,:) = weight_matrix(index,:)/norm(weight_matrix(index,:));
    weight_matrix_record{i+1} = weight_matrix;
    % plot on the same sphere
    clf
    hold on
    % draw input data as batch
    plot3(input_patterns(:,1),input_patterns(:,2),input_patterns(:,3), 'b.')
    % draw clusters separately.
    for j=1:number_of_cluster
        plot3(weight_matrix(j,1),weight_matrix(j,2),weight_matrix(j,3), 'r*')
    end
    view(45,60)
    title('Input Data and Calculated Cluster Centers')
    drawnow
    if index == 1
%         if flag1 == false
%            norm1_difference = norm(norm(weight_matrix(index,:) - input_patterns(i,:))); 
%            flag1 = true;
%            continue
%         end
        weight1_difference = [weight1_difference, norm(weight_matrix(index,:) - input_patterns(i,:))]; 
    elseif index == 2
%         if flag2 == false
%            norm2_difference = norm(norm(weight_matrix(index,:) - input_patterns(i,:))); 
%            flag2 = true;
%            continue
%         end
        weight2_difference = [weight2_difference, norm(weight_matrix(index,:) - input_patterns(i,:))];
    else
%         if flag3 == false
%            norm3_difference = norm(norm(weight_matrix(index,:) - input_patterns(i,:))); 
%            flag3 = true;
%            continue
%         end
        weight3_difference = [weight3_difference, norm(weight_matrix(index,:) - input_patterns(i,:))];
    end
end
%% Plotting the results
figure
plot(weight1_difference(:,2:end))
title('Difference of 1st cluster center and data points in that cluster')
figure
plot(weight2_difference(:,2:end))
title('Difference of 2nd cluster center and data points in that cluster')
figure
plot(weight3_difference(:,2:end))
title('Difference of 3rd cluster center and data points in that cluster')