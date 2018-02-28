%% script ekfylismos
% h mpala xanetai sto vathos

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

ball1 = (1-ball_mask).*(1-ball);

spin = cell([200,1]);
beach_vid = cell([200,1]);

%akolou8eitai h idia taktikh opws kai gia th paralia prwta h peristrofh ths
%mpalas
for i = 0:199
    a = [cos((pi/120)*i) sin((pi/120)*i) 0;
        -sin((pi/120)*i) cos((pi/120)*i) 0;
         0 0 1];
    metasx = affine2d(a);
    temp = imwarp(ball1,metasx);
    %spin{i+1,1} = (uint8(round(255*temp)));
    spin{i+1} = temp;
end

%kanonikopoihsh mege8wn twn eikonwn
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

%h epi8ymhth kinhsh ths mpalas sth paralia
for i = 0:199
    i2 = 200;
    % to b einai mia metablhth pou pros8esa gia na e3afanistei h mpala,
    % exei thn idiothta otan ginei ish me to 0 na parameinei mhden giati
    % alliws ginotan pali 1 eite eteine pros to 1 opote h mpala
    % e3afanizotan kai emfanizotan pali
    b = (1-(0.01*(i2-i/1.5)));
    if b<=0
        b = b;
    elseif b>0
        b = 0;
    end
    a2 = [b 0 0;
        0 b 0;
        abs(tx/4+2.8*i) 4.8/3*ty-((i+1)+1/1.7*abs((i2-i)/1.7)*abs(cos(3*(i2-i)/16))) 1];
     
    metasx2 = affine2d(a2);
    temp2 = imwarp(spin{i+1},metasx2,'OutputView',rout);
    beach_vid{i+1} = temp2;
end

%dhmioyrgia twn frames
for i = 1:200
    beach_vid{i,1} = (1-beach_vid{i,1}(:,:,:)).*beach(:,:,:);
    beach_ekfyl(i) = im2frame(uint8(round(255*beach_vid{i,1})),cmap);
end
implay(beach_ekfyl,15)