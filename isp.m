function [ rgb ] = isp( CIS_output ,bilateral_sigma_d,bilateral_sigma_r,bayer_map,maxy,maxx,adc_bits,file)
% Image signal processor 
% Receieve CMOS sensor output and process to get quality image
% perform demosaicing , noise remove , color correct and etc.

bayer_demosaicing_rgb = bayer_demosaicing_isp(CIS_output,bilateral_sigma_d,bilateral_sigma_r,bayer_map,maxy,maxx,adc_bits,file);

color_corrected_rgb = color_isp(bayer_demosaicing_rgb,adc_bits);

rgb = post_isp(color_corrected_rgb,adc_bits,file);

end

