
x = linspace(-2.2,1);
% f(x) = sin(x);

% max allowed error
err = 1e-6;
%max cicles allowed
maxCicle = 1000;

% plot number
pl = 1;
% regularization parameter
for alpha=[5 3 2 1]
  oldAlpha = alpha;
  yold =0;
  % starting point
  x0 = 1;
  data = [];
  % how many steps
  cicle = 0;
  done = false;
  while ( cicle<maxCicle && ! done)
      alphaTooBig = false;
      cosx0 = cos(x0);
      do
        x1 = x0 - alpha*cosx0;
        if ( sign(cos(x1)) != sign( cosx0 ) ) 
          alpha /= 3;
          alphaTooBig = true;
        else 
          alphaTooBig = false;
        endif
      until( !alphaTooBig )
      
      y = sin(x1);
      x0 = x1;
      
      if ( abs(yold - y) <  err )
        done = true;
      else 
        yold = y;
        data = [ data ; x0, y];
        ++cicle;
      endif;
      
  endwhile;

  figure 1;
    subplot(1,4,pl++);
    plot(x,sin(x),"k");
    hold on; grid on;
    scatter(data(:,1),data(:,2),"red","filled");
    plot(data(:,1),data(:,2),"g--");
    title(sprintf("Gradient Descent for sin(x)\nsteps=%d\nInitial alpha=%d",cicle, oldAlpha));
    hold off;

endfor;
