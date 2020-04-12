function [ out_rgb ] = ccm( in_rgb )

% Color correct using pre set machbeth calibration 

global PERFORM_MACBETH_CALIBRATION_FLAG; % Used for calibration CCM

if (PERFORM_MACBETH_CALIBRATION_FLAG)
    G=Find_Machbath_Coeefs(in_rgb);
else
    load('Color_Correction_Matrix.mat','G');
end

G=G';
out_rgb = zeros(size(in_rgb));
in_rgb = double(in_rgb);
for i=1:3,
        out_rgb(:,:,i) = in_rgb(:,:,1)*G(i,1) + in_rgb(:,:,2)*G(i,2) + in_rgb(:,:,3)*G(i,3) ;
end
out_rgb = uint16(out_rgb);

end

