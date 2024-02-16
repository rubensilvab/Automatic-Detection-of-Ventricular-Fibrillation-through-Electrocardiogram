clear all
close all
clc
% VALORES PARA A MÉDIANA DOS BOXPLOTS DE CADA PACIENTE PARA CADA MÉTRICA
% com janelas de 10s
% CADA COLUNA CORRESPONDE A UM PACIENTE

fmdsC=[6.93789184077131,5.36259478018633,2.97186091795056,5.37283701099880,6.97927742086553,3.12725078330899,2.80468412324899,3.88873357175735,6.66542886908382,3.35502226997993,5.51804443589246,4.29072866614722,4.36559832626369,5.24392111872419,5.82700045560895,9.22213822867878,7.46388576187912,7.44775244458397,6.90080249966078,5.57717727290550,5.82474116170323,2.18699958439579,3.98073732569026,8.01930197094957,4.48123247723638];

ffsC=[2,2.50000000000000,1.50000000000000,4,6.50000000000000,2.50000000000000,2.50000000000000,1.50000000000000,6.50000000000000,2,3,1,1.50000000000000,3.50000000000000,4.50000000000000,1.50000000000000,5.50000000000000,6,2.50000000000000,2.50000000000000,2,1,1.50000000000000,1.50000000000000,1];

pwsC=[63055.0236893340,108949.098721458,375705.390102823,125003.815519377,110097.204392381,371411.525257865,369633.454484322,139390.300308075,216347.268888355,101075.970099968,57025.8604869984,219614.285486411,245440.376700490,149462.027789865,156145.963450255,55886.3430060109,90960.7881934025,89969.0858467560,90930.5924078752,168240.606308664,105553.787446854,985400.999907418,186658.493405173,50682.4983874702,58305.2495526210];

fmsF=[6.53091984724061,5.06725317859352,5.05767142233191,6.56620006966621,6.03612332153899,6.29060104157731,4.00445005915632,2.57175840355306,5.84519836723578,4.38317185605978,2.74784655131614,4.08624419389340,4.39652782885778,5.17723489725706,4.13289942722657,3.80473868075334,4.50593412739850,5.07368372326508,5.42358253437163,4.87236185038995,3.19251080569822,6.60178885334883,4.74116436948842,6.47801274977013,4.21488132852071];

ffsF=[7,4.50000000000000,4.50000000000000,5.50000000000000,4.50000000000000,5.50000000000000,3.50000000000000,2,4.50000000000000,4,1,3.50000000000000,3.50000000000000,3.50000000000000,3.50000000000000,3,4,4.50000000000000,4.50000000000000,4,3,5.50000000000000,3.50000000000000,5.50000000000000,4];

pwsF=[248766.014579998,521445.465548611,160894.830884836,42862.9189221240,223863.657733586,134217.669088500,733291.008656242,636239.354146676,584659.579854631,96189.3464094841,134366.103321265,66859.3149843530,246959.570701352,619974.675390331,725929.995788590,205041.883567615,201439.616957100,265581.004040585,227451.691278823,209924.208459514,754268.424482888,70295.3947992661,55659.0005440222,90665.4196513921,848926.915749595];

mediaNTSCSCC=[4.06666666666667,20.3333333333333,54.2000000000000,32.8666666666667,17.9333333333333,43.0666666666667,59.3333333333333,33.7333333333333,38.1333333333333,56.0666666666667,19.8666666666667,30.6666666666667,55.6000000000000,29.0666666666667,40.4666666666667,7.20000000000000,7.66666666666667,6.86666666666667,6.13333333333333,33.0666666666667,28,73.1333333333333,79.9333333333333,18.8666666666667,37.7333333333333];
mediaNTSCSCVF=[67.7333333333333,67.7333333333333,58.7333333333333,52.0666666666667,66.2666666666667,57.8666666666667,80.6666666666667,80.7333333333333,74.4000000000000,59.2000000000000,61,50.0666666666667,58,76.0666666666667,74.2666666666667,66.1333333333333,63.8000000000000,65.2000000000000,68.0666666666667,73.8000000000000,79.0666666666667,51.4666666666667,66,59.7333333333333,75.9333333333333];

