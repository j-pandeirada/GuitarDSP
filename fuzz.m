clear all
%load clean guitar sample
[sample,fs] = audioread('cleanguitar_sample.wav');%fs->sampling freq
%to test if the file loaded successfully  run -> sound(sample,fs)

%fuzz is a completely non linear behaviour, harder and harsher than
%distorion
%to implement the fuzz we willo use a non linear exponential function
%f(x) = x/abs(x) * (1-exp((alpha*x^2)/abs(x)))
%where alpha controls the level of distortion

alpha = 11;

%pass the two signals trough the nonlinear function
final_sample(:,1) = (sample(:,1)./(abs(sample(:,1)))).* ...
              (1-exp((alpha.*sample(:,1).^2)./abs(sample(:,1))));  
final_sample(:,2) = (sample(:,2)./(abs(sample(:,2)))).* ...
            (1-exp((alpha.*sample(:,2).^2)./abs(sample(:,2)))); 
        
%sound(final_sample,fs) %->be carefull with volume!