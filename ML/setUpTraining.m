%
% Make data available for training
% this will save the data on disk 
% for later use.
%

more off;

splitCat;  % get samples for training set
splitCat2; % get samples for test

fprintf("Loading data for training set and performing PCA \n");
fprintf("This can take a while...\n");

% d are the training data ( 30 x 1600 ) 
% s -> variance % at dimension j, from PCA 
% vectors from PCA 
[ d, s, v ] = prepareData( 30 );

fprintf("Saving data on disk\n");

save dataSet.dat d 
save s.dat s 
save v.dat v 

more on;