function [ out_rgb ] = noise_reduce( fe_rgb,bilateral_sigma_d,bilateral_sigma_r,maxy,maxx )


global DISABLE_BILATERAL; % saves run time by not running bilateral filter 

if (DISABLE_BILATERAL==1)
  out_rgb = uint16(bilateralFilter(fe_rgb,bilateral_sigma_d,bilateral_sigma_r,maxy,maxx));
else
  outw_rgb(:,:,1) = wiener2(fe_rgb(:,:,1));
  outw_rgb(:,:,2) = wiener2(fe_rgb(:,:,2));
  outw_rgb(:,:,3) = wiener2(fe_rgb(:,:,3));
  out_rgb = outw_rgb;
end

end

