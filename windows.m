function[ecg,ffc,Esco,freq_med,F1]=windows(yecg1,fa,tj)

% Input :
        % tj - Window time in seconds
        % fa - Sampling frequency

%Output:
        % ecg->  all the yecg1 divided with Windows with 50% overlap shape (N, N_windows)
        % ffc,Esco,freq_med,F1 -> Fundamental Frequency, Power , Average Frequency, F1 Ratio, shape (1,N_windows)
          
N = fa * tj; % samples of each window

L = 1:(N)/2:length(yecg1) + 1; 
inic = L(1);

for i = 2:length(L)
    if L(i) ~= L(end)
        ecg(:,i-1) = yecg1(inic:L(i) + ((N)/2) - 1);
        inic = L(i);

        reswelch = 0.5;
        Npw = fa / reswelch;
        [Sw(:,i-1), fw] = pwelch(ecg(:,i-1), ones(1,Npw), 0.5*Npw, Npw, 'power', fa);
        
        % Fundamental Frequency
        indc = find(Sw(:,i-1) == max(Sw(:,i-1)));
        ffc(:,i-1) = fw(indc); % control
        
        % Signal Energy 
        Esc(:,i-1) = mean(ecg(:,i-1).^2);
        
        % Signal Power 
        Esco(:,i-1) = sum(Sw(:,i-1));
        
        % Normalize S 
        NormS(:,i-1) = Sw(:,i-1) ./ Esco(:,i-1);
        
        % Average Frequency L
        freq_med(:,i-1) = sum(NormS(:,i-1) .* fw);
        
        % F1-RATIO Phase Image
        [F1(:,i-1)] = convert_graph_to_binary(ecg(:,i-1));
    end
end
