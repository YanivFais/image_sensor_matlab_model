function [ bayer_colors ] = bayer_colors( maxy,maxx )
% Create color map for the bayer matrix, each index will contain 
% 1 for  Red,2 for Green and 3 for Blue

bayer_colors = zeros(maxy,maxx,'uint8');
for y= 1 : maxy
    for x = 1 : maxx
            color_idx = 0;
            if (rem(y,2)==1)
               if (rem(x,2)==1)
                  color_idx = 1; %RED 
               else
                  color_idx = 2; % GREEN
               end
            else
               if (rem(x,2)==1)
                  color_idx = 2;  % GREEN
               else
                  color_idx = 3;  % BLUE
               end
            end
            bayer_colors(y,x) = color_idx;
    end
end

end

