%% pudding motion script

close all; clear all; clc

img = imread('pudding.png','BackgroundColor',[1;1;1]);

%gyrname anapoda tis eikones giati an tis metasxhmatisoume tis eikones
%kanonika o patos ths poutigkas gyrizei kai de menei sta8eros logw tou
%mege8ous ths
for j = 1:3
    im(:,:,j) = flipud(img(:,:,j));
end

%ftiaxnoume 2 cell gia na apo9hkeusoume ta frames pou apaitountai gia na
%dhmiourgh8ei h kinhsh pou 8eloume
%sto gyrth1 apo8hkeuoume thn kinhsh pros ta de3ia kai sto gyrth2
%apo8hkeuoume th kinhsh pros ta aristera
gyrth1 = cell([25,1]);
gyrth2 = cell([25,1]);

imm = ones(512,512,3);
rout = imref2d(size(imm));

    
for i1 = 0:24
    x = i1*0.01;
    a = [1 0 0;
        x 1 0;
        125 125 1;];
    metasx = affine2d(a);
    gyr = imwarp(im,metasx,'FillValues',255,'OutputView',rout);
    gyrth1{i1+1,1} = gyr;
end
%edw afoy exoume apo8hkeusei th kinhsh pros ta de3ia sto gyrth1
%dhmiourgoume ena allo cell , to gyrth1_2 to opoio einai h kinhsh pou
%periexei to gyrth1 alla anti8eta, dhladh apo de3ia mexri thn arxikh 8esh
gyrth1_2 = flipud(gyrth1);

%h idia diadikasia epanalamvanetai kai gia th kinhsh pros ta aristera opws
%sto gyrth1
for i2 = 0:24
    x2 = i2*(-0.01);
    a2 = [1 0 0;
        x2 1 0;
        125 125 1;];
    metasx2 = affine2d(a2);
    gyr2 = imwarp(im,metasx2,'FillValues',255,'OutputView',rout);
    gyrth2{i2+1,1} = gyr2;
end
gyrth2_2 = flipud(gyrth2);

%dhmiourgia enos cell pou 8a periexei ola ta frames
f1 = cell([100,1]);

%edw apo8hkeuoume sto cell f1 ola ta frames pou dhmiourghsame (synolika ta
%frames einai (25 + 25)*2 ara 100)
%apo 1:50 ta frames einai kinhshs apo th kanonikh 8esh ews de3ia kai pali pisw
%enw 50:100 ths aristerhs ews to kentro kai pali pisw

for i = 1:100
    if i <=25
        f1{i,1} = gyrth1{i,1};
    end
    if i>=26 && i<=50
        f1{i,1} = gyrth1_2{i-25,1};
    end 
    if i>=51 && i<=75
        f1{i,1} = gyrth2{i-50,1};
    end
    if i>=76 && i<= 100
        f1{i,1} = gyrth2_2{i-75,1};
    end
    f1{i,1} = imresize(f1{i,1},[256 256]);
end

%pleon anapodogyrizontai ola ta frames outws wste h eikona na parei th
%kanonikh ths morfh
for jk = 1:100
    for jj = 1:3
        f1{jk,1}(:,:,jj) = flipud(f1{jk,1}(:,:,jj));
    end
end

%telika dhmioyrgeitai ena struct me thn im2frame pou metatrepei tis
% parapanw eikones se frames
for vid = 1:100
    f(vid) = im2frame(f1{vid,1});
end

%to teliko video
implay(f,25)