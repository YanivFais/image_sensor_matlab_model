function out_rgb=bilateralFilter(in_rgb,sigma_d,sigma_r,maxy,maxx)
% Reduce noise using bilateral filter
% sigma_d - domain std of gaussian spatial convolution
% sigma_r - range std of gaussian range convolution

 
   in_rgbD=double(in_rgb);
   weights=round(5*sigma_d)+1;

    RD=in_rgbD(:,:,1);
    GD=in_rgbD(:,:,2);
    BD=in_rgbD(:,:,3);

  [out_R,out_G,out_B]=bilateralFilterC(RD,GD,BD,maxx,maxy,sigma_d,sigma_r,weights);
  
    x=RD(:);
    out_R(isnan(out_R))=x(isnan(out_R));
    out_R=reshape(out_R,maxy,maxx);

    x=GD(:);
    out_G(isnan(out_G))=x(isnan(out_G));
    out_G=reshape(out_G,maxy,maxx);

    x=BD(:);
    out_B(isnan(out_B))=x(isnan(out_B));
    out_B=reshape(out_B,maxy,maxx);

    out_rgb=zeros(maxy,maxx,3);
    out_rgb(:,:,1)=out_R;
    out_rgb(:,:,2)=out_G;
    out_rgb(:,:,3)=out_B;
end