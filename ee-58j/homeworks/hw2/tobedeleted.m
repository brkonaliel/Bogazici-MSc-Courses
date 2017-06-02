numClusters=500;
[dsift_centers, ~] = vl_kmeans(double(dsift_descriptors), numClusters);
save('/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02/dsift_centers_500.mat', 'dsift_frames');