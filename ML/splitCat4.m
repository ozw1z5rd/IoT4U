%
% Split the cats in test set and 
% cross validation set 
%
clear;
pkg load image;
more off;
imgSize = [260 260];
py = 1; 
% https://66bbce2a-a-62cb3a1a-s-sites.googlegroups.com/site/ozw1z5rd/machinelearning/020-vector-support-machine/collage-different-cute-cats-many-faces-46520920.jpg?attachauth=ANoY7cqXdu_9FECdl8c3ntQ9UEv1q9Jee0Qyh2Ihp57VU5rBZVaa7iWQotTOIPYmiBtrvDM4QZYYQ6hQ27-7QBJbI0ag8A_xh1tYdInfzBV9eIX_Klpt5pWXfE0imTcTnB_M6qanRcDNY8ITE_dXc8jinUbaVt5c46ZI8h-41zv-VuSY55-TBadY6deJ4beWsiV72_BCx5JNRei9nMBDIlW7fEHyK3uETk_LNRfNqisHlQ1UWTJOOURH8w1iiBx-81aKx8ddDbIBTxn9Q3ZSvNWutDR-s7q8lDRE-i5JKoruvxjM-8-xwXg_GhC33HSy3KvOb7vihunx&attredirects=0
% https://sites.google.com/site/ozw1z5rd/machinelearning/020-vector-support-machine
img = imread("test.jpg");
colormap("gray");
addpath("/home/apalma/octave/image-2.4.1");

fprintf("splitting test data into txx.png and cxx.png\n");

for y = 1:4
  px = 1;
  for x = 1:5
    img1 = img( py+2:py+imgSize(1),px+2:px+imgSize(2)-1,:);
    px = px + imgSize(2);
    index = x+(y-1)*5;
    
     % convert to gray scale
    [ X, MAP ] = rgb2ind( img1 );
    imgGS = ind2gray( X, MAP );        
    imgBorder = edge( imgGS, "Canny");    
    
    im = uint16(imgGS ./ 8192) + uint16(imgBorder) * 16;
    im = imresize(im,[75 75],"linear");
    im( find( im > 8 )) = 16;
    imagesc( im );    
    pause(0.4);
    imgSmall = imresize(im,[75 75]);
    
    if ( index < 11 ) 
      fileName = sprintf("t%02d.png",index)
    else 
      fileName = sprintf("cv%02d.png", index)
    endif
    imwrite(imgSmall.*4096, fileName );
    
  endfor
  py = py + imgSize(1);
endfor 

fprintf("done\n");
more on;
close all;
clear;

