clc
clear all
close all

fa=250;
load('cu01m.mat');
ecg1=val;

[yecg1,t]=pre_process(ecg1,fa); % pre-processamento


figure()
subplot(211),plot(t(50416:53541),yecg1(50416:53541)),title('ECG CONTROLO')
axis tight;
xlabel('Time in seconds');
ylabel('ECG '); 
subplot(212),plot(t(53541:56541),yecg1(53541:56541)),title('ECG VF')
axis tight;
xlabel('Time in seconds');
ylabel('ECG '); 


%TODO ECG:
%yecg1=yecg1/max(yecg1)
tc=t(1:53541); % pedaço de tempo controlo
ecgc=yecg1(1:53541); %ecg controlo
tVF=t(53541:end); % pedaço de tempo com fibrilação
ecgVF=yecg1(53541:end); % ecg com fibrilação
NC=length(ecgc);
NVF=length(ecgVF);

segm=10000
% segm: nº de amostras extraidas para cada parte do sinal 

tc=tc(1:segm); % pedaço de tempo controlo
ecgc=ecgc(1:segm); %ecg controlo
tVF=tVF(1:segm); % pedaço de tempo com fibrilação
ecgVF=ecgVF(1:segm); % ecg com fibrilação
NC=length(ecgc);
NVF=length(ecgVF);
NVF=length(ecgVF);


figure()
subplot(211),plot(tc,ecgc),title('ECG CONTROLO')
axis tight;
xlabel('Time in seconds');
ylabel('ECG '); 
subplot(212),plot(tVF,ecgVF),title('ECG VF')
axis tight;
xlabel('Time in seconds');
ylabel('ECG '); 

% DOMINIO DAS FREQUÊNCIAS

Necgc=length(ecgc);
NecgVF=length(ecgVF);
res1=fa/Necgc;
res2=fa/NecgVF;

f1=0:res1:(Necgc-1)*res1;
f2=0:res2:(NecgVF-1)*res2;

%fft
figure()
subplot(211),stem(f1,abs(fft(ecgc))),title('Transformada de Fourier ECG CONTROLO');grid on
xlabel('f[Hz]');
ylabel('Modulo');
subplot(212),stem(f2,abs(fft(ecgVF))),title('Transformada de Fourier ECG VF');grid on
xlabel('f[Hz]');
ylabel('Modulo');

% figure()
% stem(f1,abs(fft(ecgc))/max(abs(fft(ecgc)))) ,hold on
% stem(f2,abs(fft(ecgVF))/max(abs(fft(ecgVF))))
% xlabel('f[Hz]');
% ylabel('Modulo');
% legend('Transformada de Fourier ECG sinusal','Transformada de Fourier ECG VF')

figure()
subplot(211),plot(ecgc(1:end-1),ecgc(2:end)),title('fase-image ECG CONTROLO');grid on
xlabel('s');
ylabel('s+1');
subplot(212),plot(ecgVF(1:end-1),ecgVF(2:end)),title('fase-image ECG VF');grid on
xlabel('s');
ylabel('s+1');

figure()
subplot(211),figure(),plot(ecgc(1:end-5),ecgc(6:end)),title('fase-image ECG CONTROLO');grid on
xlabel('s');
ylabel('s+5');
subplot(212),plot(ecgVF(1:end-5),ecgVF(6:end)),title('fase-image ECG VF');grid on
xlabel('s');
ylabel('s+5');
%CONCLUSÃO : FREQUÊNCIA A RONDAR OS 5 HZ em VF

%CONVERSÃO EM BINARIO E EXTRAÇÃO DE UMA MÉTRICA
[F1c]=convert_graph_to_binary(ecgc)
[F1VF]=convert_graph_to_binary(ecgVF)

%PERIODOGRAMA
% Para ter resolução de 0.5 Hz
reswelch=0.5;
Npw=fa/reswelch;
[Sw,fw]=pwelch(ecgc,ones(1,Npw),0.5*Npw,Npw,'power',fa);
[Swf,fwf]=pwelch(ecgVF,ones(1,Npw),0.5*Npw,Npw,'power',fa);

figure()
subplot(2,1,1), plot(fw,10*log10(Sw)), grid on
title('ECG sem VF')
xlabel('f[Hz]');
ylabel('PSD(Db/Hz)');
subplot(2,1,2), plot(fwf,10*log10(Swf)), grid on
title('ECG com VF')
xlabel('f[Hz]');
ylabel('PSD(Db/Hz)');

%Frequência Fundamental
indc=find(Sw==max(Sw));
indf=find(Swf==max(Swf));

ffc=fw(indc);% controlo
ffVf=fwf(indf);%fibrilação

