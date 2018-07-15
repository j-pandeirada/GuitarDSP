clear all
%load clean guitar sample
[sample,fs] = audioread('acoustic.wav');%fs->sampling freq
%to test if the file loaded successfully  run -> sound(sample,fs)

%wah wah is a band pass filter where the center frequency changes over time
%in order to do that we need the difference equations for a band pass
%filter, since it is more usefull for real time than the frequency response
%we can use the difference equations of a state variable filter that are
%already known
%yl(n) = F1*yb(n) + yl(n-1)
%yb(n) = F1*yh(n) + yb(n-1)
%yh(n) = x(n) - yl(n-1) - Q1yb(n-1)
%where F1 = 2sin(pi*(fc/fs)) and Q1 = 2d
%this way we control de cut off frequency fc and damping d

%create vector of frequencies
%will be a rectangular wave of frequencies, ranging from
%fc_min and fc_max
fc_center = 2000;
fc_max = 4000;
fc_min = 500;
fc = fc_min;
while(length(fc) < length(sample)),
    fc = [fc fc_min:fc_center/fs:fc_max fc_max:-fc_center/fs:fc_min];
end

%create F1 and Q1
d = 0.05; %the lower the smaller is the band pass
F1 = 2*sin(pi*(fc./fs)); Q1 = 2*d;

%initial conditions
yh(1) = sample(1);
yb(1) = F1(1)*yh(1);
yl(1) = F1(1)*yb(1);

t = 1:length(sample);

%now lets pass our audio sample trough the state variable filter
for n=2:length(sample);
    yh(n) = sample(n) - yl(n-1) - Q1*yb(n-1);
    yb(n) = F1(n)*yh(n) + yb(n-1);
    yl(n) = F1(n)*yb(n) + yl(n-1);
end

%normalize
final_sample = yb./max(abs(yb));

%yb is the output the gives us the wah wah effect
%sound(final_sample,fs)



