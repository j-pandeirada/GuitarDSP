clear all
%load clean guitar sample
[sample,fs] = audioread('cleanguitar_sample.wav');%fs->sampling freq
%to test if the file loaded successfully  run -> sound(sample,fs)

%now we emulate the overdrive effect
clip_value = 50; %-> here we define how much distortion we want

%first we amplify 
distort_sample = 1000.*sample;
%after amplified we need to clip the signal to create the distortion effect
distort_sample = (abs(distort_sample)<clip_value).*distort_sample + ...
                 (abs(distort_sample)>clip_value).*clip_value;
%now we attenuate so we dont fuck up our ears
distort_sample = distort_sample./1000;

sound(distort_sample,fs)




%% lets see the frequency components, just for fun
df = fs/length(sample);
f = 0:df:fs-df;

samplef=fft(sample);
mod_samplef = abs(samplef);
figure,stem(f(1:length(f)/2),mod_samplef(1:length(f)/2));
