clear all
%load clean guitar sample
[sample,fs] = audioread('acoustic.wav');%fs->sampling freq
%to test if the file loaded successfully  run -> sound(sample,fs)

%phaser is a notch filter->bandstop filter with high damping factor
%with a time varying center frequency
%in order to implement the bandstop filter, we can use a second order peak
%filter:
%y1(n) = cx(n)+d(1-c)x(n-1)+x(n-2)-d(1-c)y1(n-1)+cy1(n-2)
%y(n) = 0.5*(x(n)+-y1(n)) -> + for bandreject and - for bandpass
%where d=-cos(2pifc/fs) and c=tg(2pifc/fs)-1 / tg(2pifc/fs)+1

%create vector of frequencies
%will be a sin wave of frequencies, ranging from
%fc_min and fc_max centered in fc_center
fc_max = 4000;
fc_min = 1000;
fc_center = (fc_max+fc_min)/2;
rate = 0.2;
t = 1:length(sample);
%while(length(fc) < length(sample)),
    %fc = [fc fc_min:1:fc_max fc_max:-1:fc_min];
%end
fc =(fc_max-fc_center).*sin(2*pi.*t.*(rate/fs))+fc_center;


%create d and c
d=-cos(2*pi.*fc./fs);
c=(tand(2*pi.*fc./fs)-1)./(tand(2*pi.*fc./fs)+1);

%initial conditions
y1(1) = c(1)*sample(1);
y(1)  = 0.5*(sample(1)+y1(1));
y1(2) = c(2)*sample(2)+d(2)*(1-c(2))*sample(1)-d(2)*(1-c(2))*y1(1);
y(2)  = 0.5*(sample(2)+y1(2));

for n=3:length(sample),
   y1(n) = c(n)*sample(n)+d(n)*(1-c(n))...
       *sample(n-1)+sample(n-2)-d(n)*(1-c(n))*y1(n-1)+c(n)*y1(n-2);
   y(n)  = 0.5*(sample(n)+y1(n));
end

%normalize  
final_sample = y./max(abs(y));

%sound(final_sample,fs)





