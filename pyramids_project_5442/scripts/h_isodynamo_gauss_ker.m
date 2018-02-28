%% apodei3h gia to h

close all; clear all; clc



h = 1/16 * [1; 4; 6; 4; 1];
figure,plot(h),title('to h san plot')


% orizw mia diakymansh
s1 = 1.0638;

% enas counter gia na me voh8hsei na apo8hkeusw se dianysma ta apotelesmata
counter_x = 0;
for x = -1.94:.97:1.94
    counter_x = counter_x+1;
    g(counter_x,1) = (1/(s1*sqrt(2*pi)))*exp(-x^2/(2*s1^2)); %gauss me m.t=0
end
figure,plot(g),title('g,pyrhnas sa to h')

% edw 8a kanoume kai surf ta h*h' kai g*g' gia na doume thn omoiothta tous
% kai ws didiastatoi pyrhnes
figure,surf(h*h'),title('h*transpose(h)')
figure,surf(g*g'),title('g*transpose(g)')