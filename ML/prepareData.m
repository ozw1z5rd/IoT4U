## usage: [dataSet,S,V] = training( nSamples )
##
##  nSample => number of samples, this function will load
##             tsxx.png file which is supposed to be a 
##             gray scale image 40x40
##
##  V = vectors which defines the new space, required to
##      reduce dimensions
##
##  S = percentage of variance at dimension j
##
## Function description
##
## Example:
##
##  [ dataSet,S,V ] = training( 30 );
##  % decreasae dimension to 3
##  dataSet * V(:,1:3) 
##  % saved variance is S(3) percent
##  S(3)*100
##
function [ dataSet, S, V ] = prepareData( nSamples ) 
  dataSet = [];
  fprintf("Loading training set, %d samples \n", nSamples);
  for i = 1:nSamples
    fileName = sprintf("ts%02d.png",i);
    fprintf("Loading %s ...\n", fileName );
    img =  double(imread( fileName ));
    ld = size(img);
    dataSet = [ dataSet;  reshape( img, [1,ld(1)*ld(2)]) ] ;
  endfor
  fprintf("Data set loaded, computing PCA data\n");
  [ S, V ] = PCA( dataSet );
endfunction 