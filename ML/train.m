if ( exist( "d" ) == 0 ) 
  load dataSet.dat;
  load s.dat;
  load v.dat;
  % d with 0 mean and 1 std 
  [ d, mn, sd ] = normalize(d);
endif 

more off;

clc;
clf;

figure('Position',[0,0,1024,768]);
subplot(2,2,1);


dr = d*v(:,1:28);
successMatrix = zeros(1,3);
svMatrix = zeros(1,3);

for gamma = linspace(0.001,0.00001,15)
  for nu=linspace(0.01,0.99,15) 
    ok = 0; 
    ko = 0;    
   
    successMatrix(end,1) = nu;
    successMatrix(end,2) = gamma;
    svMatrix(end,1) = nu;
    svMatrix(end,2) = gamma;
    
    model = svmtrain ( ones(30,1), dr, sprintf("-s 2 -t 2 -nu %0.2f -g %0.9f", nu,gamma));
        
    fprintf("Total support vectors : %d\n",model.totalSV);
    svMatrix( end,3) = model.totalSV;
    
    dr3d1 = dr*v(1:28,1:3);
    subplot(2,2,2);
    scatter3(dr3d1(:,1),dr3d1(:,2),dr3d1(:,3), 8, "green");
    sv3d = model.SVs * v(1:28,1:3);
    hold on;
    scatter3(sv3d(:,1),sv3d(:,2),sv3d(:,3), 6, "red");
    grid on;
    title(sprintf("Training with nu=%f gamma=%e .. ",nu,gamma));
    legend("training data","support vector");
    
    hold off;
 
    for i = 1:10
      colormap("gray");
      fileName = sprintf("t%02d.png",i);
      im = imread( fileName );
      
      subplot(2,2,1);
      imagesc( im ); pause( 0.1 );
  
  
      im = double(im );
      % decrease dimensions
      ld = size( im );
      imRow = reshape( im , [ 1 , ld(1)*ld(2) ] );
      imRow = ( imRow - mn ) ./ sd;
      
      imr = imRow * v(:,1:28);
      [class, accuracy, prob ] = svmpredict([ 1 ], imr, model, "-q" );
      if ( class == 1 ) 
        colormap("summer");
        title(sprintf("IT'S A CAT, accuracy=%f",accuracy(1)));
        pause(0.2);
        ok += 1;
        successMatrix(end,3) += 1;
      else 
        colormap("autumn");
        title("UNKNOWN");
        ko += 1;
      endif;
      pause(0.1);
      
      subplot(2,2,3);
      scatter3(successMatrix(:,1),successMatrix(:,2),successMatrix(:,3),"red","filled");
      view(120,30);
      hold on;
      xlabel("nu");
      zlabel("Cats detected");
      ylabel("gamma");
      %plot3(successMatrix(:,1),successMatrix(:,2),successMatrix(:,3),"--b");
      grid on;
      title("Success");
      hold off;
      
      subplot(2,2,4);
      scatter3(svMatrix(:,1),svMatrix(:,2), svMatrix(:,3),"green","filled");
      hold on;
      zlabel("N. SVs");
      xlabel("nu");
      ylabel("gamma");
      %plot(successMatrix(:,1),svMatrix(:),"--r");
      grid on;
      title("Support Vectors used.");      
      hold off;
  
    endfor  % i 
    fprintf("OK=%d KO=%d success at %0.1f%%\n",ok,ko, ok/10*100);
    successMatrix = [ successMatrix; zeros(1,3)];
    svMatrix = [ svMatrix; zeros(1,3)];
  endfor % nu
endfor % gamma

more on;
