function[ecgf,t]=pre_process(ecg1,fa)

%Input: ecg1-> raw ecg signal
  %     fa  -> sample frequency
  
%Output  ecgf-> preprocessed ECG
%        t-> real time

N = length(ecg1);

% Remove signal mean
ecg1 = ecg1 - mean(ecg1);

% Filter to remove powerline interference
r = 1;
theta = (60/fa) * 2 * pi; % omega = 2pi * (f/fa)
z1 = r * exp(j * theta); % setting omega equivalent to 60 Hz will nullify the phase
z2 = r * exp(-j * theta);
num = poly([z1, z2]);
den = 1;
yecg1 = filter(num, den, ecg1);  % bandstop filter around theta, 60 Hz

% Baseline Wander Filter (removes low frequencies from moving, breathing, etc)
N200 = fa * 0.200; % 200ms samples
N600 = fa * 0.600; % 600ms samples

L = 1:N200:N+1; inic = L(1);

for i = 1:length(L)
    yyecg1(inic:L(i)-1) = mean(yecg1(inic:L(i)-1));
    inic = L(i);
end

L = 1:N600:N+1; inic = L(1);
for i = 1:length(L)
    yyyecg1(inic:L(i)-1) = mean(yyecg1(inic:L(i)-1));
    inic = L(i);
end

ecgf = yecg1(1:length(yyyecg1)) - yyyecg1; % Remove from the original signal
Nf = length(ecgf);
t = 0:1/fa:(Nf-1)/fa;
