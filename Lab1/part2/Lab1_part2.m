clc;clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reading data from the file
%Note: - time is in miliseconds and framesize is in Bytes
%      - file is sorted in transmit sequence
%  Column 1:   index of frame (in display sequence)
%  Column 2:   time of frame in ms (in display sequence)
%  Column 3:   type of frame (I, P, B)
%  Column 4:   size of frame (in Bytes)
%  Column 5-7: not used
%
% Since we are interested in the transmit sequence we ignore Columns 1 and
% 2. So, we are only interested in the following columns: 
%       Column 3:  assigned to type_f
%       Column 4:   assigned to framesize_f
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[index, time, type_f, framesize_f, dummy1, dymmy2, dymmy3 ] = textread('movietrace.data', '%f %f %c %f %f %f %f');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   CODE FOR EXERCISE 2.2   (version: Spring 2007)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extracting the I,P,B frmes characteristics from the source file
%frame size of I frames  : framesize_I
%frame size of P frames  : framesize_p 
%frame size of B frames  : framesize_B
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=0;
b=0;
c=0;
for i=1:length(index)
    if type_f(i)=='I'
        a=a+1;
        framesize_I(a)=framesize_f(i);
    end
     if type_f(i)=='B'
         b=b+1;
         framesize_B(b)=framesize_f(i);
         end
     if type_f(i)=='P'
         c=c+1;
         framesize_P(c)=framesize_f(i);
     end

end
framesNo = length(index);
totalByte=0;

for i=1:length(index)
    totalByte=totalByte + framesize_f(i);
end

fprintf('there are %d frames and %d bytes totally\n\n',framesNo,totalByte);
minFrSize=min(framesize_f);
maxFrSize=max(framesize_f);
meanFrSize=mean(framesize_f);
fprintf('smallest frame size(in bytes): %d\n',minFrSize);
fprintf('biggest frame size(in bytes):%d\n',maxFrSize);
fprintf('mean frame size(in bytes): %.0f\n\n',meanFrSize);

minISize=min(framesize_I);
maxISize=max(framesize_I);
meanISize=mean(framesize_I);
fprintf('smallest I frame size(in bytes): %d\n',minISize);
fprintf('biggest I frame size(in bytes):%d\n',maxISize);
fprintf('mean I frame size(in bytes): %.0f\n\n',meanISize);

minPSize=min(framesize_P);
maxPSize=max(framesize_P);
meanPSize=mean(framesize_P);
fprintf('smallest P frame size(in bytes): %d\n',minPSize);
fprintf('biggest P frame size(in bytes):%d\n',maxPSize);
fprintf('mean P frame size(in bytes): %.0f\n\n',meanPSize);

minBSize=min(framesize_B);
maxBSize=max(framesize_B);
meanBSize=mean(framesize_B);
fprintf('smallest B frame size(in bytes): %d\n',minBSize);
fprintf('biggest B frame size(in bytes):%d\n',maxBSize);
fprintf('mean B frame size(in bytes): %.0f\n\n',meanBSize);

meanBitRate= (meanFrSize * 8/ (1/30))/(2^20);
fprintf('average bit rate (in mbps): %.2f\n\n',meanBitRate);

peakBitRate= (maxFrSize*8/ (1/30))/(2^20);
fprintf('peak bit rate (in mbps): %.2f \n\n', peakBitRate);

