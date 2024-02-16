clc
clear all
close all

fa=250;
load('cu01m.mat');
ecg1=val;

[yecg1,t]=pre_process(ecg1,fa); % preprocessing


figure()
subplot(211),plot(t(50416:53541),yecg1(50416:53541)),title('ECG Control')
axis tight;
xlabel('Time in seconds');
ylabel('ECG '); 
subplot(212),plot(t(53541:56541),yecg1(53541:56541)),title('ECG VF')
axis tight;
xlabel('Time in seconds');
ylabel('ECG '); 


%All the ECG:
%yecg1=yecg1/max(yecg1)
tc=t(1:53541); % Time Control
ecgc=yecg1(1:53541); %ecg control
tVF=t(53541:end); % Time with Fibrillation
ecgVF=yecg1(53541:end); % ecg with Fibrillation
NC=length(ecgc);
NVF=length(ecgVF);

segm=10000
% Segm: number of samples extracted for each part of the signal

tc=tc(1:segm); % segment of time Control
ecgc=ecgc(1:segm); %ecg Control
tVF=tVF(1:segm); % segment of time with Fibrillation
ecgVF=ecgVF(1:segm); % ecg with Fibrillation
NC=length(ecgc);
NVF=length(ecgVF);
NVF=length(ecgVF);


figure()
subplot(211),plot(tc,ecgc),title('ECG Control')
axis tight;
xlabel('Time in seconds');
ylabel('ECG '); 
subplot(212),plot(tVF,ecgVF),title('ECG VF')
axis tight;
xlabel('Time in seconds');
ylabel('ECG '); 

% Frequency domain

Necgc=length(ecgc);
NecgVF=length(ecgVF);
res1=fa/Necgc;
res2=fa/NecgVF;

f1=0:res1:(Necgc-1)*res1;
f2=0:res2:(NecgVF-1)*res2;

%fft
figure()
subplot(211),stem(f1,abs(fft(ecgc))),title('Fourier Transform ECG Control');grid on
xlabel('f[Hz]');
ylabel('Modulo');
subplot(212),stem(f2,abs(fft(ecgVF))),title('Fourier Transform ECG VF');grid on
xlabel('f[Hz]');
ylabel('Modulo');

% figure()
% stem(f1,abs(fft(ecgc))/max(abs(fft(ecgc)))) ,hold on
% stem(f2,abs(fft(ecgVF))/max(abs(fft(ecgVF))))
% xlabel('f[Hz]');
% ylabel('Modulo');
% legend('Fourier Transform ECG sinusal','Fourier Transform ECG VF')

figure()
subplot(211),plot(ecgc(1:end-1),ecgc(2:end)),title('fase-image ECG Control');grid on
xlabel('s');
ylabel('s+1');
subplot(212),plot(ecgVF(1:end-1),ecgVF(2:end)),title('fase-image ECG VF');grid on
xlabel('s');
ylabel('s+1');

figure()
subplot(211),figure(),plot(ecgc(1:end-5),ecgc(6:end)),title('fase-image ECG Control');grid on
xlabel('s');
ylabel('s+5');
subplot(212),plot(ecgVF(1:end-5),ecgVF(6:end)),title('fase-image ECG VF');grid on
xlabel('s');
ylabel('s+5');
%Conclusion: Frequency around 5 Hz in VF

%Binary conversion and extraction of a metric
[F1c]=convert_graph_to_binary(ecgc)
[F1VF]=convert_graph_to_binary(ecgVF)

%Periodogram: To achieve a resolution of 0.5 Hz

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
title('ECG with VF')
xlabel('f[Hz]');
ylabel('PSD(Db/Hz)');

%Fundamental Frequency
indc=find(Sw==max(Sw));
indf=find(Swf==max(Swf));

ffc=fw(indc);% Control
ffVf=fwf(indf);%Fibrillation

%Energy of the signal Control
Esc=mean(ecgc.^2);
%Energy of the signal VF
EsVF=mean(ecgVF.^2);
%Power of the signal Control
Esco=sum(Sw);
%Power signal VF
EsVF1=sum(Swf);
%Normalize S Control
NormS=Sw./Esco;
%Average freq. Control
freq_med=sum(NormS.*fw);
%Normalize S VF
NormSVF=Swf./EsVF1;
%Average freq. VF
freq_medVF=sum(NormSVF.*fwf);

