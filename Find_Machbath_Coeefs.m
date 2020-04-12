function G=Find_Machbath_Coeefs(in_rgb)

macbath; % load mecbath

QE_xi = linspace(400,720,(720-400+10)/10);
Fx = Mecbatc(  2 :end, 1);
figure(4);
%for i=1:4,
    i=1;
    for j=1:6,
        F = Mecbatc(  2 :end, (i-1)*6+j+1);
        F1 = interp1(Fx,F,QE_xi);
        plot(Fx,F,'.',QE_xi,F1,'-O'); hold on;
        grid on;
    end
%end
hold off;

Macbath_BMP = imread('E:\My Documents\ליאור\לימודים\מבוא למצלמות\macbeth.bmp');
C=25; D = C+5; % Color grid

% Get a CCD sample for each color
M1=zeros(1,24,3);
l=0;
for j=1:6,
    for i=1:4,
            l=l+1;
            for k=1:3
                M1(1,l,k)=floor(mean(mean(in_rgb(  (i-1)*D+1:(i-1)*D+C,    (j-1)*D+1:(j-1)*D+C ,k  ))));
            end
     end
end

% Get a "true" sample for each color
Mc = double(Macbath_BMP(1:150,1:220,:))*4;
L=floor([19.0181   23.4940    19.6835   57.4254   19.9052   93.1310   19.0181  129.2802   54.9456   22.8286   54.5020   57.8690   53.6149   92.9093   53.8367  127.5060   89.0988   22.1633   88.8770   56.7601   89.3206   90.9133   88.4335  127.5060  124.8044   20.8327  121.9214   57.2036  121.0343   93.3528  125.4698  127.9496  157.8488   20.1673  158.7359   56.3165  158.9577   91.3569  159.6230  129.7238  192.8891   21.0544  194.4415   59.4214  193.9980   94.0181  193.7762  127.2843]);
x = L(1:2:end); y = L(2:2:end);
M2 = zeros(1,24,3);
for i=1:length(x),
    for k=1:3,
        M2(1, i,k)= Mc(y(i),x(i),k);
    end
end

% Calculate Correction Matrix G
M2= double(M2); M1 = double(M1);
M2S = squeeze(M2);
M1S = squeeze(M1);
G=M1S\M2S;

M3 = zeros(1,24,3);
M3(1,:,:) = squeeze(M1)*G; 

figure(6);
    hold on;
    grid on;
    Red         = abs(M2(1,:,1)-M3(1,:,1)) - abs(M2(1,:,1)-M1(1,:,1));
    Green   = abs(M2(1,:,2)-M3(1,:,2)) - abs(M2(1,:,2)-M1(1,:,2));
    Blue   = abs(M2(1,:,3)-M3(1,:,3)) - abs(M2(1,:,3)-M1(1,:,3));
    plot(-Red-Green-Blue,'k-o'); 

    plot(-Red,'r-o'); 
    plot(-Green,'g-o'); 
    plot(-Blue,'b-o');
    axis([1 24 -200 200 ]);
    hold off;

% Compare results
M1 = uint16(M1);
M2 = uint16(M2);
M3 = uint16(M3);

figure;
subplot(2,2,1);imshow(reshape(64*M2(:),[4,6,3]));title('Machbath');
subplot(2,2,2);imshow(reshape(64*M1(:),[4,6,3]));title('Before CCM');
subplot(2,2,3);imshow(reshape(64*M3(:),[4,6,3]));title('After CCM');

save('Color_Correction_Matrix.mat','G');

end
