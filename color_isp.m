function [ out_rgb ] = color_isp( in_rgb,adc_bits )

 % perform collor correction on input RGB

 ccm_rgb = ccm(in_rgb);
 gamma_rgb = gamma_correct(ccm_rgb,adc_bits);
 yuv = yuv_processing(gamma_rgb);
 out_rgb = white_balance(yuv,adc_bits); % This is actually RGB since yuv isn't used for color enhancment in this project
end

