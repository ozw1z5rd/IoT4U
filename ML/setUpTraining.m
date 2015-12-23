fprintf("Loading data for training set and performing PCA \n");
[ d, s, v ] = prepareData( 30 );
fprintf("Saving data on disk\n");
save dataSet d 
save S s 
save V v 

