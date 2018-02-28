%% script pou kanei mi3h tis 6 eikones

close all; clear all; clc


% arxika diabazoume tis eikones
p200_ar = im2double(imread('P200.jpg'));
bench_ar = im2double(imread('bench.jpg'));
dog = im2double(imread('dog1.jpg'));
dogs = im2double(imread('dog2.jpg'));
meow = im2double(imread('cat.jpg'));
mee = im2double(imread('me.jpg'));

% edw kanoume ena eidous crop epilegontas ta pixels apo tis eikones pou
% 8eloume na kanoume mi3h
dog1(1:1100,1:1300,1:3) = dog(701:1800,1201:2500,1:3);
dog2(1:1100,1:1300,1:3) = dogs(701:1800,1201:2500,1:3);
cat(1:1300,1:1600,1:3) = meow(601:1900,1001:2600,1:3);
me(1:900,1:800,1:3) = mee(251:1150,301:1100,1:3);


% edw ginetai mia smikrynsh ws ekshs
% epilegetai to fonto ths mi3hs na einai oso oi arxikes eikones kai kobetai
% se 6 kommatia sta opoia 8a topo8ethsoume tis eikones mas etsi exoume ta
% e3hs mege8h eikonwn (408,544)
p200 = imresize(p200_ar,[408 544]);
bench = imresize(bench_ar,[408 544]);
dog1 = imresize(dog1,[408 544]);
dog2 = imresize(dog2,[408 544]);
cat = imresize(cat,[408 544]);
me = imresize(me,[408 544]);


% edw pleon epilegoume mesa sto megalo mas fonto th 8esh pou 8a exei h ka8e
% eikona kai meta kanoume padding me mhdenika etsi exoume 6 eikones oi
% opoies periexoun th ka8e eikona ths mi3hs sto epi8ymhto tetragwno
p200_full = [p200 zeros(408,544,3) zeros(408,544,3);
    zeros(408,544,3) zeros(408,544,3) zeros(408,544,3)];
dog1_full = [zeros(408,544,3) dog1 zeros(408,544,3);
    zeros(408,544,3) zeros(408,544,3) zeros(408,544,3)];
bench_full = [zeros(408,544,3) zeros(408,544,3) bench;
    zeros(408,544,3) zeros(408,544,3) zeros(408,544,3)];
cat_full = [zeros(408,544,3) zeros(408,544,3) zeros(408,544,3);
    zeros(408,544,3) zeros(408,544,3) cat];
dog2_full = [zeros(408,544,3) zeros(408,544,3) zeros(408,544,3);
    zeros(408,544,3) dog2 zeros(408,544,3)];
me_full = [zeros(408,544,3) zeros(408,544,3) zeros(408,544,3);
    me zeros(408,544,3) zeros(408,544,3)];


% gia tis maskes isxyei oti isxyei kai pio panw gia tis eikones mas mono
% pou sthn epi8ymhth 8esh ka8e maskas exoume 1 (dhladh ekei p brisketai h
% eikona einai aspro) kai to ypoloipo mauro
mask_p200 = [ones(408,544,3) zeros(408,544,3) zeros(408,544,3);
    zeros(408,544,3) zeros(408,544,3) zeros(408,544,3)];
mask_dog1 = [zeros(408,544,3) ones(408,544,3) zeros(408,544,3);
    zeros(408,544,3) zeros(408,544,3) zeros(408,544,3)];
mask_bench = [zeros(408,544,3) zeros(408,544,3) ones(408,544,3);
    zeros(408,544,3) zeros(408,544,3) zeros(408,544,3)];
mask_cat = [zeros(408,544,3) zeros(408,544,3) zeros(408,544,3);
    zeros(408,544,3) zeros(408,544,3) ones(408,544,3)];
mask_dog2 = [zeros(408,544,3) zeros(408,544,3) zeros(408,544,3);
    zeros(408,544,3) ones(408,544,3) zeros(408,544,3)];
mask_me = [zeros(408,544,3) zeros(408,544,3) zeros(408,544,3);
    ones(408,544,3) zeros(408,544,3) zeros(408,544,3)];

% epeita kata ta gnwsta pairnoume gauss gia tis maskes
gauss_mask_p200 = gauss_pyramid(mask_p200,5,'off');
gauss_mask_dog1 = gauss_pyramid(mask_dog1,5,'off');
gauss_mask_bench = gauss_pyramid(mask_bench,5,'off');
gauss_mask_cat = gauss_pyramid(mask_cat,5,'off');
gauss_mask_dog2 = gauss_pyramid(mask_dog2,5,'off');
gauss_mask_me = gauss_pyramid(mask_me,5,'off');

% laplace gia tis eikones
[~, laplace_p200] = laplacian_pyramid(p200_full,5,'off');
[~, laplace_dog1] = laplacian_pyramid(dog1_full,5,'off');
[~, laplace_bench] = laplacian_pyramid(bench_full,5,'off');
[~, laplace_cat] = laplacian_pyramid(cat_full,5,'off');
[~, laplace_dog2] = laplacian_pyramid(dog2_full,5,'off');
[~, laplace_me] = laplacian_pyramid(me_full,5,'off');

% edw ginetai h mi3h twn laplasianwn eikonwn pros8etontas ta epipeda apo
% tis maskes pollaplasiasmenes me ta antistoixa epipeda twn laplasianwn
% eikonwn
for j = 1:6
    blend{j,1} = laplace_p200{j,1}.*gauss_mask_p200{j,1}...
        + laplace_dog1{j,1}.*gauss_mask_dog1{j,1}...
        + laplace_bench{j,1}.*gauss_mask_bench{j,1}...
        + laplace_cat{j,1}.*gauss_mask_cat{j,1} +...
        + laplace_dog2{j,1}.*gauss_mask_dog2{j,1}...
        + laplace_me{j,1}.*gauss_mask_me{j,1};
end

% pairnoume to teleutaio epipedo kai paremballontas to to pros8etoume sta
% epomena epipeda (dld ta pio xamhla) me th gnwrimh anadromikh sxesh
blended_img = blend{end,1};

for i = 5:-1:1
    [m,n,~] = size(blend{i,1});
    blended_img = imresize(blended_img,[m n]); 
    blended_img = blended_img + blend{i,1};
end

imshow(blended_img)