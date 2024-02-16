function[ecg]=TCSCjan2(yecg1,fa)
%limite para ser binário V0=0.2
V0=0.2;
tj=3; % segmento analisado 
N=fa*tj; %3s amostras

L=1:(N)/3:length(yecg1)+1; inic=L(1);

for i=2:length(L)-2;
    
    ecg(:,i-1)=yecg1(inic:L(i)+2*((N)/3)-1); % 1s-step
    inic=L(i);
 
    ecgj3=ecg(:,i-1); %ecg janela 3s
    %Multiplicar janela w(t)
    for n=1:fa*1/4 ;
    ecgj3(n)=ecgj3(n)*((1-cos(4*pi*(n/fa)))*0.5);
    end
    for n2=round(N-fa*(1/4)):N;
        ecgj3(n2)=ecgj3(n2)*((1-cos(4*pi*(n2/fa)))*0.5);
    end
    ecgj3=ecgj3/max(ecgj3);
    ecg(:,i-1)=ecgj3;
    end
end
