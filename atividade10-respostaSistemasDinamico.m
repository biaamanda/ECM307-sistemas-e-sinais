syms t w

%% Função de Entrada x(t)
%%% Função xt - Pulso retangular 
xt = rectangularPulse(0.1*t-0.5); %%%%% piecewise(0 <= t < 10, 1, 0);

%%% Plot da Função xt 
figure
fplot(xt,[-0.5, 20])
title('Função de Entrada x(t)');
xlabel('Tempo');
ylabel('Amplitude');
ylim([-0.1, 1.1])
grid on;

%% Resposta Impulsiva g(t) 
%%% Função gt - exponencial 
gt = exp(-t)*heaviside(t);

%%% Plot da Função gt
figure;
fplot(gt,[0 20]);
title('Resposta Impulsiva g(t)');
xlabel('Tempo em segundos');
ylabel('Amplitude');
ylim([-0.1, 1])
grid on;

%% Fourier da Função x(t) 
%%% Fourier da função xt transformando para a função Xw 
Xw = fourier(xt, t, w)

%%% Plot do Fourier de Xw %% Fourier da Função g(t) 
figure;
fplot(abs(Xw));
title('Fourier da Função x(t)');
xlabel('Tempo em segundos');
ylabel('Amplitude');
grid on;


%%% Fourier da função gt transformando para a função Gw 
Gw = fourier(gt, t, w);

%%% Plot do Fourier de Gw 
figure;
fplot(abs(Gw));
title('Fourier de Gw');
xlabel('Tempo em segundos');
ylabel('Amplitude');
grid on;


%% Função de Saída no domínio de Fourier 
%%% Cálculo da função Yw 
Yw = simplify(Xw*Gw);
%%% Plot do Fourier de Yw 
figure;
fplot(abs(Yw));
title('Fourier de Yw');
xlabel('Tempo em segundos');
ylabel('Amplitude');
grid on;


%% Função de Saída no domínio do tempo 
%%% Anti-Transformada de Fourier para levar Yw para yt 
yt = ifourier(Yw, w, t);

%%% Plot da Anti-Transformada de Fourier de yt
figure;
fplot(yt);
title('Anti-Transformada de Fourier de yt');
xlabel('Tempo em segundos');
ylabel('Amplitude');
grid on;
