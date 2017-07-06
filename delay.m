clear all
%load clean guitar sample
[sample,fs] = audioread('cleanguitar_sample.wav');%fs->sampling freq
%to test if the file loaded successfully  run -> sound(sample,fs)

%now we emulate the delay effect
%we create a delayed sample by shifting all sample values
delayed_sample =