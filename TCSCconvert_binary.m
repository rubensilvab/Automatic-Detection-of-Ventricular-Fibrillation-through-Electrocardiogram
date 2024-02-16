function[ecgbin,Ntcsc]=TCSCconvert_binary(yecg1,fa)
%Limite para converter para binário
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
    tsamples=length(ecgbin(:,i)); % total de amostras para cada segmento
    number1s=sum(ecgbin(:,i));  % Número de amostras que passaram V0
    
    Ntcsc(i)=(number1s/tsamples)*100;  % percentagem de amostras que ultrapassaram v0
      
end