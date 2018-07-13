clear all
%load clean guitar sample
[sample,fs] = audioread('cleanguitar_sample.wav');%fs->sampling freq
%to test if the file loaded successfully  run -> sound(sample,fs)

%tremolo is a type of amplitude modulation, where a sin wave is modulated
%in amplitude by the audio signal
%tremolo is given by:
%y(t) = (1+alpha*sin(2pi*f*t))*x(t)
%where alpha defines how much depth has the modulation created by the audio
%signal

t = (1:length(sample))';
Fc = 5;
alpha = 0.8;
final_sample(:,1) = (1+alpha.*sin(2*pi*(Fc/fs).*t)).*sample(:,1);
final_sample(:,2) = (1+alpha.*sin(2*pi*(Fc/fs).*t)).*sample(:,2);

%sound(final_sample,fs)