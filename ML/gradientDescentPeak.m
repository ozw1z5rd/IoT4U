
% f(x) = sin(x);

% max allowed error
err = 1e-6;
%max cicles allowed
maxCicle = 200;

dx=0.01; dy =0.01;

% plot number
pl = 1;
% regularization parameter
for alpha=[0.03]
  oldAlpha = alpha;
  zold =0;
  % starting point
  % x0 =2; y0=-2;
  x0 =0; y0= 1.2;
  data = [];
  % how many steps
  cicle = 0;
  done = false;
  while ( cicle<maxCicle && ! done)
 
      alphaTooBig = false;
      % numerical way
      Dx = (peaks([x0+dx],[y0])-peaks([x0],[y0]))/dx;
      Dy = (peaks([x0],[y0+dy])-peaks([x0],[y0]))/dy;
      
      do
        x1 = x0 - alpha*Dx;
        y1 = y0 - alpha*Dy;
        if ( sign(peaks([x1],[y1])) != sign( peaks([x0],[y0]) ) ) 
          alpha /= 3;
          alphaTooBig = true;
        else 
          alphaTooBig = false;
        endif
      until( !alphaTooBig )
      
      z = peaks([x1],[y1]);
      
      x0 = x1;
      y0 = y1;
      
      if ( abs(zold - z) <  err )
        done = true;
      else 
        zold = z;
        data = [ data ; x0, y0, z];
        ++cicle;
      endif;
      
  endwhile;
  
  figure 1;
    subplot(1,2,pl++);
    peaks();
    hold on; grid on;
    scatter3(data(:,1),data(:,2),data(:,3),"red","filled");
    plot3(data(:,1),data(:,2),data(:,3),"g--");
    title(sprintf("Gradient Descent for sin(x)\nsteps=%d\nInitial alpha=%d",cicle, oldAlpha));
    hold off;

    subplot(1,2,2);
    plot(data(:,3));
    title("Z value");
    grid on
    
endfor;


    
    