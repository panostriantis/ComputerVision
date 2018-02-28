%% synarthsh blending2imgs
% h synarthsh auth dhmiourgh8hke gia na kanei blend se 2 eikones
% afou dw8ei h maska kai oi eikones pou 8eloume mporoume na epile3oume kai
% posa epipeda pyramidas 8a kanei kai sth synexeia kalei tis synarthseis
% gia na kanei th mi3h
% mask : h maska me thn opoia 8a syn8esoume thn eikona pou 8eloume
% img_a , img_b : oi eikones pou 8eloume na syn8esoume
% levels : ta epipeda pyramidwn pou 8eloume na dhmiourghsoume 
% parousiash : epiloges on || keno || off, gia on || keno tote me imshow
% parousiazontai ta epipeda ths pyramidas pou dhmiourgeitai
% gia off || keno de parousiazontai ta epipeda ths pyramidas
% blend : h laplacianh pyramida me mi3h
function [blend,blended_img] = blending2imgs(mask,img_a,img_b,levels,parousiash)
[xa,ya,~] = size(img_a);
[xb,yb,~] = size(img_b);

% edw apofasizoume poio 8a einai to mege8os ths eikonas pou 8a dhmiourgh8ei
% (exw epile3ei na pairnei sa mege8os th megalyterh eikona)
% kai sth synexeia me thn imresize tis kanoume oles to idio mege8os
if xa>xb
    M = xa;
elseif xa==xb
    M = xa;
else M = xb;
end

if ya>yb
    N = ya;
elseif ya==yb
    N = ya;
else N = yb;
end

mask = imresize(mask,[M N]);
img_a = imresize(img_a,[M N]);
img_b = imresize(img_b,[M N]);

% kaloume tis synarthseis gauss_pyramid gia th maska kai laplacian_pyramid
% gia tis eikones pou 8a syn8esoume
if exist('parousiash','var')
    [gauss_mask] = gauss_pyramid(mask,levels,parousiash);
    [gauss_img_a, laplace_img_a] = laplacian_pyramid(img_a,levels,parousiash);
    [gauss_img_b, laplace_img_b] = laplacian_pyramid(img_b,levels,parousiash);
else [gauss_mask] = gauss_pyramid(mask,levels);
    [gauss_img_a, laplace_img_a] = laplacian_pyramid(img_a,levels);
    [gauss_img_b, laplace_img_b] = laplacian_pyramid(img_b,levels);
end

blend = cell([levels+1,1]);

% edw pollaplasiazontas ta epipeda ths maskas me ta epipeda twn laplacianwn
% pyramidwn twn eikonwn kai ta pros8etoume gia na ginei h syn8esh
for j = 1:levels+1
    blend{j,1} = (1-gauss_mask{j,1}).*laplace_img_a{j,1} + gauss_mask{j,1}.*laplace_img_b{j,1};
end

% 8etoume to teleutaio epipedo ths mi3hs pou egine pio panw san blended_img
blended_img = blend{end,1};

% edw pros8etoume to blended_img me ta prohgoumena epipeda tou, anadromika
% dhladh to megalwnoume kai to pros8etoume sto prohgoumeno, meta to
% apotelesma ths pros8eshs me to prohgoumeno akomh ews otou ftasoume sto
% epipedo 0 , dhladh to epipedo ths arxikhs eikonas (ths mi3hs dhladh)
for i = (levels):-1:1
    [m,n,~] = size(blend{i,1});
    blended_img = imresize(blended_img,[m n]); 
    blended_img = blended_img + blend{i,1};
end
if exist('parousiash','var') && strcmp(parousiash,'on')==1
    figure(2*levels+1),imshow(blended_img)
elseif exist('parousiash','var') && strcmp(parousiash,'off')==1 || ~exist('parousiash','var')
    disp('oi eikones de parousiazontai')
end
end