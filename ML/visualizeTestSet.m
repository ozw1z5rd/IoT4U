%
% Save the images as single file
%

more off;

load s.dat;
load v.dat;
load dataSet.dat;


colormap("gray");
data = zeros(10,1600);
for i=1:20

    if ( i<11 ) 
      fileName = sprintf("t%02d.png",i);
    else 
      fileName = sprintf("cv%02d.png",i);
    endif
    
    if ( exist( fileName ) ) 
      fprintf("Loading %s ...\n", fileName );
      img = imread( fileName );
      imagesc( img ); pause(0.5);
      data(i,:) = reshape( img, [ 1 1600 ] );
    endif
    
endfor

  Sc = cumsum(s);
  fprintf("To visualize the data into a 3D space we can save only %f%% of variance\n",Sc(3)*100);
  ts = data* v(:,1:3);
  t  = d * v(:,1:3);
  
  size(t)
  size(ts)
  figure 2;
  clf;
  plot3( ts(1:10,1),ts(1:10,2),ts(1:10,3), "xr");
  hold on;
  plot3( ts(11:20,1),ts(11:20,2),ts(11:20,3), "sg");
  plot3( t(:,1),t(:,2),t(:,3), "db");
  legend("Test set", "Cross validation set", "Training set");
  title("All the data into a 3d projection");
  grid on;
 
  

  
  
more on;