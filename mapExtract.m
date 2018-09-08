function [  ] = mapExtract(  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

close all
he = imread('testimg2.jpg');
he = imresize(he, [500 500]);
imshow(he), title('H&E image'); 
he = imadjust(he,[0 0 0; .3 .3 .3],[]);

he_bw = rgb2gray(he);
he_bw = imbinarize(he_bw); %disp(he_bw);
%imshow(he_bw), title('BW image');

figure
[y,x] = find(he_bw == 0);
y = (-1)*y;
plot(x, y, 'k.');
hold on

RRT2Sinha(x',y');

end

