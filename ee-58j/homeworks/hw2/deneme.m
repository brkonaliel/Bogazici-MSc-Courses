test_image = '/Users/burakonal/Desktop/edu_backup/ee-58j/PIRC2017_02/1001/crop_1026947.jpg';
I = imread(test_image);
I = imresize(I, [128 128]);
I = single(rgb2gray(I));

[f, d] = vl_sift(I);
[f_d, d_d] = vl_dsift(I, 'size', 16);
% binSize = 8 ;
% magnif = 3 ;
% Is = vl_imsmooth(I, sqrt((binSize/magnif)^2 - .25)) ;
% 
% [f, d] = vl_dsift(Is, 'size', binSize) ;
% f(3,:) = binSize/magnif ;
% f(4,:) = 0 ;
% [f_, d_] = vl_sift(I, 'frames', f);