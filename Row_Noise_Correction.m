function sensor_bayer_out = Row_Noise_Correction(sensor_bayer,maxy,maxx,additional_rows);

% Row noise level estimation per row 
% we assume our additional rows (which don't accept photons) are on the right
Black_coloumns = sensor_bayer(:,maxx+1:maxx+additional_rows);

% calculating the mean over these rows
Row_Optical_Black_Mean = mean(Black_coloumns,2);


% Prepare the correction matric
Row_Noise_Estimation = Row_Optical_Black_Mean*(ones(1,maxx));

% correct for row noise , using integers to mimic HW
sensor_bayer_out = uint16((sensor_bayer(:,1:maxx) - uint16(Row_Noise_Estimation)));

end