fprintf(['Sinus rhythm ECG:\n',' Average frequency: ',num2str(freq_med),' Hz\n',' Fundamental frequency of: ',num2str(ffc),' Hz\n',' Power of the signal: ',num2str(Esco),' W \n'])
fprintf(['ECG with Ventricular Fibrillation:\n',' Average frequency: ',num2str(freq_medVF),' Hz\n',' Fundamental frequency of: ',num2str(ffVf),' Hz\n',' Power of the signal: ',num2str(EsVF1),' W \n'])

% Windows of the pre-processed raw signal

tj=10 %s time of each window in s

[yecg1,t]=pre_process(ecg1,fa);

figure()
plot(tc,ecgc)
xlabel('Time in seconds')
title('All the ECG Control')

% ECG Control - View Average Frequency, Fundamental Frequency, Power, with Windows
[ecg_jane,freq_fundamentaisC,PowerC,freq_mediasC,F1C]=janelas(ecgc,fa,tj,tc);


figure()
plot([0:length(freq_mediasC)-1]*0.5*tj+tc(1),freq_mediasC)
xlabel('Start time of each window (s)')
ylabel('Frequency [Hz]')
title('Average Frequencies with 7.5-second windows with 50% overlap - ECG Control')

figure()
plot([0:length(freq_mediasC)-1]*0.5*tj+tc(1), PowerC)
xlabel('Start time of each window (s)')
ylabel('Power')
title('Powers - ECG Control')

figure()
plot([0:length(freq_mediasC)-1]*0.5*tj+tc(1), freq_fundamentaisC)
xlabel('Start time of each window (s)')
ylabel('Frequency [Hz]')
title('Fundamental Frequencies - ECG Control')

figure()
plot([0:length(freq_mediasC)-1]*0.5*tj+tc(1), F1C)
xlabel('Start time of each window (s)')
ylabel('F1')
title('Feature Image-Phase - ECG Control')


% SAME FOR ECG VF

figure()
plot(tVF, ecgVF)
xlabel('Time in seconds')
title('All the segments with Fibrillation')

[ecg_jane, freq_fundamentaisVF, PowerVF, freq_mediasVF, F1VFF] = janelas(ecgVF, fa, tj, tVF);

figure()
plot([0:length(freq_mediasVF)-1]*0.5*tj+tVF(1), freq_mediasVF)
xlabel('Start time of each window (s)')
ylabel('Frequency [Hz]')
title('Average Frequencies with 15-second windows with 50% overlap - ECG VF')

figure()
plot([0:length(freq_mediasVF)-1]*0.5*tj+tVF(1), PowerVF)
xlabel('Start time of each window (s)')
ylabel('Power')
title('Powers - ECG VF')

figure()
plot([0:length(freq_mediasVF)-1]*0.5*tj+tVF(1), freq_fundamentaisVF)
xlabel('Start time of each window (s)')
ylabel('Frequency [Hz]')
title('Fundamental Frequencies - ECG VF')

figure()
plot([0:length(freq_mediasVF)-1]*0.5*tj+tVF(1), F1VFF)
xlabel('Start time of each window (s)')
ylabel('F1')
title('Feature image-phase - ECG VF')

%%
% BOX PLOTS

figure()
boxplot([freq_mediasC',freq_mediasVF'],{'Sinus','VF'})
title('Average Frequencies')
xlabel('ECGs with :')
ylabel('f[Hz]')

figure()
boxplot([freq_fundamentaisC',freq_fundamentaisVF'],{'Sinus','VF'})
title('Fundamental Frequencies')
xlabel('ECGs with :')
ylabel('f[Hz]')

figure()
boxplot([PowerC',PowerVF'],{'Sinus','VF'})
title('Powers')
xlabel('ECGs with :')
ylabel('W')

figure()
boxplot([F1C', F1VFF'], {'Sinus', 'VF'})
title('Phase Image')
xlabel('ECGs with:')
ylabel('F1 (ratio -> number of black pixels / total pixels)')

%%
% TCSC Algoritm

%ECG -Control
[ecgj3tcsc]=TCSCjan2(ecgc,fa) % window with 1s-step , so 75% overlap
figure()
plot(ecgj3tcsc(:,15)),hold on , yline(0.2,'--','V0'),yline(-0.2,'--','V0') 

