function [F1]=F1Ratio(ecg)

%Input : ecg-> ecg signal
%Output: F1 -> Metric F1 Ratio

fig1 = figure('visible', false);  % Plot of the signal delayed by 2 samples vs the current signal
plot(ecg(1:end-1), ecg(2:end));

fig2 = figure('visible', false);
plot(ecg(1:end-5), ecg(6:end)); % Plot of the signal delayed by 6 samples vs the current signal

frame1 = getframe(fig1); % Graph 1
im1 = frame2im(frame1);

frame2 = getframe(fig2);
im2 = frame2im(frame2);    % Graph 2

% figure()
% imshow(im1)
% figure()
% imshow(im2)

% Graph 1
BW = im2bw(im1, 0.7);

% figure()
% imshow(BW)

[ii, jj] = find(~BW); % Find values of 0
k = find(BW);
nbrancos1 = length(k); % Number of white pixels in the 1st graph
npretos1 = length(ii);
totalpixeis1 = length(BW(1,:)) * length(BW(:,1));
ratio1 = npretos1 / totalpixeis1;

% Graph 2
BW = im2bw(im2, 0.7);

% figure()
% imshow(BW)

[ii, jj] = find(~BW); % Find values of 0
k2 = find(BW);
nbrancos2 = length(k2); % Number of white pixels in the 2nd graph
npretos2 = length(ii);
totalpixeis2 = length(BW(1,:)) * length(BW(:,1));
ratio2 = npretos2 / totalpixeis2;

F1 = ratio2 - ratio1;  % Extracted Metric

