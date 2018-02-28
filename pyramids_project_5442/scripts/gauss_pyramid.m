%% function gauss_pyramid
% pairnei mia eikona pou einai se morfh double kai kai analogws me ton
% ari8mo ,levels, pou dinetai gia to posa epipeda 8eloume na th kanoume
% efoson to epitrepei kai to fysiko mege8os ths eikonas bebaiws

% h gauss_pyramid apo8hkeuei tis eikones pou h epe3ergasia tous ginetai apo
% tis parakatw emfwleumenes synarthseis opou epe3hgountai parakatw pws
% doyleuoun

% img : h eikona mas se morfh img = im2double(imread(.....));
% levels : posa epipeda 8eloume na exei h pyramida, opou to epipedo mhden
% einai to epipedo ths arxikhs eikonas
% imgs : ena cell pou periexei sth prwth 8esh to mhdeniko epipedo ths
% pyramidas k.o.k
% parousiash : epiloges on || keno || off, gia on || keno tote me imshow
% parousiazontai ta epipeda ths pyramidas pou dhmiourgeitai
% gia off || keno de parousiazontai ta epipeda ths pyramidas

function [imgs] = gauss_pyramid(img,levels,parousiash)
imgs = cell(levels+1,1);
imgs{1,1} = img;
if levels>1
    fst_lvl = gauss_filtering(img);
    imgs{2,1} = fst_lvl;
    for i = 2:levels
        next_lvls = gauss_filtering(imgs{(i),1});
        imgs{i+1,1} = next_lvls;
    end
end
if levels==1
    one_lvl = gauss_filtering(img);
    imgs{levels+1,1} = one_lvl;
end
if exist('parousiash','var') && strcmp(parousiash,'on')==1
    for j = 1:levels+1
        figure(j),imshow(imgs{j,1})
    end
elseif exist('parousiash','var') && strcmp(parousiash,'off')==1 || ~exist('parousiash','var')
    disp('oi eikones de parousiazontai')
end
end

%% gauss_filtering
% einai h synarthsh pou pernaei apo filtro tis eikones basei tou dosmenou
% pyrhna
% me bash to pyrhna kai ta dianysmata e1,e2 dhmiourgountai 2 tetragwnikoi 
% pinakes typou Toeplitz o enas (T1) me mege8os oso oi grammes ths eikonas
% kai o allos (T2) oso oi sthles
% pollaplasiazontas thn eikona apo aristera kai de3ia me autous tous
% pinakes epitygxanetai ena filtrarisma twn ypshlwn syxnothtwn
function [new_img] = gauss_filtering(img)

[M,N,i] = size(img);
h = 1/16 * [1; 4; 6; 4; 1];
e1 = eye(1,M);
e2 = eye(1,N);
h1 = [h' zeros(1,M-5)];
h2 = [h' zeros(1,N-5)];
T1 = toeplitz(1/16*e1,h1);
T2 = toeplitz(1/16*e2,h2);
%new_img = img;
for j = 1:i
    new_img(:,:,j) = T1*img(:,:,j)*T2;
end
new_img = downscaling(new_img);

%%edw para8etw th me8odo me syneli3h tou pyrhna pou do9hke me thn eikona
% ker = h*h';
% for i = 1:3
%     new_img(:,:,i) = conv2(img(:,:,i),ker,'same');
% end
% new_img = downscaling(new_img);

end

%% downscaling
% einai h synarthsh pou kanei downscale tis eikones
% opws perigrafhke arxika me th boh9eia tou kronecker kai pali me th
% dhmiourgia 2 pinakwn Dkron1,Dkron2 me mege8h ta misa apo tis
% grammes kai ta misa apo tis sthles antistoixa (mporei ta mege8h na mhn
% einai akribws sth mesh alla na yparxei mia kanonikopoihsh pros ta panw)
% kai ystera me pollaplasiasmo kai pali autwn twn pinakwn apo aristera kai
% de3ia me thn eikona pou  exoume filtrarei parapanw
% to apotelesma einai na pairnoume th filtrarismenh eikona sto miso mege8os
% ginetai ypotetraplasiasmos
function [new_level_img] = downscaling(new_img)
[M,N,i] = size(new_img);
z = [1 0];
if rem(M,2)==0
    D1 = eye(M/2);
    Dkron1 = kron(D1,z);
    Dkron1 = Dkron1(1:(M)/2,1:M);
    elseif rem(M,2)~=0
        D1 = eye((M+1)/2);
        Dkron1 = kron(D1,z);
        Dkron1 = Dkron1(1:(M-1)/2,1:M);
end
if rem(N,2)==0
    D2 = eye(N/2);
    Dkron2 = kron(D2,z');
    elseif rem(N,2)~=0
        D2 = eye((N+1)/2);
        Dkron2 = kron(D2,z');
        Dkron2 = Dkron2(1:N,1:(N+1)/2);
end

for j = 1:i
    new_level_img(:,:,j) = Dkron1*new_img(:,:,j)*Dkron2;
end
end