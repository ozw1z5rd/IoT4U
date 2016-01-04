## usage: [V,S] = PCA(X)
##
##  X = data set
##  V = vectors which defines the new space
##  S = percentage of variance at dimension j
##
## this function depends on normalize() 
##
## Function description
##
## Example:
##
##  [V,S] = PCA(X);
##  % decrease features to 3 
##  X * V(:,1:3) 
##  % saved variance is S(3) percent
##  S(3)*100
##
function [S, V] = PCA( X )
  n = size( X ,1 );
  % avoid division by zero
  if ( n == 1 ) 
    n = 2;
  endif
  [X0,mean, std] = normalize(X);   
  C = X0' * X0 / (  n - 1 );
  [ U,S,V ] = svd( C );
  S = diag(S)/sum(diag(S));
endfunction