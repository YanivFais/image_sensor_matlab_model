function [ out_rgb ] = post_isp( in_rgb ,adc_bits,file)   
out_rgb = in_rgb;

%Save to file, need to squeeze back to 8 bits since 16 bits is only for
%grayscane
fname = sprintf('%s_final.jpg',file);
imwrite(uint8(out_rgb/2^(adc_bits-8)),fname,'JPG','Quality' ,95);
end

