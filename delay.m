clear all
%load clean guitar sample
[sample,fs] = audioread('cleanguitar_sample.wav');%fs->sampling freq
%to test if the file loaded successfully  run -> sound(sample,fs)

%now we emulate the delay effect
time_delay = 0.1; %in seconds
gain= 0.6; % 1 for delay effect, differente than one for echo effect

%we create a delayed sample by shifting all sample values
delayed_sample = zeros(size(sample));


%since fs = 44100, it means that 1 second of duration is 44100 values in
%the vector, so, if we shift exactly 44100 samples we get a delay of 1 second 
%the equations that generates the number of units to shift giving a
%specific time delay is:
n = 44100*time_delay; %units to shift

delayed_sample(n+1:end,:) = sample(1:end-n,:); 

%now we attenuate the delayed sample to give the idea of an echo
delayed_sample = delayed_sample.*gain;
%finally we sum the two
final_sample = sample + delayed_sample;

sound(final_sample,fs);

%the only diference between an echo and a delay is the gain factor applied
%to the delayed sample, in fact, to create a more realistic echo effect,
%there should be a relationship between the timedelay and the gain

%also, to create a more robust echo effect, we can add differente delay
%lines with different gains,