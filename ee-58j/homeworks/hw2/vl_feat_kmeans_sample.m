numData = 5000 ;
dimension = 2 ;
data = rand(dimension,numData) ;
numClusters = 30 ;
[centers, assignments] = vl_kmeans(data, numClusters);

x = rand(dimension, 2) ;
[~, k] = min(vl_alldist(x, centers));
