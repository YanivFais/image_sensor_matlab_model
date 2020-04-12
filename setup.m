
compile

%load sensor colors match function 
load QE;
QE_xi = linspace(400,720,(720-400+10)/10);
% interpolate recorded data to be in our range (400-720) with 10 range
clear QEi
QEi(:,:,1) = interp1(QE_Rx,QE_Ry,QE_xi);
QEi(:,:,2) = interp1(QE_Gx,QE_Gy,QE_xi);
QEi(:,:,3) = interp1(QE_Bx,QE_By,QE_xi);
load CIE_D65.mat
CIE_D65_E = zeros(33,2);
for i=1:33 % Align to be from Gamma = 400
    CIE_D65_E(i) = CIE_D65(19+i*2,2);
end

global PERFORM_MACBETH_CALIBRATION_FLAG;
PERFORM_MACBETH_CALIBRATION_FLAG = 0;

% load macbath
macbath; % load mecbath
C=200; D = C+30;
M = zeros(D*4,D*6);
Fx = Mecbatc(  2 :end, 1);
for i=1:4,
      for j=1:6,
           F = Mecbatc(  2 :end, (i-1)*6+j+1);
          F1 = interp1(Fx,F,QE_xi);
         for k=1:33,
                M(  (i-1)*D+1:(i-1)*D+C,    (j-1)*D+1:(j-1)*D+C ,k  ) =  ones(C,C)*F1(k);
         end
     end
end
crop_machbeth = M;
clear M;

%load scene 4
%[BMP4,map4] = imread('..\scene4\cyflower1bb_reg1_2bright.bmp');
load('..\scene4\ref_cyflower1bb_reg1.mat');
crop_ref4 = reflectances;
%crop_ref4 = reflectances(200:400,200:400,:);

%[BMP6,map6] = imread('..\scene6\braga1bb_reg1_2bright.bmp');
load('..\scene6\ref_braga1bb_reg1.mat');
crop_ref6 = reflectances;
clear reflectances;

