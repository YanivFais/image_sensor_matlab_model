function [ CIS_output_bayer ] = CIS(raw_reflectances,QEi,CIE_D65_E,well_noise_percentage,pixel_defect_ppm,adc_bits,row_noise,bayer_map,maxy,maxx,additional_rows,blind_detect_alpha,color_map,exposure_time,exposure_percentage,file)
% This function gets the relectances data from image source , quantum
% efficiency per frequency (from 400 in ranges of 10)
% CIE liminance vector per frequency (from 400 in ranges of 10)
% well noise percentage
% hot pixel defect per million
% analog to digital converter bit width
% and row noise
% The output is the bayer representation of the pixel array after photon
% flux,well current and ADC
% noise is inserted here to model the array behaviour

pixels = ones(maxy,maxx,'uint8');
% need also hot pixels as f(temperature)
hot_pixels = imnoise(pixels,'salt & pepper',pixel_defect_ppm/1E6);
QEi_size = size(QEi);
QEi_size = 26; % ideal cut-off % QEi_size(2);
CIE_D65_E_normalized = (CIE_D65_E)/max(CIE_D65_E);
% We shall use RG/GB bayer, now create the pixel array per color
% this also adds the additional rows (on the right)
bayer_photons = Row_Noise_Creation(row_noise,4.8,maxy,maxx,additional_rows);

Temperature = zeros(maxy,maxx+additional_rows);

for y= 1 : maxy
    for x = 1 : maxx
        if (hot_pixels(y,x)==0)  % insert hot  pixels
            bayer(y,x) = 9E99; % some saturated value
        else
            color_idx = bayer_map(y,x);
            photons = 0;
            for i = 1:1:QEi_size
                QE_color = QEi(1,i,color_idx);
                 photons = photons + raw_reflectances(y,x,i)*CIE_D65_E_normalized(i)*QE_color; 
            end
           bayer_photons(y,x) = photons*exposure_percentage/100;
        end
        Temperature(y,x) = 30+(y/maxy+x/maxx)*5; %  gradient temperature of the pixel array 
   end
end

% supply voltage
Vdd = 2.8;
% reset voltage
Vreset = 0.2;
% electron energy
q = 1.602176462e-19;
% minimum voltage
VFDmin =-32.52; 
% maximum voltage
VFDmax = Vdd-Vreset;

bayer_electrons = (bayer_photons*1E-3)/q;


bayer_VFD = VFDmax-(1.75E-10*sqrt(Temperature + 273)+(7.71E-15)*bayer_electrons)*exposure_time;

% convert to span to our range
bayer = (VFDmax-bayer_VFD)*(2^adc_bits)/(VFDmax-VFDmin);

well_adc_max = 2^adc_bits;
AWGN_noise = well_noise_percentage/100*well_adc_max*randn(maxy,maxx+additional_rows);
noisy_bayer = bayer + AWGN_noise;

% Pass adc_bits bit linear ADC 
bayer16 = adc(noisy_bayer,adc_bits);

%Save to file , need to demosaic to get meaningfull image and reduce to 8
%bits (this is what is supported by MatLab)
fname = sprintf('%s_ADC.jpg',file);
demosaic16 = proj_demosaic(bayer16(:,1:maxx),color_map,maxy,maxx);
imwrite(uint8(demosaic16/2^(adc_bits-8)),fname,'JPG','Quality' ,95)

sensor_bayer = bayer16;

% perform front end image processing, remove row noise and defects (hot
% pixels) , this also removes the additional rows in the matrix
CIS_output_bayer = front_end_isp(sensor_bayer,blind_detect_alpha,maxy,maxx,additional_rows);

end


