close all; clc; clear;
%% Parameters

% The script is not fully parametrised. Here, parameters are just for
% explanatory purpose.
number_of_pattern = 450;
number_of_feature = 3;
number_of_cluster = 3;
eta = 0.1;
% how much spread we want, i.e. standart deviation of the additive noise.
sd = 10;
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
    input_patterns(i,:) = [generate(azimuth, polar_angle), cluster];
end
clusters{1} = input_patterns(1:150,1:3);
clusters{2} = input_patterns(151:300,1:3);
clusters{3} = input_patterns(300:end,1:3);
%% Creation of random weight_matrix

% There are 3 clusters. Weight matrix will be 3x3
weight_matrix = rand(number_of_cluster,number_of_feature);
for i=1:number_of_cluster
    azimuth = 360*rand;
    polar_angle = 180*rand;
    weight_matrix(i,:) = generate(azimuth, polar_angle);
end
% record weight matrix to track movements of the mean.
weight_matrix_record = weight_matrix;
% record of differences of means and points in cluster
weight1_difference = 0;
weight2_difference = 0;
weight3_difference = 0;

% plot input data and initial weights
plot3(input_patterns(:,1),input_patterns(:,2),input_patterns(:,3), 'b.')
hold on
% draw updated weights separately.
for j=1:number_of_cluster
    plot3(weight_matrix(j,1),weight_matrix(j,2),weight_matrix(j,3), 'r*')
end
view(45,60)
title('Input Data and Calculated Cluster Centers')
% pause;
%% Main algorithm for unsupervised competitive learning. 

% shuffle of points
input_patterns = input_patterns(randperm(end),:);
for i=1:number_of_pattern
    % maximum index
    [x,index] = max(weight_matrix*input_patterns(i,1:3)');
    % update rule
    weight_matrix(index,:) = weight_matrix(index,:)+eta*(input_patterns(i,1:3)-weight_matrix(index,:));
    weight_matrix(index,:) = weight_matrix(index,:)/norm(weight_matrix(index,:));
    
    % plot data points and updated weights on the same sphere
    clf
    hold on
    % draw input data as batch
    plot3(input_patterns(:,1),input_patterns(:,2),input_patterns(:,3), 'b.')
    % draw updated weights separately.
    for j=1:number_of_cluster
        plot3(weight_matrix(j,1),weight_matrix(j,2),weight_matrix(j,3), 'r*')
    end
    view(45,60)
    title('Input Data and Calculated Cluster Centers')
    drawnow
    
    dummy = zeros(1,3);
    cluster = input_patterns(i,4);
    if index == 1
        for k=1:length(clusters{cluster})
            dummy = dummy + clusters{cluster}(k,:) - weight_matrix(index,:);
        end
        weight1_difference = [weight1_difference, norm(dummy)]; 
    elseif index == 2
        for k=1:length(clusters{cluster})
            dummy = dummy + clusters{cluster}(k,:) - weight_matrix(index,:);
        end
        weight2_difference = [weight2_difference, norm(dummy)];
    else
         for k=1:length(clusters{cluster})
            dummy = dummy + clusters{cluster}(k,:) - weight_matrix(index,:);
        end
        weight3_difference = [weight3_difference, norm(dummy)];
    end
%     if mod(i,150) == 0
%        pause; 
%     end
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