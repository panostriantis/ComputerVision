%% script gia th dhmiourgia maskas gia to mhlo kai to portokali

close all; clear all; clc

mask_ap_or = zeros(301,420,3);

for i = 210:420
    for j = 1:3
        mask_ap_or(:,i,j) = 1;
    end
end

% imwrite(mask_ap_or,'mask_ap_or.png');