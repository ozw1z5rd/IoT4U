%
% Save the images as single file
%

more off;

if ( exist( "dataSet.dat") == 2 && exist("d") == 0 )
  fprintf("Loading dataSet from disk\n");
  load dataSet
endif

if ( exist("s.dat") == 2 && exist("s") == 0) 
  fprintf("Loading variance data from disk\n");
  load s.dat
endif 

if ( exist("v.dat") == 2 && exist("v") == 0) 
  fprintf("Loading V matrix from disk\n");
  load v.dat
endif  


  Sc = cumsum(s);
  fprintf("To visualize the data into a 3D space we can save only %f%% of variance\n",Sc(3)*100);
  t3 = d* v(:,1:3);
  figure 1;
  clf;
  plot3( t3(:,1),t3(:,2),t3(:,3), "xr");
  grid on;
  title("Cats' faces on 3D space, weak idea");


more on;