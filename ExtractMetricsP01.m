
function[freq_fundamentaisC,potenciaC,freq_mediasC,freq_fundamentaisVF,potenciaVF,freq_mediasVF,NtcscVF,NtcscC,F1C,F1VF]=boxplotecg01(ecg1,fa,tj,segm)

%Input   ecg1 -> raw ecg
%        fa -> sample frequency
%        tj -> time of each window in seconds (used for extracting metrics with 50% overlap)
%        segm -> number of samples that we want to extracted for each part of the signal (VF and Control) 

%Output   freq_fundamentaisC,freq_fundamentaisVF-> Fundamental Frequencies of the Control ECG and ECG with VF, each with shape (1, n_windows) 
%         freq_mediasC,freq_mediasVF-> Average Frequencies of the Control ECG and ECG with VF,each with shape (1, n_windows)
%         potenciaC,potenciaVF-> Power of the Control ECG and ECG with VF,each with shape (1, n_windows)
%         NtcscVF,NtcscC-> Metric N of the Control ECG and ECG with VF,each with shape (1, n_windows)
%         F1C,F1VF-> Metric F1-Ratio of the Control ECG and ECG with VF,each with shape (1, n_windows)

[yecg1,t]=pre_process(ecg1,fa); % preprocess

%ALL ECG:
%yecg1=yecg1/max(yecg1)
tc = t(1:53541); % control time 
ecgc = yecg1(1:53541); % control ECG
tVF = t(53541:end); % time with fibrillation
ecgVF = yecg1(53541:end); % ECG with fibrillation
NC = length(ecgc);
NVF = length(ecgVF);

% segm: number of samples extracted for each part of the signal 

tc = tc(1:segm); % control time 
ecgc = ecgc(1:segm); % control ECG
tVF = tVF(1:segm); % time chunk with fibrillation
ecgVF = ecgVF(1:segm); % ECG with fibrillation
NC = length(ecgc);
NVF = length(ecgVF);

% ORIGINAL PRE-PROCESSED SIGNAL WINDOWS

% tj - time of each window in seconds

% CONTROL ECG - Extract AVERAGE FREQUENCY, FUNDAMENTAL FREQUENCY, POWER, F1 WITH WINDOWS
[ecg_jane, freq_fundamentaisC, potenciaC, freq_mediasC, F1C] = windows(ecgc, fa, tj);

% VF ECG - Extract AVERAGE FREQUENCY, FUNDAMENTAL FREQUENCY, POWER, F1 WITH WINDOWS
[ecg_jane, freq_fundamentaisVF, potenciaVF, freq_mediasVF, F1VF] = windows(ecgVF, fa, tj);

% ECG VF - METRIC N OF TCSC
[ecgj3tcscVF] = TCSCwindow(ecgVF, fa); % window with 1-second step, i.e., 75% overlap

[ecgbin, NtcscVF] = TCSCconvert_binary(ecgj3tcscVF, fa);

% CONTROL ECG - METRIC N OF TCSC
[ecgj3tcscC] = TCSCwindow(ecgc, fa); % window with 1-second step, i.e., 75% overlap

[ecgbin, NtcscC] = TCSCconvert_binary(ecgj3tcscC, fa);

end
