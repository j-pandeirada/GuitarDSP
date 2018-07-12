clear all
%load clean guitar sample
[sample,fs] = audioread('cleanguitar_sample.wav');%fs->sampling freq
%to test if the file loaded successfully  run -> sound(sample,fs)

%in order to make the most faithfull reverb, we need to have
%an example of how the space that we want to simulate reverberates
%i.e reflects and attenuates the sound waves
%in order to do that we only need to capture de place's impulse response

%load impulse response
[room_sample,room_fs] = audioread('impulse_cathedral.wav');%fs->sampling freq

%now we make the convolution between the room IR and our sample
%this will sum all the attenuated and delayed echos
final_sample(:,1) = conv(sample(:,1),room_sample);
final_sample(:,2) = conv(sample(:,2),room_sample);

%since the amplitudes are all over the place, we have to normalize
final_sample(:,1) = final_sample(:,1)./max(final_sample(:,1));
final_sample(:,2) = final_sample(:,2)./max(final_sample(:,2));

%hint we can also make de convolution in frequency domain, multiplying the
%2 FFT's

sound(final_sample,fs)