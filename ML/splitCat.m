%
% This program will get the single face from the 
% cat grid.
%

pkg load image

% default image size for width, height changes
% on the row
size_x = 213;
top = 1; rows = 5; cols = 6;

% image height depends on the row
SIZE_Y = [ 198 213 213 213 186  ];

catsGrid = imread("neko.orig.jpg");

for i = 1:rows 
  size_y = SIZE_Y(i);
  for j = 1:cols
    index = j + ( i-1 ) * cols;
    left = 1+(j-1)*size_x;
    img = catsGrid(top:top+size_y,left:left+size_x,:);
    % make all the cat the same size.
    imgR = imresize( img, [ 213, 213 ] );
    imagesc(imgR);
    
    % convert to gray scale
    [ X, MAP ] = rgb2ind( imgR );
    imgGS = ind2gray( X, MAP );
    pause(0.1);
        
    % edge detection
    imgGSE = edge( imgGS, "Canny");
    imagesc( imgGSE );
    pause(0.5);
    
    maxValue = max(max(imgGS));
    
    imgGSE = maxValue * imgGSE;
    im = ( imgGS + imgGSE ) / 2 / maxValue;
    
    imagesc( im );
    pause(1);
    
  endfor
  top += size_y;
endfor
   
