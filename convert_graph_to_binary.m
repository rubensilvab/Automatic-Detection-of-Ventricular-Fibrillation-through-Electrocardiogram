function [F1]=convert_graph_to_binary(ecg)

fig1=figure('visible',false);  % plot do sinal atrasado 2 amostras vs sinal atual
plot(ecg(1:end-1),ecg(2:end));

fig2=figure('visible',false);
plot(ecg(1:end-5),ecg(6:end)); % plot sinal atrasado 6 amostras vs sinal atual

frame1 = getframe(fig1); %grafico 1
im1 = frame2im(frame1);

frame2 = getframe(fig2);
im2 = frame2im(frame2);    % grafico 2

% figure()
% imshow(im1)
% figure()
% imshow(im2)

% grafico 1
BW=im2bw(im1,0.7);

% figure()
% imshow(BW)

[ii,jj]=find(~BW); % encontra valores de 0
k=find(BW);
nbrancos1=length(k); % numero de pixeis brancos 1º grafico
npretos1=length(ii);
totalpixeis1=length(BW(1,:))*length(BW(:,1));
ratio1=npretos1/totalpixeis1;

% grafico 2
BW=im2bw(im2,0.7);

% figure()
% imshow(BW)

[ii,jj]=find(~BW); % encontra valores de 0
k2=find(BW);
nbrancos2=length(k2); % numero de pixeis brancos 2º grafico
npretos2=length(ii);
totalpixeis2=length(BW(1,:))*length(BW(:,1));
ratio2=npretos2/totalpixeis2;

F1=ratio2-ratio1;  % MÉTRICA EXTRAIDA
end

