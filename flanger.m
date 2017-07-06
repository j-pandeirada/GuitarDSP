clear all
%load clean guitar sample
[sample,fs] = audioread('cleanguitar_sample.wav');%fs->sampling freq
%to test if the file loaded successfully  run -> sound(sample,fs)

%flanger is a time varying delay that oscillates

%lets generates a 1Hz sin that oscilates between 0-15 ms of
%amplitude -> oscilating delay
t=1:length(sample);
max_delay = 0.015; %-> 'depth' of the flanger, can vary between 3 and 15 ms
rate = 2;%-> how fast the delay oscilates, gives the rate of the flanger
osc_delay = (max_delay/2).*sin(2*pi.*t.*(rate/fs))+(max_delay/2);

plot(t,osc_delay);
max_delayunits = ceil(0.015*44100);
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