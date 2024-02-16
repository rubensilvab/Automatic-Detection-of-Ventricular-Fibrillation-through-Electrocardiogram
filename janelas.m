function[ecg,ffc,Esco,freq_med,F1]=janelas(yecg1,fa,tj)
%janelas com 50% sobreposiçao
%tj- Tempo da jenela em segundos
%fa-Frequeência de amostragem

N=fa*tj; %tj s amostras

L=1:(N)/2:length(yecg1)+1; inic=L(1);

for i=2:length(L);
    if L(i)~=L(end)
    ecg(:,i-1)=yecg1(inic:L(i)+((N)/2)-1);
    inic=L(i);

    reswelch=0.5;
    Npw=fa/reswelch;
    [Sw(:,i-1),fw]=pwelch(ecg(:,i-1),ones(1,Npw),0.5*Npw,Npw,'power',fa);
%Frequência Fundamental
    indc=find(Sw(:,i-1)==max(Sw(:,i-1)));
    ffc(:,i-1)=fw(indc);% controlo

%Energia do sinal CONTROLO
    Esc(:,i-1)=mean(ecg(:,i-1).^2);
%Potência do sinal controlo
    Esco(:,i-1)=sum(Sw(:,i-1));
%Nomrmalizar S controlo
    NormS(:,i-1)=Sw(:,i-1)./Esco(:,i-1);
%freq media controlo
    freq_med(:,i-1)=sum(NormS(:,i-1).*fw);
%image-fase
    [F1(:,i-1)]=convert_graph_to_binary(ecg(:,i-1));
    end
end
