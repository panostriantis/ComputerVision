%% windmill motion script

close all; clear all; clc

fter = rgb2gray(im2double(imread('windmill.png')));
windm_back = rgb2gray(im2double(imread('windmill_back.jpeg')));
mask = rgb2gray(im2double(imread('windmill_mask.png')));

cmap = gray(256);
fterh = cell([200,1]);
rout = imref2d(size(windm_back));
tx = mean(rout.XWorldLimits);
ty = mean(rout.YWorldLimits);
fter2 = (1-fter).*(1-mask);
%metasxhmatismos arxikos
% edw pairnoume thn eikona apo thn elika tou anemomylou kai th bazoume na
% kineitai kyklika (rotation)
for i = 0:199
    a = [cos((pi/90)*i) sin((pi/90)*i) 0;
        -sin((pi/90)*i) cos((pi/90)*i) 0;
         0 0 1];
    metasx = affine2d(a);
    gyr = imwarp(fter2,metasx,'Interpolation','linear');
    fterh{i+1,1} = gyr;
end
% kanonikopoioume ta mege8h twn eikonwn meta to metasxhmatismo kai auto
% giati oi eikones pou dhmiourgountai logw tou rotation, prokyptoun k exoun
% diafora mege8h. auto symvainei giati megalwnoun ta boundaries ths eikonas
% otan peristrefetai
for ii = 1:200
    [x,y,~] = size(fterh{ii,1});
    if x-512>0 % ousiastika elegxw poies eikones exoun mege8os megalytero
        cr = (x-512)/2; % apo thn arxikh kai epilegw ta stoixeia pou eixe 
        cr = floor(cr); % h arxikh eikona thn kanw peripoy sto arxiko mege8os
        fterh{ii,1} = fterh{ii,1}((cr+1):x-(cr+1),(cr+1):x-(cr+1),:);
    elseif x-512==0
        fterh{ii,1} = fterh{ii,1};
    end
end
%tis kainouries pleon eikones tis metasxhmatizoume se ena backrgound iso me
%to size tou background mas kai tis topo8etoume sto shmeio peristrofhs me
%th xrhsh toy rout mesa sthn "imwarp"
for i = 1:200
    i2 = i/2;
    a = [1 0 0;
        0 1 0;
        tx/2+50 ty/2-70 1];
    metasx2 = affine2d(a);
    gyr2 = imwarp(fterh{i,1},metasx2,'OutputView',rout,'Interpolation','linear');
    fterh{i,1} = gyr2;
end
%syn8etoume tis eikones pou 8a ginoun frames pleon kai trexoume to implay
for i = 1:200
    fterh{i,1} = (1-fterh{i,1}(:,:,:)).*windm_back(:,:,:);
    %edw sto wndm mesa sto imframe metasxhmatizoume tis eikones pali se
    %uint8 giati alliws de mporousame na xrhsimopoihsoume thn entolh
    %im2frame kai bazoume san colormap to cmap pou to exoume 8esei sthn
    %arxh
    wndm(i) = im2frame(uint8(round(255*fterh{i,1})),cmap);
end
implay(wndm,20)