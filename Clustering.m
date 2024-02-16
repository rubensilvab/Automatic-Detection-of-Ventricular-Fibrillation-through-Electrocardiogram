clear all
close all
clc
% Values for the median of the boxplots for each patient for each metric
% with 10-second windows
% Each column corresponds to one patient


ffsC=[2,2.50000000000000,1.50000000000000,4,6.50000000000000,2.50000000000000,2.50000000000000,1.50000000000000,6.50000000000000,2,3,1,1.50000000000000,3.50000000000000,4.50000000000000,1.50000000000000,5.50000000000000,6,2.50000000000000,2.50000000000000,2,1,1.50000000000000,1.50000000000000,1];

pwsC=[63055.0236893340,108949.098721458,375705.390102823,125003.815519377,110097.204392381,371411.525257865,369633.454484322,139390.300308075,216347.268888355,101075.970099968,57025.8604869984,219614.285486411,245440.376700490,149462.027789865,156145.963450255,55886.3430060109,90960.7881934025,89969.0858467560,90930.5924078752,168240.606308664,105553.787446854,985400.999907418,186658.493405173,50682.4983874702,58305.2495526210];

ffsF=[7,4.50000000000000,4.50000000000000,5.50000000000000,4.50000000000000,5.50000000000000,3.50000000000000,2,4.50000000000000,4,1,3.50000000000000,3.50000000000000,3.50000000000000,3.50000000000000,3,4,4.50000000000000,4.50000000000000,4,3,5.50000000000000,3.50000000000000,5.50000000000000,4];

pwsF=[248766.014579998,521445.465548611,160894.830884836,42862.9189221240,223863.657733586,134217.669088500,733291.008656242,636239.354146676,584659.579854631,96189.3464094841,134366.103321265,66859.3149843530,246959.570701352,619974.675390331,725929.995788590,205041.883567615,201439.616957100,265581.004040585,227451.691278823,209924.208459514,754268.424482888,70295.3947992661,55659.0005440222,90665.4196513921,848926.915749595];

mediaNTSCSCC=[4.06666666666667,20.3333333333333,54.2000000000000,32.8666666666667,17.9333333333333,43.0666666666667,59.3333333333333,33.7333333333333,38.1333333333333,56.0666666666667,19.8666666666667,30.6666666666667,55.6000000000000,29.0666666666667,40.4666666666667,7.20000000000000,7.66666666666667,6.86666666666667,6.13333333333333,33.0666666666667,28,73.1333333333333,79.9333333333333,18.8666666666667,37.7333333333333];
mediaNTSCSCVF=[67.7333333333333,67.7333333333333,58.7333333333333,52.0666666666667,66.2666666666667,57.8666666666667,80.6666666666667,80.7333333333333,74.4000000000000,59.2000000000000,61,50.0666666666667,58,76.0666666666667,74.2666666666667,66.1333333333333,63.8000000000000,65.2000000000000,68.0666666666667,73.8000000000000,79.0666666666667,51.4666666666667,66,59.7333333333333,75.9333333333333];

mediaF1C=[0.0116284013605442,0.0159608843537415,0.0252763605442177,0.0422534013605442,0.0262202380952381,0.0247066326530612,0.0214540816326531,0.00833758503401361,0.0290603741496599,0.0353188775510204,0.0140603741496599,0.0220535714285714,0.0309481292517007,0.0300935374149660,0.0334268707482993,0.0154081632653061,0.0169770408163265,0.0240901360544218,0.0231207482993197,0.0445493197278912,0.0174192176870748,0.0132610544217687,0.0301020408163265,0.0299744897959184,0.00947704081632653];
mediaF1VF=[0.0548639455782313,0.0498214285714286,0.0500425170068027,0.0508715986394558,0.0464710884353742,0.0447321428571429,0.0474617346938775,0.0275297619047619,0.0653528911564626,0.0350255102040816,0.0220620748299320,0.0255399659863946,0.0240901360544218,0.0288690476190476,0.0522321428571429,0.0335119047619048,0.0319642857142857,0.0411139455782313,0.0499872448979592,0.0549532312925170,0.0480952380952381,0.0418324829931973,0.0340433673469388,0.0426658163265306,0.0495238095238095];

% CLUSTERING

% ALL METRICS
% X = [ffsC', pwsC', mediaNTSCSCC', mediaF1C'; ffsF', pwsF', mediaNTSCSCVF', mediaF1VF'];

% ALL METRICS EXCEPT POWER
X = [ffsC', mediaNTSCSCC', mediaF1C'; ffsF', mediaNTSCSCVF', mediaF1VF'];

% ALL METRICS EXCEPT FUNDAMENTAL FREQUENCY
% X = [pwsC', mediaNTSCSCC', mediaF1C'; pwsF', mediaNTSCSCVF', mediaF1VF'];

% ALL METRICS EXCEPT FUNDAMENTAL FREQUENCY AND POWER
% X = [mediaNTSCSCC', mediaF1C'; mediaNTSCSCVF', mediaF1VF'];

% ALL METRICS EXCEPT F1 AND POWER
% X = [ffsC', mediaNTSCSCC'; ffsF', mediaNTSCSCVF'];

% Only N(%)
% X = [mediaNTSCSCC'; mediaNTSCSCVF'];

% Only F1
% X = [mediaF1C'; mediaF1VF'];

% Only FF:
% X = [ffsC'; ffsF'];

% Only power
% X = [pwsC'; pwsF'];

% Metric normalization

for i=1:length(X(1,:))
    X(:,i)=(X(:,i)-min(X(:,i)))/(max(X(:,i))-min(X(:,i)))
end

%True label

truelabel=[zeros(25,1);ones(25,1)];

%Xcsv=[X truelabel]
%csvwrite('metricas_norm(sem_potencia).csv',Xcsv) 

%Clustering K-mean
[idx,C] = kmeans(X,2)
predict=idx

for i=1:length(predict)
    if predict(i)==1
        predict(i)=0
    else
        predict(i)=1
        
    end
end

[c,cm,ind,per] = confusion(truelabel',predict')
        
plotconfusion(truelabel', predict', 'Predictions with N(%) and FF [0-No fibrillation; 1-With fibrillation]')

% 
% % Hierarquial Clustering
Y = pdist(X)
Z = linkage(Y)
dendrogram(Z)
T = cluster(Z,'maxclust',2)


predicth=T

for i=1:length(predicth)
    if predicth(i)==1
        predicth(i)=0
    else
        predicth(i)=1
        
    end
end

[c,cm,ind,per] = confusion(truelabel',predicth')
        
plotconfusion(truelabel', predicth', 'Predictions with N(%) and FF [0-No fibrillation; 1-With fibrillation], Hierarchical Clustering')

