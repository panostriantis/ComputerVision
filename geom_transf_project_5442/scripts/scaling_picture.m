%% script gia thn eikona pou zhth8hke se diafores klimakes

close all; clear all; clc

moon = im2double(imread('redmoon.jpg'));
red_moon = imresize(moon,[375 500]);

backgr = zeros(2*size(red_moon,1),2*size(red_moon,2),3);
rout = imref2d(size(backgr));
tx = min(rout.XWorldLimits);
ty = min(rout.YWorldLimits);
tx1 = mean(rout.XWorldLimits);
ty1 = mean(rout.YWorldLimits);
counter = 0;

% edw ginetai h klimakwh ths eikonas (th mikrainw) kai topo8eteitai mesa se
% ena mauro plaio apo thn imwarp ka8ws xrhsimopoiw to imref2d kai kanw
% translation ta apotelesmata mesa se ena "background" poy exei to mege8os
% pou exw epile3ei sto imref2d
for i = 1:6
    if i<=1
        j = 0;
    elseif i>1
        counter = counter+1;
        j = 1*counter;
    end
    a = [1/i 0 0;
        0 1/i 0;
        tx1-tx1/i ty1-ty1*j/i 1];
    aff =  affine2d(a);
    im = imwarp(red_moon,aff,'OutputView',rout);
    img_n{i,1} = im;
end

% edw ginetai mia aplh enwsh twn apotelesmatwn pou epitygxanetai me
% pros8esh twn eikonwn
scaling = img_n{1}+img_n{2}+img_n{3}+img_n{4}+img_n{5}+img_n{6};

% edw gia na er8w se ena apotelesma pio wraio kanw to e3hs
% arxika me to transpose gyrizw thn eikona kai th kanw meta ena rotation
% se oles tis diastaseis ths kai th pros8etw me thn eikona apo pio panw
for i = 1:3
    scale(:,:,i) = scaling(:,:,i)';
end
scale_tel = scaling + imrotate(scale,-90);
figure,imshow(scale_tel)

% me thn imwrite egine h apo8hkeush ths eikonas
% imwrite(scale_tel,'feggari_scale.jpg')