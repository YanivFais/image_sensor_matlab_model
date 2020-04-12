function [ noise_reduce_rgb ] = bayer_demosaicing_isp( fe_isp,bilateral_sigma_d,bilateral_sigma_r ,bayer_map,maxy,maxx,adc_bits,file)

rgb = proj_demosaic(fe_isp,bayer_map,maxy,maxx);    

%Save to file
fname = sprintf('%s_demosaic.jpg',file);
imwrite(uint8(rgb/2^(adc_bits-8)),fname,'JPG')

noise_reduce_rgb = noise_reduce(rgb,bilateral_sigma_d,bilateral_sigma_r,maxy,maxx);
end

