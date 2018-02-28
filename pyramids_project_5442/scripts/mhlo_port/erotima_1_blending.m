%% erotima 1 kanei blend tis eikones apple.jpg & orange.jpg

mask_ap_or = im2double(imread('mask_ap_or.png'));
apple = im2double(imread('apple.jpg'));
orange = im2double(imread('orange.jpg'));

[pyramida_mi3hs,mhlo_portokali] = blending2imgs(mask_ap_or,apple,orange,6,'on');
[~,apple_lp_pyr] = laplacian_pyramid(apple,6);
[~,orange_lp_pyr] = laplacian_pyramid(orange,6);

% to kommati auto htan gia na bgalw tis eikones se ena figure gia ola ta
% epipeda (shmeiwsh oti to mikrotera epipeda fainetai me tatragwnakia giati
% einai poly mikra se mege8os ,ta3hs 7x13....

% figure
% for i = 1:7
%     subplot(3,3,i),subimage(pyramida_mi3hs{i,1});
% end
% figure
% for i = 1:7
%     subplot(3,3,i),subimage(apple_lp_pyr{i,1})
% end
% figure
% for i = 1:7
%     subplot(3,3,i),subimage(orange_lp_pyr{i,1})
% end