 
 model = svmtrain ( ones(30,1), dr, "-s 2 -c 1 ");
 
 for i = 1:10
  fileName = sprintf("t%02d.png",i);
  im = double(imread(fileName));
  % decrease dimensions
  imr = reshape(im,[1,1600]) * v(:,1:28);
  svmpredict([ 1 ], imr, model )
endfor  
  
    