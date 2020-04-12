%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Main CMOS sensor and ISP project file
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% setup should be run only once , you may comment the next line out if
% already used 
setup

% define project parameters
well_noise_percentage = 0.1;
pixel_defect_ppm = 1000;
adc_bits=10; 
row_noise=0.05;

% empirical values
blind_detect_alpha=0.15;
bilateral_sigma_d=3;
bilateral_sigma_r=21;
additional_rows = 10;
exposure_time = 1/250; 

[out4,t4] = SOC(crop_ref4,QEi,CIE_D65_E,0,0,adc_bits,0, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,100,'scene4_ideal');
[out4,t4] = SOC(crop_ref4,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,100,'scene4_noise');
[out4,t4] = SOC(crop_ref4,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,10,'scene4_10');
[out4,t4] = SOC(crop_ref4,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,1,'scene4_1a');
[out4,t4] = SOC(crop_ref4,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,1,'scene4_1b');
[out4,t4] = SOC(crop_ref4,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,1,'scene4_1c');


[out6,t6] = SOC(crop_ref6,QEi,CIE_D65_E,0,0,adc_bits,0, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,100,'scene6_ideal');
[out6,t6] = SOC(crop_ref6,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,100,'scene6_noise');
[out6,t6] = SOC(crop_ref6,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,10,'scene6_10');
[out6,t6] = SOC(crop_ref6,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,1,'scene6_1a');
[out6,t6] = SOC(crop_ref6,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,1,'scene6_1b');
[out6,t6] = SOC(crop_ref6,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,1,'scene6_1c');

[outm,tm] = SOC(crop_machbeth,QEi,CIE_D65_E,0,0,adc_bits,0, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,100,'macbeth_ideal');
[outm,tm] = SOC(crop_machbeth,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,100,'macbeth_noise');
[outm,tm] = SOC(crop_machbeth,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,10,'macbeth_10');
[outm,tm] = SOC(crop_machbeth,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,1,'macbeth_1a');
[outm,tm] = SOC(crop_machbeth,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,1,'macbeth_1b');
[outm,tm] = SOC(crop_machbeth,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise, blind_detect_alpha,bilateral_sigma_d,bilateral_sigma_r,additional_rows,exposure_time,1,'macbeth_1c'); 


