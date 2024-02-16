function[ecgbin,Ntcsc]=TCSCconvert_binary(yecg1,fa)

%Input: yecg1-> ECG
%       fa-> sample frequency

%Output: ecgbin-> binary ECG
%       Ntcsc-> Percentage of samples that exceeded V0

%Thresold for converting to binary
V0=0.2;
for i=1:length(yecg1(1,:))
    for b=1:length(yecg1(:,1))
        if yecg1(b,i)>V0
            ecgbin(b,i)=1;
        elseif yecg1(b,i)<-V0
            ecgbin(b,i)=1;
        else    
            ecgbin(b,i)=0;
        end
    end
    tsamples=length(ecgbin(:,i)); % total samples for each segment
    number1s=sum(ecgbin(:,i));  % number of samples that exceed V0
    
    Ntcsc(i)=(number1s/tsamples)*100;  % Percentage of samples that exceeded V0
      
end
