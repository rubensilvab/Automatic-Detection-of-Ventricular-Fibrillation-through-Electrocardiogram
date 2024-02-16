
function[freq_fundamentaisC,potenciaC,freq_mediasC,freq_fundamentaisVF,potenciaVF,freq_mediasVF,NtcscVF,NtcscC,F1C,F1VF]=boxplotecg01(ecg1,fa,tj,segm)

[yecg1,t]=pre_process(ecg1,fa); % pre-processamento

%TODO ECG:
%yecg1=yecg1/max(yecg1)
tc=t(1:53541); % pedaço de tempo controlo
ecgc=yecg1(1:53541); %ecg controlo
tVF=t(53541:end); % pedaço de tempo com fibrilação
ecgVF=yecg1(53541:end); % ecg com fibrilação
NC=length(ecgc);
NVF=length(ecgVF);

% segm: nº de amostras extraidas para cada parte do sinal 

tc=tc(1:segm); % pedaço de tempo controlo
ecgc=ecgc(1:segm); %ecg controlo
tVF=tVF(1:segm); % pedaço de tempo com fibrilação
ecgVF=ecgVF(1:segm); % ecg com fibrilação
NC=length(ecgc);
NVF=length(ecgVF);

% JANELAS SINAL PRE-PROCESSADO ORIGINAL

%tj- tempo de cada janela em segundos


% ECG CONTROLO- VER FREQ.MED , FREQ. FUNDAMENTAL, POTENCIA, F1 COM JANELAS 
[ecg_jane,freq_fundamentaisC,potenciaC,freq_mediasC,F1C]=janelas(ecgc,fa,tj);

%ECG VF- VER FREQ.MED , FREQ. FUNDAMENTAL, POTENCIA,F1 COM JANELAS

[ecg_jane,freq_fundamentaisVF,potenciaVF,freq_mediasVF,F1VF]=janelas(ecgVF,fa,tj);

%ECG -VF~MÉTRICA N DO TCSC
[ecgj3tcscVF]=TCSCjan2(ecgVF,fa); % janela com 1s-step , ou seja 75% sobreposição

[ecgbin,NtcscVF]=TCSCconvert_binary(ecgj3tcscVF,fa);

%ECG -controlo -MÉTRICA N DO TCSC
[ecgj3tcscC]=TCSCjan2(ecgc,fa); % janela com 1s-step , ou seja 75% sobreposição

[ecgbin,NtcscC]=TCSCconvert_binary(ecgj3tcscC,fa);

end