mediaF1C=[0.0116284013605442,0.0159608843537415,0.0252763605442177,0.0422534013605442,0.0262202380952381,0.0247066326530612,0.0214540816326531,0.00833758503401361,0.0290603741496599,0.0353188775510204,0.0140603741496599,0.0220535714285714,0.0309481292517007,0.0300935374149660,0.0334268707482993,0.0154081632653061,0.0169770408163265,0.0240901360544218,0.0231207482993197,0.0445493197278912,0.0174192176870748,0.0132610544217687,0.0301020408163265,0.0299744897959184,0.00947704081632653];
mediaF1VF=[0.0548639455782313,0.0498214285714286,0.0500425170068027,0.0508715986394558,0.0464710884353742,0.0447321428571429,0.0474617346938775,0.0275297619047619,0.0653528911564626,0.0350255102040816,0.0220620748299320,0.0255399659863946,0.0240901360544218,0.0288690476190476,0.0522321428571429,0.0335119047619048,0.0319642857142857,0.0411139455782313,0.0499872448979592,0.0549532312925170,0.0480952380952381,0.0418324829931973,0.0340433673469388,0.0426658163265306,0.0495238095238095];

% % Xcsv=[fmdsC',fmsF',ffsC',ffsF',pwsC',pwsF',mediaNTSCSCC',mediaNTSCSCVF',mediaF1C',mediaF1VF']
% % csvwrite('5 metricas_resultados_medianas das janelas.csv',Xcsv)



F=figure();
boxplot([fmdsC',fmsF'],{'s/VF','c/VF'})
title('Frequências médias')
xlabel('ECGs:')
ylabel('f[Hz]')
%saveas(F,'Frequências_Médias','jpg')

FF=figure();
boxplot([ffsC',ffsF'],{'s/VF','c/VF'})
title('Frequências fundamentais')
xlabel('ECGs:')
ylabel('f[Hz]')
%saveas(FF,'Frequências_Fundamentais','jpg')

P=figure();
boxplot([pwsC',pwsF'],{'s/VF','c/VF'})
title('Potências')
xlabel('ECGs:')
ylabel('W')
%saveas(P,'Potências','jpg')

NT=figure();

boxplot([mediaNTSCSCC',mediaNTSCSCVF'],{'s/VF','c/VF'})
title('N(%)(Percentagem de amostras que passam V0)')
xlabel('ECGs com :')
ylabel('N(%)')
%saveas(NT,'N(%)','jpg')

FI=figure();

boxplot([mediaF1C',mediaF1VF'],{'s/VF','c/VF'})
title('F1 RATIO ')
xlabel('ECGs com :')
ylabel('F1 ( ratio ->pixeis pretos/ total)')

%saveas(FI,'F1(ratio)','jpg')
%%
% Teste de hipoteses

%FREQUÊNCIAS MÉDIAS
[pFM,hFM,statsFM] = signrank(fmdsC',fmsF')
% Como h=0 e p=0.1578 > 0.05 , significa que o nosso teste de hipoteses não
% conseguiu rejeitar a hipotese nula de que a diferença das médias entre as
% duas amostras emparelhadas é 0 . Significando assim que a média pode ser
% igual tanto em VF como não VF , sendo assim uma métrica que não vai permitir
% distiguir VF de não VF.

% FREQUÊNCIAS FUNDAMENTAIS

[pFF,hFF,statsFF] = signrank(ffsC',ffsF')

% Como h=1 e p=0.0079 < 0.05 , significa que o nosso teste de hipoteses 
% conseguiu rejeitar a hipotese nula de que a diferença das médias entre as
% duas amostras emparelhadas é 0 . Significando assim que a média pode ser
% diferente  para VF e não VF , sendo assim uma métrica BOA para
% distiguir VF de não VF.

% POTENCIA

[pPW,hPW,statsPW] = signrank(pwsC',pwsF')

