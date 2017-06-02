% function [histogram_encoding, binary_encoding] = encoding(descriptors, cluster_centers, numClusters)
numClusters = 100;
descriptors=d;
cluster_centers = sift_centers_100.sift_centers;
temp = size(descriptors);
assigned_cluster_centers = zeros(1, temp(2));
for ii=1:temp(2)
    [~, k] = min(vl_alldist(double(descriptors(:,ii)), cluster_centers));
    assigned_cluster_centers(ii)=k;
end
histogram_encoding = zeros(1, numClusters);
dummy_binary = ones(1, numClusters);
for ii=1:length(assigned_cluster_centers)
   histogram_encoding(assigned_cluster_centers(ii)) = histogram_encoding(assigned_cluster_centers(ii))+1; 
end
binary_encoding = double(dummy_binary&histogram_encoding);