%Energia do sinal CONTROLO
Esc=mean(ecgc.^2);
%Energia do Sinal VF
EsVF=mean(ecgVF.^2);
%Potência do sinal controlo
Esco=sum(Sw);
%Potência sinal VF
EsVF1=sum(Swf);
%Nomrmalizar S controlo
NormS=Sw./Esco;
%freq media controlo
freq_med=sum(NormS.*fw);
%Nomrmalizar S VF
NormSVF=Swf./EsVF1;
%freq media VF
freq_medVF=sum(NormSVF.*fwf);

fprintf(['ECG de ritmo sinusal :\n',' Frequêcia média : ',num2str(freq_med),' Hz\n',' Frequência fundamental de: ',num2str(ffc),' Hz\n',' Potência do sinal de: ',num2str(Esco),' W \n'])
fprintf(['ECG com Fibrilação Ventricular :\n',' A frequêcia média : ',num2str(freq_medVF),' Hz\n',' Frequência fundamental de: ',num2str(ffVf),' Hz\n',' Potência do sinal de: ',num2str(EsVF1),' W \n'])

% JANELAS SINAL PRE-PROCESSADO ORIGINAL

tj=10 %s tempo de cada janela em segundos

[yecg1,t]=pre_process(ecg1,fa);

figure()
plot(tc,ecgc)
xlabel('Time in seconds')
title('Todo o segmento de controlo')

% ECG CONTROLO- VER FREQ.MED , FREQ. FUNDAMENTAL, POTENCIA, COM JANELAS 
[ecg_jane,freq_fundamentaisC,potenciaC,freq_mediasC,F1C]=janelas(ecgc,fa,tj,tc);


figure()
plot([0:length(freq_mediasC)-1]*0.5*tj+tc(1),freq_mediasC)
xlabel('inicio em s de cada janela')
ylabel('f[Hz]')
title('Frequências médias com janelas de 7.5 s com 50% overlap ECG CONTROLO')

figure()
plot([0:length(freq_mediasC)-1]*0.5*tj+tc(1),potenciaC)
xlabel('inicio em s de cada janela')
ylabel('Potencia')
title('Potências ECG CONTROLO')

figure()
plot([0:length(freq_mediasC)-1]*0.5*tj+tc(1),freq_fundamentaisC)
xlabel('inicio em s de cada janela')
ylabel('f[Hz]')
title('Frequências Fundamentais ECG CONTROLO')

figure()
plot([0:length(freq_mediasC)-1]*0.5*tj+tc(1),F1C)
xlabel('inicio em s de cada janela')
ylabel('F1')
title('Feature image-fase ECG CONTROLO')

%ECG VF
figure()
plot(tVF,ecgVF)
xlabel('Time in seconds')
title('Todo o segmento com fibrilação')

[ecg_jane,freq_fundamentaisVF,potenciaVF,freq_mediasVF,F1VFF]=janelas(ecgVF,fa,tj,tVF);



figure()
plot([0:length(freq_mediasVF)-1]*0.5*tj+tVF(1),freq_mediasVF)
xlabel('inicio em s de cada janela')
ylabel('f[Hz]')
title('Frequências médias com janelas de 15 s com 50% overlap-ECG VF')

figure()
plot([0:length(freq_mediasVF)-1]*0.5*tj+tVF(1),potenciaVF)
xlabel('inicio em s de cada janela')
ylabel('Potencia')
title('Potências-ECG VF')

figure()
plot([0:length(freq_mediasVF)-1]*0.5*tj+tVF(1),freq_fundamentaisVF)
xlabel('inicio em s de cada janela')
ylabel('f[Hz]')
title('Frequências Fundamentais -ECG VF')

figure()
plot([0:length(freq_mediasVF)-1]*0.5*tj+tVF(1),F1VFF)
xlabel('inicio em s de cada janela')
ylabel('F1')
title('Feature image-fase -ECG VF')

%%
% BOX PLOTS

figure()
boxplot([freq_mediasC',freq_mediasVF'],{'Sinusal','VF'})
title('Frequências médias')
xlabel('ECGs com :')
ylabel('f[Hz]')

figure()
boxplot([freq_fundamentaisC',freq_fundamentaisVF'],{'Sinusal','VF'})
title('Frequências fundamentais')
xlabel('ECGs com :')
ylabel('f[Hz]')

figure()
boxplot([potenciaC',potenciaVF'],{'Sinusal','VF'})
title('Potências')
xlabel('ECGs com :')
ylabel('W')

figure()
boxplot([F1C',F1VFF'],{'Sinusal','VF'})
title('FASE-IMAGE')
xlabel('ECGs com :')
ylabel('F1(ratio-> number pixeis black/total pixeis) ')

