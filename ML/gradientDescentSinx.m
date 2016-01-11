
x = linspace(-2.2,1);
% f(x) = sin(x);

% max allowed error
err = 1e-6;

% plot number
pl = 1;
% regularization parameter
for alpha=[2 1 0.5 0.25]
  yold =0;
  % starting point
  x0 = 1;
  data = [];
  % how many steps
  cicle = 20;
  while ( cicle != 0 ) 
      x0 = x0 - alpha*cos(x0);
      y = sin(x0);
      if ( abs(yold - y) <  err )
        cicle = 0;
      else 
        yold = y;
        data = [ data ; x0, y];
        --cicle;
      endif;
  endwhile;

  figure 1;
    subplot(1,4,pl++);
    plot(x,sin(x),"k");
    hold on; grid on;
    scatter(data(:,1),data(:,2),"red","filled");
    plot(data(:,1),data(:,2),"g--");
    title(sprintf("Gradient Descent for sin(x)\nalpha=%d",alpha));
    hold off;

endfor;
