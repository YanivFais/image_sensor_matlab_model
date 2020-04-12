function [ rgb] = proj_demosaic(bayer,bayer_map,maxy,maxx )
% Implementing GCB demosaicing by "Malvar,et. al., High quality linear
% interpolation for demosaicing of Bayerpatterned color images”, ICASPP, 2004
%notice for borders we use padd the bayer with the first two rows/columns

padded_bayer = zeros(maxy+4,maxx+4,'uint16'); 

padded_bayer(3:maxy+2,3:maxx+2) = bayer;
padded_bayer(1,3:maxx+2) = bayer(1,:);
padded_bayer(2,3:maxx+2) = bayer(2,:);
padded_bayer(maxy-1,3:maxx+2) = bayer(maxy-1,:);
padded_bayer(maxy,3:maxx+2) = bayer(maxy,:);
padded_bayer(3:maxy+2,1) = bayer(:,1);
padded_bayer(3:maxy+2,2) = bayer(:,2);
padded_bayer(3:maxy+2,maxx+3) = bayer(:,maxx-1);
padded_bayer(3:maxy+2,maxx+4) = bayer(:,maxx);
padded_bayer(maxy+3,3:maxx+2) = bayer(maxy-1,:);
padded_bayer(maxy+4,3:maxx+2) = bayer(maxy,:);
padded_bayer(1:2,1:2) = bayer(1:2,1:2);
padded_bayer(maxy+3:maxy+4,1:2) = bayer(maxy-1:maxy,1:2);
padded_bayer(1:2,maxx+3:maxx+4) = bayer(1:2,maxx-1:maxx);
padded_bayer(maxy+3:maxy+4,maxx+3:maxx+4) = bayer(maxy-1:maxy,maxx-1:maxx);

padded_rgb = zeros(maxy+4,maxx+4,'uint16'); 

for y= 3 : maxy+2
    for x = 3 : maxx+2
         color_idx = bayer_map(y-2,x-2);
         if (color_idx ==1 || color_idx==3) % red or blue
            % First set the pattern for 5 rows , this is assuming color is red
            % for R13
            % but if blue then R is interchanged with B
            %R1   G2   R3   G4   R5
            %G6   B7   G8   R9   G10
            %R11 G12 R13 G14 R15 
            %G16 B17 G18 B19 G20
            %R21 G22 R23 G24 R25
            R3 = padded_bayer(y-2,x);
            R11 =padded_bayer(y,x-2);
            R15 = padded_bayer(y,x+2);
            R23 = padded_bayer(y+2,x);
            dr = padded_bayer(y,x) - (R3+R11+R15+R23)/4;
            G8 = padded_bayer(y-1,x);
            G12 = padded_bayer(y,x-1);
            G14 = padded_bayer(y,x+1);
            G18 = padded_bayer(y+1,x);
            G13 = (G8+G12+G14+G18)/4+dr/2;
            B7 = padded_bayer(y-1,x-1);
            B9 = padded_bayer(y-1,x+1);
            B17 = padded_bayer(y+1,x-1);
            B19 =padded_bayer(y+1,x+1);
            B13 = (B7+B9+B17+B19)/4+3*dr/4;
            padded_rgb(y,x,2) = G13; 
            padded_rgb(y,x,4-color_idx) = B13;
            padded_rgb(y,x,color_idx) = padded_bayer(y,x); %R13
         else % Green - use this formation , assumming looking at G13
        %G1 R2 G3 R4 G5
        %B6 G7 B8 G9 B10
        %G11R12G13R14G15
        %B16G17 B18G19 B20
        %G21R22G23R24G25
             G3 = padded_bayer(y-2,x);
             G7 = padded_bayer(y-1,x-1);
             G9 = padded_bayer(y-1,x+1);
             G11 = padded_bayer(y,x-2);
             G15 = padded_bayer(y,x+2);
             G17 = padded_bayer(y+1,x-1);
             G19 = padded_bayer(y+1,x+1);
             G23 = padded_bayer(y+2,x);
             dGv = padded_bayer(y,x) - (G3+G7+G9+G17+G19+G23-(G11+G15)/2)/5;
             dGh = padded_bayer(y,x) - (G7+G9+G11+G15+G17+G19-(G3+G23)/2)/5;
             R12 = padded_bayer(y,x-1);
             R14 = padded_bayer(y,x+1);
             padded_rgb(y,x,1) = (R12+R14)/2 + 5*dGh/8; % R13
             B8 = padded_bayer(y-1,x);
             B18 = padded_bayer(y+1,x);
             padded_rgb(y,x,3) = (B8+B18)/2 + 5*dGv/8; %B13
             padded_rgb(y,x,2) = padded_bayer(y,x); %G13
         end
    end
end

% remove padding
rgb = padded_rgb(3:maxy+2,3:maxx+2,:);

end

