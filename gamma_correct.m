function [ out_rgb ] = gamma_correct( in_rgb,adc_bits )

% Perform simple Gamma correction on all channels
 GammaValueR = 0.45 ;
 GammaValueG = 0.45 ;
 GammaValueB = 0.45 ;
 in_rgb_double = double(in_rgb);
 val_max = 2^adc_bits;
out_rgb(:,:,1) = val_max * (in_rgb_double(:,:,1)/val_max).^ GammaValueR;
out_rgb(:,:,2) = val_max * (in_rgb_double(:,:,2)/val_max).^ GammaValueG;
out_rgb(:,:,3) = val_max * (in_rgb_double(:,:,3)/val_max).^ GammaValueB;

end

