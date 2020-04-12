%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main CIS simulator including ISP SOC  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% parameters:
% raw reflectances - reflectances from sun+scene
% QEi - quantum efficincy interpolated for our frequencies (400-720 in 10 range)
% CIE_D65_E - CIE color values  for our frequencies
% well_noise_percentage - percentage of noise in well (modeling)
% pixel_defect_ppm - number of hot pixels (modeling)
% adc_bits - number of bits for analog to digital converter
% row_noise - row noise percentage (modeling)
% blind_detect_alpha - alpha value used for ranged blind detect correction
% bilateral_sigma_d - bilateral filter d value
% bilateral_sigma_r - bilateral filter r value
% additional_rows - additional rows in array used for row noise removal 
% exposure_time - time of exposure of array to photons
% exposure_percentage - percentage of exposure of well used to model darkness
%fname - file name for outputs
function [soc,t] = SOC(raw_reflectances,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise,blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,exposure_percentage,fname);

tic

raw_size = size(raw_reflectances);
maxy = raw_size(1);
maxx = raw_size(2);

% create color map (1-red,2-green,3-blue) of Bayer matrix array
bayer_map = bayer_colors(maxy,maxx);

% pass optic image through CMOS sensor , sensor adds noise for pixel defect
% (dead/hot), random pixels read out noise , temporal row noise and temperature noise 
% it produces output after ADC and front_end ISP 
CIS_output_bayer = CIS(raw_reflectances,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise,bayer_map,maxy,maxx,additional_rows,blind_detect_alpha,bayer_map,exposure_time,exposure_percentage,fname);

% ISP takes sensor input and produces image to show,  it does demosaicing ,
% (bayer) , color correction , gamma , noise reducion and etc
isp_rgb = isp(CIS_output_bayer,bilateral_sigma_d,bilateral_sigma_r,bayer_map,maxy,maxx,adc_bits,fname);

soc = isp_rgb;
t = toc;

end
