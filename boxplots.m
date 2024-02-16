clear all
close all
clc


fa=250;
load('cu01m.mat');
ecg1=val;
load('cu05m.mat');
ecg5=val;
load('cu06m.mat');
ecg6=val;
load('cu07m.mat');
ecg7=val;
load('cu10m.mat');
ecg10=val;
load('cu11m.mat');
ecg11=val;
load('cu12m.mat');
ecg12=val;
load('cu15m.mat');
ecg15=val;
load('cu16m.mat');
ecg16=val;

load('cu03m.mat');
ecg03=val;
load('cu04m.mat');
ecg04=val;
load('cu08m.mat');
ecg08=val;
load('cu09m.mat');
ecg09=val;
load('cu13m.mat');
ecg13=val;
load('cu19m.mat');
ecg19=val;
load('cu20m.mat');
ecg20=val;
load('cu22m.mat');
ecg22=val;
load('cu23m.mat');
ecg23=val;
load('cu24m.mat');
ecg24=val;
load('cu26m.mat');
ecg26=val;
load('cu29m.mat');
ecg29=val;
load('cu30m.mat');
ecg30=val;
load('cu32m.mat');
ecg32=val;
load('cu33m.mat');
ecg33=val;
load('cu34m.mat');
ecg34=val;

tj=10 % tamannho da janela em s
segm=10000 % tamanho do segmento a analisar em amostras

nomes=["ecg01","ecg05","ecg6","ecg7","ecg10","ecg11","ecg12","ecg15","ecg16","ecg03","ecg04","ecg08","ecg09","ecg13","ecg19","ecg20","ecg22","ecg23","ecg24","ecg26","ecg29","ecg30","ecg32","ecg33","ecg34"];

