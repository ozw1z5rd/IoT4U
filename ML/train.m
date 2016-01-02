load dataSet.dat;
load s.dat;
load v.dat;
more off;
close all;
clc;
figure('Position',[0,0,1024,768]);
subplot(2,2,1);
dr = d*v(:,1:28);
successMatrix = zeros(1,2);
svMatrix = [ ] 

  for nux=0:4
    ok = 0; 
    ko = 0;    
    nu = 0.03 + 0.24*nux;
    successMatrix(nux+1,1) = nu;
    fprintf("Training with nu=%0.1f ... ",nu);
    model = svmtrain ( ones(30,1), dr, sprintf("-s 2 -t 1 -d 4 -nu %0.2f -gamma 0.0001 -q", nu));
        
    fprintf("Total support vectors : %d\n",model.totalSV);
    svMatrix( end + 1) = model.totalSV;
    
    dr3d1 = dr*v(1:28,1:3);
    subplot(2,2,2);
    plot3(dr3d1(:,1),dr3d1(:,2),dr3d1(:,3), "or");
    sv3d = model.SVs * v(1:28,1:3);
    hold on;
    plot3(sv3d(:,1),sv3d(:,2),sv3d(:,3), "+k");
    grid on;
    legend("training data","support vector");
    
    hold off;
 
    for i = 1:10
      colormap("gray");
      fileName = sprintf("t%02d.png",i);
      im = imread( fileName );
      
      subplot(2,2,1);
      imagesc( im ); pause( 0.5 );
  
  
      im = double(im );
      % decrease dimensions
      ld = size( im );
      imr = reshape(im,[1,ld(1)*ld(2)]) * v(:,1:28);
      class = svmpredict([ 1 ], imr, model, "-q" );
      if ( class == 1 ) 
        colormap("summer");
        title("IT'S A CAT");
        ok += 1;
        successMatrix(nux+1,2) += 1;
      else 
        colormap("autumn");
        title("UNKNOWN");
        ko += 1;
      endif;
      pause(0.3);
      
      subplot(2,2,3);
      plot(successMatrix(:,1),successMatrix(:,2),"or");
      hold on;
      xlabel("nu");
      ylabel("Cats detected");
      plot(successMatrix(:,1),successMatrix(:,2),"--b");
      grid on;
      title("Success");
      hold off;
      
      subplot(2,2,4);
      plot(successMatrix(:,1),svMatrix(:),"og");
      hold on;
      ylabel("N. SVs");
      xlabel("nu");
      plot(successMatrix(:,1),svMatrix(:),"--r");
      grid on;
      title("Support Vectors used.");      
      hold off;
  
    endfor  % i 
    fprintf("OK=%d KO=%d success at %0.1f%%\n",ok,ko, ok/10*100);
    successMatrix = [ successMatrix; zeros(1,2)];
    pause(5);
  endfor % nu

more on;
