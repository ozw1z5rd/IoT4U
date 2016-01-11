
% f(x) = sin(x);

% max allowed error
err = 1e-6;
%max cicles allowed
maxCicle = 30;

dx=1e-6; dy =1e-6;

% plot number
pl = 1;


clc;
% regularization parameter
for alpha=[0.1]
  oldAlpha = alpha;
  zold =0;
        
  
  % starting point
  % x0 =2; y0=-2;
  x0 =0; y0= 1.2;
  data = [];
  % how many steps
  cicle = 0;
  done = false;
  
  oldDx = (peaks([x0+dx],[y0])-peaks([x0],[y0]))/dx;
  oldDy = (peaks([x0],[y0+dy])-peaks([x0],[y0]))/dy;

  while ( cicle<maxCicle && ! done)
 
      alphaTooBig = false;
      % numerical way
      Dx = (peaks([x0+dx],[y0])-peaks([x0],[y0]))/dx;
      Dy = (peaks([x0],[y0+dy])-peaks([x0],[y0]))/dy;
      
      do
        x1 = x0 - alpha*Dx;
        y1 = y0 - alpha*Dy;

        nDx = (peaks([x1+dx],[y1])-peaks([x1],[y1]))/dx;   
        nDy = (peaks([x1],[y1+dy])-peaks([x1],[y1]))/dy;

        % detect the sign change on every direction
        fprintf("DX current %f previous %f\n", Dx, nDx );
        fprintf("DY current %f previous %f\n\n", Dy, nDy );
        
        if ( (sign(Dx) != sign( nDx )) || (sign(Dy) != sign(nDy) )  )
          alpha /= 3
          alphaTooBig = true;
          if ( alpha < 1e-9 ) 
            done = true;
            alphaTooBig = false;
          endif;
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
    [xx,yy,zz] = peaks();
    mesh(xx,yy,zz);
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


    
    