[freq_fundamentaisC(:,1),potenciaC(:,1),freq_mediasC(:,1),freq_fundamentaisVF(:,1),potenciaVF(:,1),freq_mediasVF(:,1),NtcscVF(:,1),NtcscC(:,1),F1C(:,1),F1VF(:,1)]=boxplotecg01(ecg1,fa,tj,segm);
[freq_fundamentaisC(:,2),potenciaC(:,2),freq_mediasC(:,2),freq_fundamentaisVF(:,2),potenciaVF(:,2),freq_mediasVF(:,2),NtcscVF(:,2),NtcscC(:,2),F1C(:,2),F1VF(:,2)]=boxplotecg05(ecg5,fa,tj,segm);
[freq_fundamentaisC(:,3),potenciaC(:,3),freq_mediasC(:,3),freq_fundamentaisVF(:,3),potenciaVF(:,3),freq_mediasVF(:,3),NtcscVF(:,3),NtcscC(:,3),F1C(:,3),F1VF(:,3)]=boxplotecg06(ecg6,fa,tj,segm);
[freq_fundamentaisC(:,4),potenciaC(:,4),freq_mediasC(:,4),freq_fundamentaisVF(:,4),potenciaVF(:,4),freq_mediasVF(:,4),NtcscVF(:,4),NtcscC(:,4),F1C(:,4),F1VF(:,4)]=boxplotecg07(ecg7,fa,tj,segm);
[freq_fundamentaisC(:,5),potenciaC(:,5),freq_mediasC(:,5),freq_fundamentaisVF(:,5),potenciaVF(:,5),freq_mediasVF(:,5),NtcscVF(:,5),NtcscC(:,5),F1C(:,5),F1VF(:,5)]=boxplotecg10(ecg10,fa,tj,segm);
[freq_fundamentaisC(:,6),potenciaC(:,6),freq_mediasC(:,6),freq_fundamentaisVF(:,6),potenciaVF(:,6),freq_mediasVF(:,6),NtcscVF(:,6),NtcscC(:,6),F1C(:,6),F1VF(:,6)]=boxplotecg11(ecg11,fa,tj,segm);
[freq_fundamentaisC(:,7),potenciaC(:,7),freq_mediasC(:,7),freq_fundamentaisVF(:,7),potenciaVF(:,7),freq_mediasVF(:,7),NtcscVF(:,7),NtcscC(:,7),F1C(:,7),F1VF(:,7)]=boxplotecg12(ecg12,fa,tj,segm);
[freq_fundamentaisC(:,8),potenciaC(:,8),freq_mediasC(:,8),freq_fundamentaisVF(:,8),potenciaVF(:,8),freq_mediasVF(:,8),NtcscVF(:,8),NtcscC(:,8),F1C(:,8),F1VF(:,8)]=boxplotecg15(ecg15,fa,tj,segm);
[freq_fundamentaisC(:,9),potenciaC(:,9),freq_mediasC(:,9),freq_fundamentaisVF(:,9),potenciaVF(:,9),freq_mediasVF(:,9),NtcscVF(:,9),NtcscC(:,9),F1C(:,9),F1VF(:,9)]=boxplotecg16(ecg16,fa,tj,segm);
[freq_fundamentaisC(:,10),potenciaC(:,10),freq_mediasC(:,10),freq_fundamentaisVF(:,10),potenciaVF(:,10),freq_mediasVF(:,10),NtcscVF(:,10),NtcscC(:,10),F1C(:,10),F1VF(:,10)]=boxplotecg03(ecg03,fa,tj,segm);
[freq_fundamentaisC(:,11),potenciaC(:,11),freq_mediasC(:,11),freq_fundamentaisVF(:,11),potenciaVF(:,11),freq_mediasVF(:,11),NtcscVF(:,11),NtcscC(:,11),F1C(:,11),F1VF(:,11)]=boxplotecg04(ecg04,fa,tj,segm);
[freq_fundamentaisC(:,12),potenciaC(:,12),freq_mediasC(:,12),freq_fundamentaisVF(:,12),potenciaVF(:,12),freq_mediasVF(:,12),NtcscVF(:,12),NtcscC(:,12),F1C(:,12),F1VF(:,12)]=boxplotecg08(ecg08,fa,tj,segm);
[freq_fundamentaisC(:,13),potenciaC(:,13),freq_mediasC(:,13),freq_fundamentaisVF(:,13),potenciaVF(:,13),freq_mediasVF(:,13),NtcscVF(:,13),NtcscC(:,13),F1C(:,13),F1VF(:,13)]=boxplotecg09(ecg09,fa,tj,segm);
[freq_fundamentaisC(:,14),potenciaC(:,14),freq_mediasC(:,14),freq_fundamentaisVF(:,14),potenciaVF(:,14),freq_mediasVF(:,14),NtcscVF(:,14),NtcscC(:,14),F1C(:,14),F1VF(:,14)]=boxplotecg13(ecg13,fa,tj,segm);
[freq_fundamentaisC(:,15),potenciaC(:,15),freq_mediasC(:,15),freq_fundamentaisVF(:,15),potenciaVF(:,15),freq_mediasVF(:,15),NtcscVF(:,15),NtcscC(:,15),F1C(:,15),F1VF(:,15)]=boxplotecg19(ecg19,fa,tj,segm);
[freq_fundamentaisC(:,16),potenciaC(:,16),freq_mediasC(:,16),freq_fundamentaisVF(:,16),potenciaVF(:,16),freq_mediasVF(:,16),NtcscVF(:,16),NtcscC(:,16),F1C(:,16),F1VF(:,16)]=boxplotecg20(ecg20,fa,tj,segm);
[freq_fundamentaisC(:,17),potenciaC(:,17),freq_mediasC(:,17),freq_fundamentaisVF(:,17),potenciaVF(:,17),freq_mediasVF(:,17),NtcscVF(:,17),NtcscC(:,17),F1C(:,17),F1VF(:,17)]=boxplotecg22(ecg22,fa,tj,segm);
[freq_fundamentaisC(:,18),potenciaC(:,18),freq_mediasC(:,18),freq_fundamentaisVF(:,18),potenciaVF(:,18),freq_mediasVF(:,18),NtcscVF(:,18),NtcscC(:,18),F1C(:,18),F1VF(:,18)]=boxplotecg23(ecg23,fa,tj,segm);
[freq_fundamentaisC(:,19),potenciaC(:,19),freq_mediasC(:,19),freq_fundamentaisVF(:,19),potenciaVF(:,19),freq_mediasVF(:,19),NtcscVF(:,19),NtcscC(:,19),F1C(:,19),F1VF(:,19)]=boxplotecg24(ecg24,fa,tj,segm);
[freq_fundamentaisC(:,20),potenciaC(:,20),freq_mediasC(:,20),freq_fundamentaisVF(:,20),potenciaVF(:,20),freq_mediasVF(:,20),NtcscVF(:,20),NtcscC(:,20),F1C(:,20),F1VF(:,20)]=boxplotecg26(ecg26,fa,tj,segm);
[freq_fundamentaisC(:,21),potenciaC(:,21),freq_mediasC(:,21),freq_fundamentaisVF(:,21),potenciaVF(:,21),freq_mediasVF(:,21),NtcscVF(:,21),NtcscC(:,21),F1C(:,21),F1VF(:,21)]=boxplotecg29(ecg29,fa,tj,segm);
[freq_fundamentaisC(:,22),potenciaC(:,22),freq_mediasC(:,22),freq_fundamentaisVF(:,22),potenciaVF(:,22),freq_mediasVF(:,22),NtcscVF(:,22),NtcscC(:,22),F1C(:,22),F1VF(:,22)]=boxplotecg30(ecg30,fa,tj,segm);
[freq_fundamentaisC(:,23),potenciaC(:,23),freq_mediasC(:,23),freq_fundamentaisVF(:,23),potenciaVF(:,23),freq_mediasVF(:,23),NtcscVF(:,23),NtcscC(:,23),F1C(:,23),F1VF(:,23)]=boxplotecg32(ecg32,fa,tj,segm);
[freq_fundamentaisC(:,24),potenciaC(:,24),freq_mediasC(:,24),freq_fundamentaisVF(:,24),potenciaVF(:,24),freq_mediasVF(:,24),NtcscVF(:,24),NtcscC(:,24),F1C(:,24),F1VF(:,24)]=boxplotecg33(ecg33,fa,tj,segm);
[freq_fundamentaisC(:,25),potenciaC(:,25),freq_mediasC(:,25),freq_fundamentaisVF(:,25),potenciaVF(:,25),freq_mediasVF(:,25),NtcscVF(:,25),NtcscC(:,25),F1C(:,25),F1VF(:,25)]=boxplotecg34(ecg34,fa,tj,segm);



