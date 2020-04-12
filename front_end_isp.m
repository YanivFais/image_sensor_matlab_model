function [ fe_bayer_out ] = front_end_isp( sfe_bayer ,blind_detect_alpha,maxy,maxx,additional_rows);
% front-end ISP , work inside CIS on bayer to produce CIS output by
% removing row noise and fixing defects (hot pixels)

sfe_bayer_less_row_noise = Row_Noise_Correction(sfe_bayer,maxy,maxx,additional_rows);

fe_bayer_out = blind_defect_correct(sfe_bayer_less_row_noise,blind_detect_alpha);

end

