%% erotima 2 kanei blend tis eikones woman.png & hand.png

mask_eye = im2double(imread('mask_eye.png'));
hand = im2double(imread('hand.png'));
woman = im2double(imread('woman.png'));

[pyr_mi3hs_lp,xeri_mati] = blending2imgs(mask_eye,hand,woman,5,'on');