%%
% TCSC Algoritm

%ECG -controlo
[ecgj3tcsc]=TCSCjan2(ecgc,fa) % janela com 1s-step , ou seja 75% sobreposição
figure()
plot(ecgj3tcsc(:,15)),hold on , yline(0.2,'--','V0'),yline(-0.2,'--','V0') 

% figure()
% subplot(211),plot(tc(1*fa:4*fa),ecgc(1*fa:4*fa)),xlabel('time in seconds'),title('ECG')
% xlim([1 4])
% subplot(212),plot(tc(1*fa:4*fa-1),ecgj3tcsc(:,2)),xlabel('time in seconds'),title('ECG depois de passar pela janela w(t)')
% xlim([1 4])

[ecgbin,Ntcsc]=TCSCconvert_binary(ecgj3tcsc,fa)

figure()
plot(ecgbin(:,15)),hold on ,yline(0.2,'--','V0'),yline(-0.2,'--','V0')
ylim([-1 2])

figure()
subplot(211),plot(tc(1:3*fa),ecgj3tcsc(:,1)),hold on ,yline(0.2,'--','V0'),yline(-0.2,'--','V0'),xlabel('time in seconds'),title('ECG normalizado')
subplot(212),plot(tc(1:3*fa),ecgbin(:,1)),hold on ,yline(0.2,'--','V0'),xlabel('time in seconds'),title('ECG convertido em binario')
ylim([-1 2])

% figure()
% subplot(211),plot(tc(2*fa:5*fa-1),ecgj3tcsc(:,3)),hold on ,yline(0.2,'--','V0'),yline(-0.2,'--','V0'),xlabel('time in seconds'),title('ECG normalizado')
% xlim([2 5]);
% subplot(212),plot(tc(2*fa:5*fa-1),ecgbin(:,3)),hold on ,yline(0.2,'--','V0'),xlabel('time in seconds'),title('ECG convertido em binario')
% ylim([-1 2])
% xlim([2 5]);

figure()
plot([0:length(Ntcsc)-1]*1,Ntcsc), title('Percentagem de amostras que passam V0 em ECG controlo 10k')
xlabel('inicio em s de cada janela')
ylabel('N(%)')

%ECG -VF
[ecgj3tcsc]=TCSCjan2(ecgVF,fa) % janela com 1s-step , ou seja 75% sobreposição
figure()
plot(ecgj3tcsc(:,15)),hold on , yline(0.2,'--','V0'),yline(-0.2,'--','V0') 

% figure()
% subplot(211),plot(tVF(1*fa:4*fa),ecgVF(1*fa:4*fa)),xlabel('time in seconds'),title('ECG')
% xlim([min(tVF(1*fa:4*fa)) max(tVF(1*fa:4*fa))]);
% subplot(212),plot(tVF(1*fa:4*fa-1),ecgj3tcsc(:,2)),xlabel('time in seconds'),title('ECG depois de passar pela janela w(t)')
% xlim([min(tVF(1*fa:4*fa-1)) max(tVF(1*fa:4*fa-1))]);



[ecgbin,Ntcsc]=TCSCconvert_binary(ecgj3tcsc,fa)

figure()
plot(ecgbin(:,15)),hold on ,yline(0.2,'--','V0'),yline(0.2,'--','V0')
ylim([-1 2])

% figure()
% subplot(211),plot(tVF(1:3*fa),ecgj3tcsc(:,1)),hold on ,yline(0.2,'--','V0'),yline(-0.2,'--','V0'),xlabel('time in seconds'),title('ECG normalizado')
% subplot(212),plot(tVF(1:3*fa),ecgbin(:,1)),hold on ,yline(0.2,'--','V0'),xlabel('time in seconds'),title('ECG convertido em binario')
% ylim([-1 2])

% figure()
% subplot(211),plot(tVF(2*fa:5*fa-1),ecgj3tcsc(:,3)),hold on ,yline(0.2,'--','V0'),yline(-0.2,'--','V0'),xlabel('time in seconds'),title('ECG normalizado')
% xlim([min(tVF(2*fa:5*fa-1)) max(tVF(2*fa:5*fa-1))]);
% subplot(212),plot(tVF(2*fa:5*fa-1),ecgbin(:,3)),hold on ,yline(0.2,'--','V0'),xlabel('time in seconds'),title('ECG convertido em binario')
% ylim([-1 2])
% xlim([min(tVF(2*fa:5*fa-1)) max(tVF(2*fa:5*fa-1))]);

figure()
plot([0:length(Ntcsc)-1]*1,Ntcsc), title('Percentagem de amostras que passam V0 em ECG VF 20k')
xlabel('inicio em s de cada janela')
ylabel('N(%)')