clc; clf;
clear;

fprintf("PCA con SVD\n");
fprintf("Questo e' il nostro training set di esempio.\n");

x = [ 1 1 1 ; 2 2 2; 3 3 3; 4 4 4; 5 5 5; 6 6 6; 7 7 7; 7 8 9; 8 9 9 ];
xn = x + rand(size(x));
xn
fprintf("Media\n");
mean(xn)
fprintf("Deviazione standard\n");
std(xn)
pause;

fprintf("Normalizziamo i dati.\n");
x0 = xn - mean(xn);
s = std( xn ); s( find( s == 0 ) ) = 1;
x0 = x0 ./ s;
xn = x0;
fprintf("Media\n");
mean(xn)
fprintf("Deviazione standard\n");
std(xn)
pause;


figure 1;
plot3(xn(:,1),xn(:,2),xn(:,3), "or");
grid on;
hold on;
plot3(xn(:,1),xn(:,2),xn(:,3) );
hold off;
title("Posizione dei punti del training set normalizzato");
pause;



fprintf("Calcoliamo la matrice di covarianza e decomponiamola\n");

c = xn'*xn/(size(x0,1)-1)
[ U,S,V ] = svd(c)

varLoss = cumsum( diag(S)/sum(diag(S)))*100
fprintf("Proiettando in 2D il training set rimane il %f%% della varianza,\n", varLoss(2));
fprintf("la forma del training set e' praticamente mantenuta\n");
pause;

fprintf("Proiezione dei dati nel nuovo sistema di riferimento\n");
xr = x0*V(:,1:2)
fprintf("Media\n");
mean(xr)
fprintf("Deviazione standard\n");
std(xr)
pause;

figure 2 
min = min(min(xr));
max = max(max(xr));
plot(xr(:,1),xr(:,2));
axis([ min max min max]);
grid on 
hold on ; plot(xr(:,1),xr(:,2), "or");

title("Proiezione del training set nello spazio 2D");hold off 

pause;
fprintf("Anche in una dimensione si conserva la forma, il (%f)%% della varianza e' conservata\n", varLoss(1));
xr = x0*V(:,1)
fprintf("Media\n");
mean(xr)
fprintf("Deviazione standard\n");
std(xr)
pause;

figure 3;
title("Proiezione del training set nello spazio 1D");
plot(xr,zeros(size(xr)));
axis([ min max min max]);
grid on 
hold on ; plot(xr,zeros(size(xr)), "or");
hold off 
pause;


