%% function laplace_pyramid
% h laplace pyramida twn eikonwn
% img
% parousiash : epiloges on || keno || off. gia on tote me imshow
% parousiazontai ta epipeda ths pyramidas pou dhmiourgeitai
% gia off || keno de parousiazontai ta epipeda ths pyramidas

function [gauss_imgs, laplace_imgs] = laplacian_pyramid(img,levels,parousiash)
% arxika kaleitai h gauss_pyramid kai epeita me bash th 8ewria
% dhmiourgeitai h pyramida laplace
laplace_imgs = cell(levels+1,1);
if exist('parousiash','var')
    gauss_imgs = gauss_pyramid(img,levels,parousiash);
else gauss_imgs = gauss_pyramid(img,levels);
end
for i = 1:levels+1
    if i<levels+1
        temp_img = gauss_imgs{i,1}-imresize(gauss_imgs{i+1,1},...
            [size((gauss_imgs{i,1}),1),size((gauss_imgs{i,1}),2)]);
        laplace_imgs{i,1} = temp_img;
    elseif i==levels+1
        laplace_imgs{i,1} = gauss_imgs{i,1};
    end
end
if exist('parousiash','var') && strcmp(parousiash,'on')==1
    for j = 1:levels+1
        i = levels+1;
        figure(i+j),imshow(laplace_imgs{j,1})
    end
elseif exist('parousiash','var') && strcmp(parousiash,'off')==1 || ~exist('parousiash','var')
    disp('oi eikones de parousiazontai')
end
end