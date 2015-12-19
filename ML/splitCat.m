%
% This program loads training set from the 
% cats picture.
%
more off;
pkg load image

% default image size for width, height changes
% on the row
size_x = 213;
top = 1; rows = 5; cols = 6;

% image height depends on the row
SIZE_Y = [ 198 213 213 213 186  ];

catsGrid = imread("neko.orig.jpg");
colormap("gray");

trainingSet = zeros( 30, 1600 );
fprintf("Loading cats' data from the picture\n");
for i = 1:rows 
  size_y = SIZE_Y(i);
  for j = 1:cols
    index = j + ( i-1 ) * cols;
    left = 1+(j-1)*size_x;
    img = catsGrid(top:top+size_y,left:left+size_x,:);
    % make all the cat the same size.
    imgR = imresize( img, [ 40, 40 ] );
     
    % convert to gray scale
    [ X, MAP ] = rgb2ind( imgR );
    imgGS = ind2gray( X, MAP );
        
    % edge detection
    %imgGSE = edge( imgGS, "Sobel");
    
    % original picture
    imagesc( imgR );
    pause(0.1);
    % grayscale version
    imagesc( imgGS );
    pause(0.1);
    % decrease colors
    imgMASK = imgGS/1024; % + imgGSE * 8; 
    
    imagesc( imgMASK );
    pause( 0.1 );
   
    % questa e' la matrice con i dati del training set
    trainingSet(index, : ) = reshape(imgMASK, [ 1, 1600 ] );
    
  endfor
  top += size_y;
endfor

close all;

fprintf("Data loaded, starting to reduce the features\n");
fprintf("This will take a while...\n");

[ S,V ] = PCA(trainingSet);
Sc = cumsum(S);
fprintf("Features reduced from 1600 to 28, saved %f%% of variance\n",Sc(28));
trainingSetReduced = trainingSet * V(:,1:28);
fprintf("Done\n");

fprintf("To visualize the data into a 3D space we can save one %f%% of variance\n",Sc(3));
t3 = trainingSet * V(:,1:3);

figure 1;
clf;
plot3( t3(:,1),t3(:,2),t3(:,3), "xr");
grid on;
title("Cats' faces on 3D space, weak idea");
pause;

more on;