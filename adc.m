function [ adc_output ] = adc(well,adc_bits)
%Analog to Digital linear simple converter

raw_size = size(well);
adc_output = zeros(raw_size(1),raw_size(2),'uint16');
max = 2^adc_bits;
for y= 1 : raw_size(1)
    for x = 1 : raw_size(2)
        val = uint16(well(y,x));
        if (val>max)
            adc_output(y,x) = max;
        else
            adc_output(y,x) = val;
   end
 end
    
end


