%
% Save the images as single file
%
splitCat;
splitCat2;


[ dataSet, S, V ] = train( 30 );

fprintf("Data loaded, starting to reduce the features\n");
fprintf("This will take a while...\n");

[ S,V ] = PCA(trainingSet);

Sc = cumsum(S);
fprintf("Features reduced from 1600 to 28, saved %f%% of variance\n",Sc(28)*100);
trainingSetReduced = trainingSet * V(:,1:28);
fprintf("Done\n");

fprintf("To visualize the data into a 3D space we can save only %f%% of variance\n",Sc(3)*100);
t3 = trainingSet * V(:,1:3);

figure 1;
clf;
plot3( t3(:,1),t3(:,2),t3(:,3), "xr");
grid on;
title("Cats' faces on 3D space, weak idea");
pause;