% Como h=1 e p=0.037 < 0.05 , significa que o nosso teste de hipoteses 
% conseguiu rejeitar a hipotese nula de que a diferença das médias entre as
% duas amostras emparelhadas é 0 . Significando assim que a média pode ser
% diferente  para VF e não VF , sendo assim uma métrica BOA para
% distiguir VF de não VF.

% N(%)(Percentagem de amostras que passam V0)
[pN,hN,statsN] = signrank(mediaNTSCSCC',mediaNTSCSCVF')

% Como h=1 e p << 0.05 , significa que o nosso teste de hipoteses 
% conseguiu rejeitar a hipotese nula de que a diferença das médias entre as
% duas amostras emparelhadas é 0 . Significando assim que a média pode ser
% diferente  para VF e não VF , sendo assim uma métrica BOA para
% distiguir VF de não VF.

%FASE-IMAGE
[pFI,hFI,statsFI] = signrank(mediaF1C',mediaF1VF')

% Como h=1 e p << 0.05 , significa que o nosso teste de hipoteses 
% conseguiu rejeitar a hipotese nula de que a diferença das médias entre as
% duas amostras emparelhadas é 0 . Significando assim que a média pode ser
% diferente  para VF e não VF , sendo assim uma métrica BOA para
% distiguir VF de não VF.

% RESUMO: MELHOR PARA PIOR
%1-FASE-IMAGE
%2-N(%)
%3-Frequências fundamentais
%4-Potências
%5-Frequências medias (má-não conseguimos rejeitar H0)

















%%
clear all
close all
clc
% VALORES PARA A MÉDIANA DOS BOXPLOTS DE CADA PACIENTE PARA CADA MÉTRICA
% com janelas de 7.5s
% CADA LINA CORRESPONDE A UM PACIENTE

fmdsC=[6.97285623877827,5.79885719401984,2.95298967268957,5.49988119083631,6.83169735428502,3.07215866271922,2.80757269551257,4.60144947018942,6.67851686784950,3.37984133224933,5.47955839488797,4.98816097963138,4.34432548345999,5.27673192843815,5.74914215941288,9.29960472169287,7.35268019895042,7.32696701009089,6.84587597367345,5.46949100924749,5.92805781748088,2.31646753486128,3.88981282721670,8.03882688378664,4.35658830265887];

ffsC=[2,2.50000000000000,1.50000000000000,4,6.50000000000000,2.50000000000000,2.50000000000000,1.50000000000000,6.50000000000000,2,4.50000000000000,1,2,3.50000000000000,4.50000000000000,1.50000000000000,5.50000000000000,6,2.50000000000000,2.50000000000000,2,1,1.50000000000000,1.50000000000000,1];

pwsC=[65219.6984506887,99433.7892356959,372692.756613122,124799.123564574,110266.576007826,376055.591391776,356082.195866452,100542.864619392,214128.097181439,101362.787384541,59723.0320059476,153038.591774056,240253.124316680,149432.330326183,156290.409383860,57450.7530590188,93846.3786922765,92595.1716296860,91093.4746296485,170637.536529515,99877.7298432982,1001886.98257577,188559.959151430,51212.0905592268,53771.8982830618];

fmsF=[6.05222303112355,4.98242186330674,5.03642361295004,6.59301483847756,6.08549606064928,6.04003034431992,4.13455404317368,2.54087856187697,5.80634342463541,4.34993385756272,2.74479020202804,4.20820625800786,4.35842404039564,4.83145298810661,4.12424547533457,4.20886546707317,4.53403746413306,4.87265316595838,5.44681528021695,5.04932813024373,3.17145140496794,6.57794760414144,4.75792342702485,6.20774954985143,4.23797312767035];

ffsF=[6,4.50000000000000,4.50000000000000,5.50000000000000,4.50000000000000,5.50000000000000,3.50000000000000,2,4.50000000000000,4,1,3.50000000000000,3.50000000000000,3.50000000000000,3.50000000000000,2.50000000000000,4,4,4,4,3,5.50000000000000,3.50000000000000,5.50000000000000,3.50000000000000];

