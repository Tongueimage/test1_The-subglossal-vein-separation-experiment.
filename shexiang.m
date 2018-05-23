%script file:shexiang.m
%
%Purpose:
%to extract the sublingual vein.
%
%Record of revision:
% Date         Programmer          Description of chage
% =====        ==========         ======================
%23-May-2018                    The sublingual vein is divided.
%
%Define variables:
% I1  --read the input picture
%
%


clc;close all;
% clear all;

file_path = '/Users/hangyiwang/Downloads/lunwen/matlab_program/';
file_name = '1.png';

I = imread([file_path file_name],'png');
% inputfile='C:\Users\DELL\Desktop\images\test\1\';
% outputfile='C:\Users\DELL\Desktop\images\test\2\';
% Files = dir([inputfile '*.png']);
% number = length(Files);
% for i = 1:number
%     img = imread([inputfile Files(i).name]);
%     I = imresize(img,[200,200]);
    %Color correction ÑÕÉ«Ð£Õý
    I1 = yansejiaozheng(I);
    %Color histogram equalization. ²ÊÉ«Ö±·½Í¼¾ùºâ»¯
    I2 = color_equ(I1);
    figure(1);
    subplot(2,3,1);imshow(I2);title('Color histogram equalization');  %Color histogram equalization.
    h = fspecial('average',3);
    I2 = imfilter(I2,h,'corr','replicate');
    hsi = rgb2hsi(I2);
    hsi_h = hsi(:,:,1);
    hsi_s = hsi(:,:,2);
    hsi_i = hsi(:,:,3);
    
    subplot(2,3,2);imshow(hsi_h);title('H component'); %h ·ÖÁ¿
    subplot(2,3,3);imshow(hsi_s);title('S component'); %s ·ÖÁ¿
    hsi = hsi_h.*hsi_s;
    gausFilter = fspecial('gaussian',[5 5],0.5);  
    hsi = imfilter(hsi,gausFilter,'replicate'); 
    subplot(2,3,4);imshow(hsi);title('The h component dot the S component'); %h·ÖÁ¿µã³Ës·ÖÁ¿
    thresh = graythresh(hsi); %Automatic determination of binarization threshold. ×Ô¶¯È·¶¨¶þÖµ»¯ãÐÖµ£»
    hsi2 = imbinarize(hsi,thresh); 
    subplot(2,3,5);imshow(hsi2);title('Binarization');  %???
%     hy = fspecial('sobel'); %sobel operator 
%     hx = hy'; 
%     Iy = imfilter(double(hsi2), hy, 'replicate');%ÂË²¨Çóy·½Ïò±ßÔµ 
%     Ix = imfilter(double(hsi2), hx, 'replicate');%ÂË²¨Çóx·½Ïò±ßÔµ 
%     gradmag = sqrt(Ix.^2 + Iy.^2);  %modulus ÇóÄ£
%     D = bwdist(hsi2);
%     DL = watershed(D);
%     bgm = DL == 0;
%     gradmag2 = imimposemin(gradmag,bgm|fgm4);
%     L = watershed(gradmag2);
%     hsi2(imdilate(L == 0,ones(3,3))|bgm|fgm4) = 255;
%     figure(2);
   
se = strel('disk',2);
openbw = imopen(hsi2,se);
%The operation cancels out the noise.  ¿ª²Ù×÷ÏûÈ¥Ôëµã
imLabel = bwlabel(openbw);%Mark the connected area.  ¶ÔÁ¬Í¨ÇøÓò½øÐÐ±ê¼Ç   
stats = regionprops(imLabel,'Area');    
[~,index]=sort([stats.Area],'descend');  
if length(stats)<2 
    bw=imLabel;  
else  
    bw=ismember(imLabel,index(1:2));  
end   
% Close operation ±ÕÔËËã
bw = bwmorph(bw,'close');
subplot(2,3,6);imshow(bw);title('result');
%     axis([100,480,50,450]);=ismember(imLabel,index(1:2));  

% subplot(2,3,5);axis([100,480,100,450]);
% regionGrow(bw);
%     imwrite(bw,[outputfile Files(i).name(1:end-4) '.png']); 
% end
 x = find(bw == 1);  
a = length(x); % Number of white pixels. °×É«ÏñËØµã¸öÊý
[x,y] = find(bw == 0);
b = length(x); % Number of black pixels. ºÚÉ«ÏñËØµã¸öÊý
S = a/b  %The two tongue veins occupy the entire area of the image. Á½ÌõÉàÂöÕ¼Õû¸öÍ¼ÏñÃæ»ý

L = double(bw); %The binary matrix is converted to the annotation matrix. ¶þÖµ¾ØÕó×ª»¯Îª±ê×¢¾ØÕó
img_L = regionprops(L,'MajorAxisLength');
l = [img_L.MajorAxisLength]; %The region has the long axis length of an ellipse with the same standard second order central moment.ÇøÓò¾ßÓÐÏàÍ¬±ê×¼¶þ½×ÖÐÐÄ¾ØµÄÍÖÔ²µÄ³¤Öá³¤¶È
l = l/size(bw,1)   %Calculate tongue length ratio of tongue length. ¼ÆËãÉàÂö³¤¶ÈÕ¼ÉàÍ·³¤¶È±È
for i = 1:480
    for j = 1:640
        if(bw(i,j)==false)
            I1(i,j,1)=255;
            I1(i,j,2)=255;
            I1(i,j,3)=255;
        end
    end
end

figure;
imshow(I1); title('Hypoglossal vein image area.The end result')
