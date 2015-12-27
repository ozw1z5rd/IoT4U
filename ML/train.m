load dataSet.dat;
load s.dat;
load v.dat;
more off;
colormap("ocean");
 fprintf("Training... \n");
 dr = d*v(:,1:28);
 model = svmtrain ( ones(30,1), dr, "-s 2 -c 1 ");
 
 for i = 1:10
  fileName = sprintf("t%02d.png",i)
  
  im = imread( fileName );
  imagesc( im ); pause( 1 );
  im = double(im );
  % decrease dimensions
  imr = reshape(im,[1,1600]) * v(:,1:28);
  svmpredict([ 1 ], imr, model )
endfor  
  
more on;