% Test noise filter different parameters

load scene 4
[BMP4,map4] = imread('..\scene4\cyflower1bb_reg1_2bright.bmp');

BMP4_decy(:,:,1) = downsample(BMP4(:,:,1),10);
BMP4_decy(:,:,2) = downsample(BMP4(:,:,2),10);
BMP4_decy(:,:,3) = downsample(BMP4(:,:,3),10);
s = size(BMP4_decy);

BMP4_dec = zeros(s(1),s(2)/10+1,3);
for y=1:s(1)
       r = downsample( BMP4_decy(y,:,1),10);
       g = downsample( BMP4_decy(y,:,2),10);
       b = downsample( BMP4_decy(y,:,3),10);
       BMP4_dec(y,:,1) = r;
       BMP4_dec(y,:,2) = g;
       BMP4_dec(y,:,3) = b;
end    

BMP4_dec = uint8(BMP4_dec);
[maxy,maxx,colors] = size(BMP4_dec);

% AWGN noise on RGB channels
BMP4_noisy = zeros(maxy,maxx,3);
ratio = 40;
BMP4_noisy = BMP4_dec;
BMP4_noisy(:,:,1) = uint8(ratio*randn(maxy,maxx))+BMP4_dec(:,:,1);
BMP4_noisy(:,:,2) = uint8(ratio*randn(maxy,maxx))+BMP4_dec(:,:,2);
BMP4_noisy(:,:,3) = uint8(ratio*randn(maxy,maxx))+BMP4_dec(:,:,3);

figure
subplot(2,3,1);
imshow(BMP4_dec);
title('Original');
subplot(2,3,2);
imshow(BMP4_noisy);
title('noisy');
BMP4_wiener(:,:,1) = wiener2(BMP4_noisy(:,:,1));
BMP4_wiener(:,:,2) = wiener2(BMP4_noisy(:,:,2));
BMP4_wiener(:,:,3) = wiener2(BMP4_noisy(:,:,3));
subplot(2,3,3);
imshow(BMP4_wiener); %
title('Wiener2');

%figure
b1 = bilateralFilter(BMP4_noisy,10,32,maxy,maxx);
subplot(2,3,4);
imshow(uint8(b1));
title('\sigma_d = 10,\sigma_r=32');

b2 = bilateralFilter(BMP4_noisy,10,21,maxy,maxx);
subplot(2,3,5);
imshow(uint8(b2));
title('\sigma_d = 10,\sigma_r=21');
 
b3 = bilateralFilter(BMP4_noisy,3,21,maxy,maxx);
subplot(2,3,6);
imshow(uint8(b3));
title('\sigma_d = 3,\sigma_r=21');

