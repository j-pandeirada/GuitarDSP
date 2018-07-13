clear all
%load clean guitar sample
[sample,fs] = audioread('cleanguitar_sample.wav');%fs->sampling freq
%to test if the file loaded successfully  run -> sound(sample,fs)

%in order to implement overdrive a simple 3 layer non-linear soft
%saturarion function may be used:
%if 0<x<1/3 -> y = 2*x
%if 1/3<x<2/3 -> y = 3-(2-3x)^2 /3;
%%if 2/3<x<3 -> y = 1;

for i=1:length(sample),

   if abs(sample(i,1))<(1/3),
        final_sample(i,1) = 2*sample(i,1);
   end
   
   if abs(sample(i,2))<(1/3),
        final_sample(i,2) = 2*sample(i,2);
   end
   
   if abs(sample(i,1))>=(1/3),
      if sample(i,1)>=0,
          final_sample(i,1) = (3-(2-3*sample(i,1))^2)/3;
      else
          final_sample(i,1) = -(3-(2-3*abs(sample(i,1)))^2)/3;
      end
   end
   
   if abs(sample(i,2))>=(1/3),
      if sample(i,2)>=0,
          final_sample(i,2) = (3-(2-3*sample(i,2))^2)/3;
      else
          final_sample(i,2) = -(3-(2-3*abs(sample(i,2)))^2)/3;
      end
   end
   
   if abs(sample(i,1))>=(2/3),
      if sample(i,1)>=0,
          final_sample(i,1) = 1;
      else
          final_sample(i,1) = -1;
      end
   end
   
   if abs(sample(i,2))>=(2/3),
      if sample(i,2)>=0,
          final_sample(i,2) = 1;
      else
          final_sample(i,2) = -1;
      end
   end
end

%sound(final_sample,fs)
