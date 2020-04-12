function sensor_bayer_out = Row_Noise_Creation(row_noise_std,full_well,maxy,maxx,additional_rows)
% Add noise to rows , notice this also creates the matrix with additional
% rows for black (hidden pixels) which don't observe photons and are used
% to detect and remove row noise
Row_Noise_Amp = row_noise_std*full_well;
Row_Noise = abs(Row_Noise_Amp*randn(maxy,1)*ones(1,maxx+additional_rows));

sensor_bayer_out = double(Row_Noise);

end