%TODOS ESTAS MÉTRICAS FORAM CALCULADAS PARA CADA JANELA DE 10s DO SINAL COM
%50% OVERLAP. EXCETO O N(%) QUE FOI CALCULADO PARA CADA JANELA COM 3s DO
%SINAL COM 1s-STEP

%%
close all
for i=8:13 % fazer boxplot para cada paciente
    % BOX PLOTS

figure()

boxplot([freq_mediasC(:,i),freq_mediasVF(:,i)],{'s/VF','c/VF'})
title('Frequências médias')
xlabel('ECGs com :')
ylabel('f[Hz]')
sgtitle(nomes(:,i))
figure()

boxplot([freq_fundamentaisC(:,i),freq_fundamentaisVF(:,i)],{'s/VF','c/VF'})
title('Frequências fundamentais')
xlabel('ECGs com :')
ylabel('f[Hz]')
sgtitle(nomes(:,i))
figure()

boxplot([potenciaC(:,i),potenciaVF(:,i)],{'s/VF','c/VF'})
title('Potências')
xlabel('ECGs com :')
ylabel('W')
sgtitle(nomes(:,i))

medianfreqmedC(:,i)=median(freq_mediasC(:,i));
medianfreqmedVF(:,i)=median(freq_mediasVF(:,i));
medianfreqfundC(:,i)=median(freq_fundamentaisC(:,i));
medianfreqfundVF(:,i)=median(freq_fundamentaisVF(:,i));
medianpotenciasC(:,i)=median(potenciaC(:,i));
medianpotenciasVF(:,i)=median(potenciaVF(:,i));


%saveas(figure(i),nomes(:,i),'jpg')

end
% for i=1:length(freq_fundamentaisC(1,:)) % fazer boxplot para cada paciente
%     % BOX PLOTS
% 
% figure(i)
% subplot(131),
% boxplot([freq_mediasC(:,i),freq_mediasVF(:,i)],{'Sinusal','VF'})
% title('Frequências médias')
% xlabel('ECGs com :')
% ylabel('f[Hz]')
% 
% subplot(132),
% boxplot([freq_fundamentaisC(:,i),freq_fundamentaisVF(:,i)],{'Sinusal','VF'})
% title('Frequências fundamentais')
% xlabel('ECGs com :')
% ylabel('f[Hz]')
% 
% subplot(133),
% boxplot([potenciaC(:,i),potenciaVF(:,i)],{'Sinusal','VF'})
% title('Potências')
% xlabel('ECGs com :')
% ylabel('W')
% 
% medianfreqmedC(:,i)=median(freq_mediasC(:,i));
% medianfreqmedVF(:,i)=median(freq_mediasVF(:,i));
% medianfreqfundC(:,i)=median(freq_fundamentaisC(:,i));
% medianfreqfundVF(:,i)=median(freq_fundamentaisVF(:,i));
% medianpotenciasC(:,i)=median(potenciaC(:,i));
% medianpotenciasVF(:,i)=median(potenciaVF(:,i));
% sgtitle(nomes(:,i))
% 
% %saveas(figure(i),nomes(:,i),'jpg')
% 
% end
%%
close all
for p=1:length(freq_fundamentaisC(1,:))
    % BOX PLOTS

figure(p)

boxplot([NtcscC(:,p),NtcscVF(:,p)],{'s/VF','c/VF'})
title(['N(%)(Percentagem de amostras que passam V0) para o paciente :'],nomes(:,p))
xlabel('ECGs com :')
ylabel('N(%)')

mediaNTSCSCC(:,p)=median(NtcscC(:,p));
mediaNTSCSCVF(:,p)=median(NtcscVF(:,p));

%saveas(figure(p),nomes(:,p),'jpg')
end

%%
close all
for K=1:length(freq_fundamentaisC(1,:))
    % BOX PLOTS

figure(K)

boxplot([F1C(:,K),F1VF(:,K)],{'s/VF','c/VF'})
title(['F1 RATIO para o paciente :'],nomes(:,K))
xlabel('ECGs com :')
ylabel('F1(ratio)')

mediaF1C(:,K)=median(F1C(:,K));
mediaF1VF(:,K)=median(F1VF(:,K));

%saveas(figure(K),nomes(:,K),'jpg')
end