ptomRatio= peakBitRate/meanBitRate;
fprintf('Ratio of the peak rate and the average rate: %.3f\n',ptomRatio);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% start graph part of exercise 2.2
%graph frame size corrsponding to sequence
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
plot(index,framesize_f);
title('Frame size v.s. sequence number');
xlabel('Frame sequence number');
ylabel('Frame size (in bytes)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%I frame size distribution
figure(2);
I_dist=zeros(1,130);
for i=1:length(framesize_I)
    d=framesize_I(i);
    d=d/5120;
    d=int32(d);
    I_dist(d+1)=I_dist(d+1)+1;
end
I_distT=I_dist/length(index);
xl=zeros(1,130);
for i=1:130
    xl(i)=i*5;
end
subplot(3,1,1);bar(xl,I_distT);
title('Distribution of I frames relative to total frames');
xlabel('Frame size (in KB)');
ylabel('Relative frequency');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 P_dist=zeros(1,130);
for i=1:length(framesize_P)
    d=framesize_P(i);
    d=d/5120;
    d=int32(d);
    P_dist(d+1)=P_dist(d+1)+1;
end   
P_distT=P_dist/length(index);
subplot(3,1,2);bar(xl,P_distT);
title('Distribution of P frames relative to total frames');
xlabel('Frame size (in KB)');
ylabel('Relative frequency');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 B_dist=zeros(1,130);
for i=1:length(framesize_B)
    d=framesize_B(i);
    d=d/5120;
    d=int32(d);
    B_dist(d+1)=B_dist(d+1)+1;
end   
B_distT=B_dist/length(index);
subplot(3,1,3);bar(xl,B_distT);
title('Distribution of B frames relative to total frames');
xlabel('Frame size (in KB)');
ylabel('Relative frequency');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(4)
I_dist=I_dist/length(framesize_I);
P_dist=P_dist/length(framesize_P);
B_dist=B_dist/length(framesize_B);
subplot(3,1,1);bar(xl,I_dist);
title('Distribution of I frames relative to total I frames');
xlabel('Frame size (in KB)');
ylabel('Relative frequency');
subplot(3,1,2);bar(xl,P_dist);
title('Distribution of P frames relative to total P frames');
xlabel('Frame size (in KB)');
ylabel('Relative frequency');
subplot(3,1,3);bar(xl,B_dist);
title('Distribution of B frames relative to total B frames');
xlabel('Frame size (in KB)');
ylabel('Relative frequency');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Hint1: You may use the MATLAB functions 'length()','mean()','max()','min()'.
%       which calculate the length,mean,max,min of a
%       vector (for example max(framesize_P) will give you the size of
%       largest P frame
%Hint2: Use the 'plot' function to graph the framesize as a function of the frame
%       sequence number. 
%Hint3: Use the function 'hist' to show the distribution of the frames. Before 
%       that function type 'figure(2);' to indicate your figure number.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   CODE FOR EXERCISE 2.3   (version: Spring 2007)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The following code will generates Plot 1. You generate Plot2 , Plot3 on
%your own. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The next line assigns a label (figure number) to the figure 
figure(3);

initial_point=1;
ag_frame=500;
jj=initial_point;
i=1;
bytes_f=zeros(1,100);
while i<=100
while ((jj-initial_point)<=ag_frame*i && jj<length(framesize_f))
bytes_f(i)=bytes_f(i)+framesize_f(jj);
jj=jj+1;
end
i=i+1;
end
subplot(3,1,1);bar(bytes_f);
title('Plot of video trace data, start at frame 1');
xlabel('Elements (500 frames each)');
ylabel('Number of bytes');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

initial_point=rand;
initial_point=int32(length(index)*initial_point);
ag_frame=50;
jj=initial_point;
i=1;
bytes_f=zeros(1,100);
while i<=100
while ((jj-initial_point)<=ag_frame*i && jj<length(framesize_f))
bytes_f(i)=bytes_f(i)+framesize_f(jj);
jj=jj+1;
end
i=i+1;
end

subplot(3,1,2);bar(bytes_f);
str = sprintf('Plot of video trace data, random start at frame %.0f', initial_point);
title(str);
xlabel('Elements (50 frames each)');
ylabel('Number of bytes');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

initial_point=rand;
initial_point=int32(length(index)*initial_point);
ag_frame=5;
jj=initial_point;
i=1;
bytes_f=zeros(1,100);
while i<=100
while ((jj-initial_point)<=ag_frame*i && jj<length(framesize_f))
bytes_f(i)=bytes_f(i)+framesize_f(jj);
jj=jj+1;
end
i=i+1;
end
subplot(3,1,3);bar(bytes_f);
str = sprintf('Plot of video trace data, random start at frame %.0f', initial_point);
title(str);
xlabel('Elements (5 frames each)');
ylabel('Number of bytes');