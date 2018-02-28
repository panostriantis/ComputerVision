%% script pou dhmiourgei th maska gia thn enwsh tou matiou me to xeri

close all; clear all; clc

mask_eye = zeros(190,195,3);
for v = 73:140
    for y = 82:115
        for i = 1:3
            mask_eye(y,v,i) = 1;
        end
    end
end

%imwrite(mask_eye,'mask_eye.png');