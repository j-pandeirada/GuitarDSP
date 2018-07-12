clear all
%load clean guitar sample
[sample,fs] = audioread('cleanguitar_sample.wav');%fs->sampling freq
%to test if the file loaded successfully  run -> sound(sample,fs)

%delay is a flanger that has a bigger delay(10-25ms)

%lets generates a 1Hz sin that oscilates between 10-25 ms of
%amplitude -> oscilating delay
t=1:length(sample);
max_delay = 0.025;
min_delay = 0.010;
center_delay = (max_delay+min_delay)/2;
rate = 1;%-> how fast the delay oscilates, gives the rate of the chorus
osc_delay = (max_delay-center_delay).*sin(2*pi.*t.*(rate/fs))+center_delay;

plot(t,osc_delay);
max_delayunits = ceil(max_delay*44100);
for i=max_delayunits:length(sample),
    time_delay = osc_delay(i);
    
    %since fs = 44100, it means that 1 second of duration is 44100 values in
    %the vector, so, if we shift exactly 44100 samples we get a delay of 1 second 
    %the equations that generates the number of units to shift giving a
    %specific time delay is:
    n = ceil(44100*time_delay); %units to shift


    %finally we sum the two
    final_sample(i,:) = sample(i,:) + sample(i-n,:);
end

sound(final_sample,fs)