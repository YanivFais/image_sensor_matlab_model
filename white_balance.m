function [ out_rgb ] = white_balance( in_rgb,adc_bits )

    R_ = mean(in_rgb(:,:,1));
    G_ = mean(in_rgb(:,:,2));
    B_ = mean(in_rgb(:,:,2));
     
    Wbr = (R_ + G_ + B_) / (3*R_);
    Wbg = (R_ + G_ + B_) / (3*G_);
    Wbb = (R_ + G_ + B_) / (3*B_);
    
    Wbr = Wbr/min([Wbr,Wbg,Wbb]);
    Wbg = Wbg/min([Wbr,Wbg,Wbb]);
    Wbb = Wbb/min([Wbr,Wbg,Wbb]);
    
    out_rgb = zeros(size(in_rgb));
    out_rgb(:,:,1) = Wbr*in_rgb(:,:,1);
    out_rgb(:,:,2) = Wbg*in_rgb(:,:,2);
    out_rgb(:,:,3) = Wbb*in_rgb(:,:,3);    
 
 % Gain correction
out_rgb = out_rgb* (2^(adc_bits-1))/mean(out_rgb(:));
 
end