% figure()
% subplot(211),plot(tc(1*fa:4*fa),ecgc(1*fa:4*fa)),xlabel('time in seconds'),title('ECG')
% xlim([1 4])
% subplot(212),plot(tc(1*fa:4*fa-1),ecgj3tcsc(:,2)),xlabel('time in seconds'),title('ECG after passing through the window w(t)')
% xlim([1 4])

[ecgbin,Ntcsc]=TCSCconvert_binary(ecgj3tcsc,fa)

figure()
plot(ecgbin(:,15)),hold on ,yline(0.2,'--','V0'),yline(-0.2,'--','V0')
ylim([-1 2])

figure()
subplot(211),plot(tc(1:3*fa),ecgj3tcsc(:,1)),hold on ,yline(0.2,'--','V0'),yline(-0.2,'--','V0'),xlabel('time in seconds'),title('ECG normalize')
subplot(212),plot(tc(1:3*fa),ecgbin(:,1)),hold on ,yline(0.2,'--','V0'),xlabel('time in seconds'),title('binary converted ECG')
ylim([-1 2])

% figure()
% subplot(211),plot(tc(2*fa:5*fa-1),ecgj3tcsc(:,3)),hold on ,yline(0.2,'--','V0'),yline(-0.2,'--','V0'),xlabel('time in seconds'),title('ECG normalize')
% xlim([2 5]);
% subplot(212),plot(tc(2*fa:5*fa-1),ecgbin(:,3)),hold on ,yline(0.2,'--','V0'),xlabel('time in seconds'),title('binary converted ECG')
% ylim([-1 2])
% xlim([2 5]);

figure()
plot([0:length(Ntcsc)-1]*1,Ntcsc), title('Percentage of samples passing V0 in ECG Control 10k')
xlabel('start in s of each window')
ylabel('N(%)')

%ECG -VF
[ecgj3tcsc]=TCSCjan2(ecgVF,fa) % window with 1s-step , so 75% overlap
figure()
plot(ecgj3tcsc(:,15)),hold on , yline(0.2,'--','V0'),yline(-0.2,'--','V0') 

% figure()
% subplot(211),plot(tVF(1*fa:4*fa),ecgVF(1*fa:4*fa)),xlabel('time in seconds'),title('ECG')
% xlim([min(tVF(1*fa:4*fa)) max(tVF(1*fa:4*fa))]);
% subplot(212),plot(tVF(1*fa:4*fa-1),ecgj3tcsc(:,2)),xlabel('time in seconds'),title('ECG after window w(t)')
% xlim([min(tVF(1*fa:4*fa-1)) max(tVF(1*fa:4*fa-1))]);


[ecgbin,Ntcsc]=TCSCconvert_binary(ecgj3tcsc,fa)

figure()
plot(ecgbin(:,15)),hold on ,yline(0.2,'--','V0'),yline(0.2,'--','V0')
ylim([-1 2])

% figure()
% subplot(211),plot(tVF(1:3*fa),ecgj3tcsc(:,1)),hold on ,yline(0.2,'--','V0'),yline(-0.2,'--','V0'),xlabel('time in seconds'),title('ECG normalize')
% subplot(212),plot(tVF(1:3*fa),ecgbin(:,1)),hold on ,yline(0.2,'--','V0'),xlabel('time in seconds'),title('Binary Converted ECG')
% ylim([-1 2])

% figure()
% subplot(211),plot(tVF(2*fa:5*fa-1),ecgj3tcsc(:,3)),hold on ,yline(0.2,'--','V0'),yline(-0.2,'--','V0'),xlabel('time in seconds'),title('ECG normalize')
% xlim([min(tVF(2*fa:5*fa-1)) max(tVF(2*fa:5*fa-1))]);
% subplot(212),plot(tVF(2*fa:5*fa-1),ecgbin(:,3)),hold on ,yline(0.2,'--','V0'),xlabel('time in seconds'),title('Binary Converted ECG')
% ylim([-1 2])
% xlim([min(tVF(2*fa:5*fa-1)) max(tVF(2*fa:5*fa-1))]);

figure()
plot([0:length(Ntcsc)-1]*1,Ntcsc), title('Percentage of samples passing V0 in ECG VF 20k')
xlabel('start in s of each window')
ylabel('N(%)')
