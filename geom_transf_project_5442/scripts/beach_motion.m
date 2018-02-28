%% script beach_motion

close all; clear all; clc

ball = rgb2gray(im2double(imread('ball.jpg')));
ball_mask = rgb2gray(im2double(imread('ball_mask.jpg')));
beach = rgb2gray(im2double(imread('beach.jpg')));

cmap = gray(256);

ball = imresize(ball,0.125);
ball_mask = imresize(ball_mask,0.125);
beach = imresize(beach,[600 1280]);
rout = imref2d(size(beach));
tx = mean(rout.XWorldLimits);
ty = mean(rout.YWorldLimits);

%ball1 = (1-ball_mask).*(1-ball);
ball1 = 1-ball;
spin = cell([200,1]);
beach_vid = cell([200,1]);

%prwta ginetai o metasxhmatismos pou kanei th mpala na peristrefetai
for i = 0:199
    a = [cos((pi/120)*i) sin((pi/120)*i) 0;
        -sin((pi/120)*i) cos((pi/120)*i) 0;
         0 0 1];
    metasx = affine2d(a);
    temp = imwarp(ball1,metasx);
    spin{i+1} = temp;
end

%ginetai kai edw kanonikopoihsh twn mege8wn twn eikonwn pou prokyptoun apo
%th peristrofh ths eikonas ths mpalas
for ii = 1:200
    [x,y,~] = size(spin{ii,1});
    if x-100>0
        cr = (x-100)/2;
        cr = floor(cr);
        spin{ii,1} = spin{ii,1}((cr+1):x-(cr+1),(cr+1):x-(cr+1),:);
    elseif x-100==0
        spin{ii,1} = spin{ii,1};
    end
end

%edw pleon ginetai o metasxhmatismos gia th kinhsh oloklhrhs ths mpalas
%mesa sth paralia gia auto kai autes oi parametroi sth 3h grammh tou pinaka
%a2 (sth matlab ekei ginetai to translation)
for i = 0:199
    i2 = 200;
    a2 = [1 0 0;
        0 1 0;
        40+3*i 3/2*ty-3/2*abs(i2-i)*abs(cos((i2-i)/16)) 1];
     metasx2 = affine2d(a2);
     temp2 = imwarp(spin{i+1},metasx2,'OutputView',rout);
     beach_vid{i+1} = temp2;
end

%dhmiourgia twn frames
for i = 1:200
    beach_vid{i,1} = (1-beach_vid{i,1}(:,:,:)).*beach(:,:,:);
    beach_mot(i) = im2frame(uint8(round(255*beach_vid{i,1})),cmap);
end
implay(beach_mot,30)