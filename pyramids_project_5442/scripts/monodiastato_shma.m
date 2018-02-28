%% script gia ena mododiastato shma
% dhmiourgia enos monodiastatou shmatos to opoio pol/zetai me to mhtrwo 
% Toeplitz gia na ginei "filtrarisma" tou shmatos kai na kopoun kapoies
% syxnothtes alla na meinei "idio". gia to logo auto ektos apo tis plot pou
% deixnoun tis times poy pairnei to monodiastato shma to kanw imshow afou
% to pollaplasiasw me anastrofo tou gia na ginei "mhtrwo" kai na exei
% kapoia morfh

close all; clear all; clc

for i = 1:400
y(i,1) = abs(cos(abs(i-401)/4)); % to ebala me abs giati h8ela na pairnei >0 times
end

h = 1/16 * [1; 4; 6; 4; 1];

% epipedo 1
M = length(y);
e1 = eye(1,M);
h1 = [h' zeros(1,M-5)];
T1 = toeplitz(1/16*e1,h1);
filtered_shma = T1*y;
z = [1 0];
D1 = eye(M/2);
Dkron1 = kron(D1,z);
mikro_shma = Dkron1*filtered_shma;

% epipedo 2
m = length(mikro_shma);
e2 = eye(1,m);
h2 = [h' zeros(1,m-5)];
T2 = toeplitz(1/16*e2,h2);
filtered_2 = T2*mikro_shma;
D2 = eye(m/2);
Dkron2 = kron(D2,z);
mikro_shma_2 = Dkron2*filtered_2;

%subplot - plot
figure,subplot(3,1,1),plot(y),title('arxiko shma')
subplot(3,1,2),plot(mikro_shma),title('ypodeigmatolhpthmeno shma')
subplot(3,1,3),plot(mikro_shma_2),title('ypodeigmatolhpthmeno shma 2')

% subplot - subimage
figure,subplot(1,3,1),subimage(y*y'),title('epipedo 1')
subplot(1,3,2),subimage(mikro_shma*mikro_shma'),title('epipedo 2')
subplot(1,3,3),subimage(mikro_shma_2*mikro_shma_2'),title('epipedo 3')