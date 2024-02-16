function[ecgf,t]=pre_process(ecg1,fa)
N=length(ecg1);

%Retirar média do sinal 
ecg1=ecg1-mean(ecg1);

%filtro para tirar rede eletrica

r=1;
teta=(60/fa)*2*pi; %omega=2pi*(f/fa)
z1=r*exp(j*teta);% ao por o omega equivalente à freq 60 Hz , vai tornar fase do zero e sabemos que as fases do zero serão as freq com ganhos mais baixos 
z2=r*exp(-j*teta);
num=poly([z1,z2]);
den=1;
yecg1=filter(num,den,ecg1);  %filtro rejeita banda em torno de teta , 60 hz

%FILTRO BASELINE WANDER FILTER
N200=fa*0.200; %200ms amostras
N600=fa*0.600; %600ms amostras

L=1:N200:N+1; inic=L(1);

for i=1:length(L);
    yyecg1(inic:L(i)-1)=mean(yecg1(inic:L(i)-1));
inic=L(i);
end
L=1:N600:N+1; inic=L(1);
for i=1:length(L);
    yyyecg1(inic:L(i)-1)=mean(yyecg1(inic:L(i)-1));
inic=L(i);
end

ecgf=yecg1(1:length(yyyecg1))-yyyecg1; % retirar do sinal original
Nf=length(ecgf);
t=0:1/fa:(Nf-1)/fa;