pwsF=[261084.157067414,479835.959133488,165097.807328459,44207.3219403899,202641.943917819,135526.302091008,737016.144183806,684367.930507065,649896.187086236,81265.4192706770,149010.965550829,68316.5500172821,147950.874043176,807987.565501498,717281.169443589,210629.869419851,223429.214596479,257232.764271480,235890.288757795,81567.2217497753,799484.893193970,62352.6018459613,65690.7780171244,93768.0826148486,868966.578857182];

mediaNTSCSCC=[4.06666666666667,20.3333333333333,54.2000000000000,32.8666666666667,17.9333333333333,43.0666666666667,59.3333333333333,33.7333333333333,38.1333333333333,56.0666666666667,19.8666666666667,30.6666666666667,55.6000000000000,29.0666666666667,40.4666666666667,7.20000000000000,7.66666666666667,6.86666666666667,6.13333333333333,33.0666666666667,28,73.1333333333333,79.9333333333333,18.8666666666667,37.7333333333333];
mediaNTSCSCVF=[67.7333333333333,67.7333333333333,58.7333333333333,52.0666666666667,66.2666666666667,57.8666666666667,80.6666666666667,80.7333333333333,74.4000000000000,59.2000000000000,61,50.0666666666667,58,76.0666666666667,74.2666666666667,66.1333333333333,63.8000000000000,65.2000000000000,68.0666666666667,73.8000000000000,79.0666666666667,51.4666666666667,66,59.7333333333333,75.9333333333333];

mediaF1C=[0.00865221088435374,0.0118239795918367,0.0200127551020408,0.0310374149659864,0.0211309523809524,0.0187202380952381,0.0153826530612245,0.00724064625850340,0.0230824829931973,0.0270918367346939,0.00980442176870748,0.0155442176870748,0.0213605442176871,0.0254336734693878,0.0241284013605442,0.0111181972789116,0.0122874149659864,0.0178954081632653,0.0174787414965986,0.0305994897959184,0.0126870748299320,0.00791666666666666,0.0218835034013605,0.0216921768707483,0.00766581632653061];
mediaF1VF=[0.0424489795918367,0.0359268707482993,0.0396726190476191,0.0362117346938776,0.0355612244897959,0.0370790816326531,0.0337202380952381,0.0208120748299320,0.0502891156462585,0.0308971088435374,0.0161777210884354,0.0206930272108844,0.0274234693877551,0.0113307823129252,0.0352678571428571,0.0304719387755102,0.0282780612244898,0.0333035714285714,0.0379634353741497,0.0414923469387755,0.0370705782312925,0.0373256802721088,0.0309778911564626,0.0323214285714286,0.0334141156462585];

F=figure();
boxplot([fmdsC',fmsF'],{'Sinusal','VF'})
title('Frequências médias')
xlabel('ECGs com :')
ylabel('f[Hz]')
%saveas(F,'Frequências_Médias','jpg')

FF=figure();
boxplot([ffsC',ffsF'],{'Sinusal','VF'})
title('Frequências fundamentais')
xlabel('ECGs com :')
ylabel('f[Hz]')
%saveas(FF,'Frequências_Fundamentais','jpg')

P=figure();
boxplot([pwsC',pwsF'],{'Sinusal','VF'})
title('Potências')
xlabel('ECGs com :')
ylabel('W')
%saveas(P,'Potências','jpg')

NT=figure();

boxplot([mediaNTSCSCC',mediaNTSCSCVF'],{'Sinusal','VF'})
title('N(%)(Percentagem de amostras que passam V0)')
xlabel('ECGs com :')
ylabel('N(%)')
%saveas(NT,'N(%)','jpg')

FI=figure();

boxplot([mediaF1C',mediaF1VF'],{'Sinusal','VF'})
title('FASE-IMAGE , RATIO PIXEIS')
xlabel('ECGs com :')
ylabel('F1 ( ratio ->pixeis pretos/ total)')

%saveas(FI,'F1(ratio)','jpg')