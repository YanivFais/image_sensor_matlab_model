function [ rgb ] = blind_defect_correct( sfe_rgb,alpha );


size_fe = size(sfe_rgb);
rgb = sfe_rgb;

    % get the min max from a possibly out of bound or incorrect indices
    function [min,max] = get_val(y,x,sy,sx,min,max);
           if (~(sx==0 && sy==0))
               rx = x + sx;
               ry = y + sy;
               if ((rx>0) && (ry>0) && (ry<=size_fe(1)) && (rx <=size_fe(2)))
                    val = sfe_rgb(ry,rx);
                    if (max<val)
                          max = val;
                    end
                    if (min>val)
                          min= val;
                    end
               end
           end
    end

for y = 1: size_fe(1)
    for x = 1: size_fe(2)
        min = 20000;  % larger than 10 bit
        max = -1;
        if (rem(x+y,2)==0) % RED or BLUE
            for sy = -2:2:2
               for sx = -2:2:2
                   [min,max] = get_val(y,x,sy,sx,min,max);
               end
             end
         else % GREEN
            for sy = -2:1:2
               if (abs(sy)==2)
                   minx = 0;
                   maxx = 0;
                   ix = 1;
               elseif (abs(sy)==1)
                   minx = -1;
                   maxx = +1;
                   ix = 2;
               else
                   minx = -2;
                   maxx = +2;
                   ix = 2;                   
               end
               for sx = minx:ix:maxx
                   [min,max] = get_val(y,x,sy,sx,min,max);
               end
            end
        end
        if (sfe_rgb(y,x)<min)
            rgb(y,x) = (1-alpha)*min;            
        end
        if (sfe_rgb(y,x)>max)
            rgb(y,x) = (1+alpha)*max;
        end
    end
end

end

