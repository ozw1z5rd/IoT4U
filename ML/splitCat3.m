%
% save all cats for training set as single
% files. 40 x 40 gray scale.
% https://66bbce2a-a-62cb3a1a-s-sites.googlegroups.com/site/ozw1z5rd/machinelearning/020-vector-support-machine/cats_portrait_cute_animals_faces_1280x800_hd-wallpaper-1667846.jpg?attachauth=ANoY7cr0kyJXWsYoX7dC0H1nsZDq2L4kDF-NQLKQ8avrmu67DD7CgCEBWwZUf0HQEjBDXGT8yu1ojxtJ9uymBNea0KRiIAJpTnKR-qwjpSCCP7tAjuusf1wuuB3YqEzQSvWqCt7ZFiqSGqepXFZHHXz4Hu7mdGnerfiyjY_oleqtv4dtTR1yF6ABVQNngRuGmIqdf_7jT-yxaPhNgR7vnIosOrQue4MnnNQw_vk14VZ3PiPrvnOPRUw3Jo-ssJVgSKkFfvSyynI8VYAAb81WPmVQmImm8CHPhxTg2Z70D2qAoLxtHz30KF6JLGoXzmBvrC8k5vdHEfBXQYWDioQzK52WbscnTH66xg%3D%3D&attredirects=0
%
more off;
addpath("/home/apalma/octave/image-2.4.1");
pkg load image;


size_x = 213;
top = 1; rows = 5; cols = 6;

% image height depends on the row
SIZE_Y = [ 198 213 213 213 186  ];

catsGrid = imread("neko.orig.jpg");
colormap("gray");

close all;
figure('Position',[0,0,1280,512]);
colormap("gray");
subplot(1,2,1);
fprintf("Loading cats' data from the picture\n");
for i = 1:rows 
  size_y = SIZE_Y(i);
  for j = 1:cols
    index = j + ( i-1 ) * cols;
    left = 1+(j-1)*size_x;
    img = catsGrid(top:top+size_y,left:left+size_x,:);
    
    subplot(1,2,1);
    imagesc( img ); 

    % convert to gray scale
    [ X, MAP ] = rgb2ind( img );
    imgGS = ind2gray( X, MAP );        
    imgBorder = edge( imgGS, "Canny");
    
    subplot(1,2,2);   
    im = uint16(imgGS ./ 8192) + uint16(imgBorder) * 16;
    im = imresize(im,[75 75],"linear");
    im( find( im > 8 )) = 16;
    imagesc( im );
            
    fileName = sprintf("ts%02d.png",index);
    imwrite( im.*4096, fileName );
    
    pause(0.1);
  endfor
  top += size_y;
endfor

