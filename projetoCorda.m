% Codigo Matlab que implementa o algoritmo de Karplus Strong
%clear; close all; clc;

% Parâmetros
fs = 44100; % Taxa de amostragem (Hz)
freq = 440; % Lá (A4) Frequencia fundamental da corda em Hz.
duracao = 2; % Segundos

% Gera o som
y = karplusStrong(freq, duracao, fs);

% Reproduz o som
sound(y, fs);

function y = karplusStrong(freq, duracao, fs)

% karplusStrong: Gera um som de corda
% dedilhada usando o algoritmo de Karplus-Strong.
% duracao: Dura¸c~ao do som em segundos.
% y: Vetor de sa´ıda do som.
% Tamanho da linha de atraso (arredondado para o inteiro mais proximo)
N = round(fs / freq);
% N´umero total de amostras da sa´ıda
numSamples = round(duracao * fs);
% 1. Excita¸c~ao: Preencher a linha de atraso com ru´ıdo branco
% Ru´ıdo branco uniforme entre -1 e 1
delayLine = (rand(1, N) - 0.5) * 2;
y = zeros(1, numSamples); % Inicializa o vetor de sa´ıda

% 2. Loop de Karplus-Strong

for n = 1:numSamples
% Obt´em a amostra mais antiga da linha de atraso
 currentSample = delayLine(1);
% Aplica um filtro de m´edia simples (filtro passa-baixa)
% Isso simula amortecimento e decaimento
% Um filtro comum ´e a m´edia simples das duas primeiras amostras
 filteredSample = 0.5 * (delayLine(1) + delayLine(2));
% Desloca a linha de atraso
 delayLine = [delayLine(2:end), filteredSample];
% Armazena a amostra de sa´ıda atual
 y(n) = currentSample;
end

y = y / max(abs(y));

end
% Ao executar o codigo com a frequencia de 440 Hz (nota La), é possível reproduzir um som com uma boa qualidade, reconhecível como corda de violão/guitarra. Para uso profissional, extensões como Karplus Strong adicionam controle de pitch, decay e timbre com muito mais precisão.

% Escala maior (partindo de Dó)
fs       = 44100;   % Taxa de amostragem
duracao  = 2.0;
silencio = 0.05;    % Pequena pausa entre notas (50 ms)

% Notas:       C4   D4   E4   F4   G4   A4   B4   C5
nomes = {'Do','Re','Mi','Fa','Sol','La','Si','Do(8)'};
freqs = [261.63, 293.66, 329.63, 349.23, 392.00, 440, 493.88, 523.25];

% Vetor de saída completo
audioTotal = [];

fprintf('Gerando escala maior de Do...\n');

for i = 1:length(freqs)
    fprintf('  Nota: %-6s | %.2f Hz\n', nomes{i}, freqs(i));

    % Gera a nota
    nota = karplusStrong(freqs(i), duracao, fs);

    % Adiciona silêncio entre notas (evita corte abrupto)
    pausa = zeros(1, round(silencio * fs));

    audioTotal = [audioTotal, nota, pausa];
end

% Normaliza o áudio completo
audioTotal = audioTotal / max(abs(audioTotal));

% Reproduz
sound(audioTotal, fs);

% --- Plot do sinal ---
figure;
t = (0:length(audioTotal)-1) / fs;
plot(t, audioTotal);
xlabel('Tempo (s)');
ylabel('Amplitude');
title('Escala Maior de Dó — Karplus-Strong');
grid on;

% Marca o início de cada nota no gráfico
hold on;
tempoNota = duracao + silencio;
for i = 1:length(freqs)
    xline((i-1)*tempoNota, '--r', nomes{i}, 'LabelVerticalAlignment','bottom');
end

% 2 Sintetizando uma musica

clear; clc;
fs = 44100;

% E E F# G G G F# E D D
riffFreq = [329.63 329.63 369.99 392.00 392.00 392.00 ...
            369.99 329.63 293.66 293.66];
dur = 0.35;

satisfactionKS   = [];
satisfactionSine = [];

for i = 1:length(riffFreq)
    noteKS = karplusStrong(riffFreq(i), dur, fs);
    satisfactionKS = [satisfactionKS, noteKS];

    t = (0:round(dur*fs)-1) / fs;          % sem amostra extra
    noteSine = sin(2*pi*riffFreq(i)*t);
    noteSine = noteSine / max(abs(noteSine));
    satisfactionSine = [satisfactionSine, noteSine];
end

satisfactionKS   = satisfactionKS   / max(abs(satisfactionKS));
satisfactionSine = satisfactionSine / max(abs(satisfactionSine));

fprintf('Reproduzindo Karplus-Strong...\n');
sound(satisfactionKS, fs);
pause(length(satisfactionKS)/fs + 1);

fprintf('Reproduzindo senoide pura...\n');
sound(satisfactionSine, fs);
pause(length(satisfactionSine)/fs + 1);

la    = karplusStrong(440, 2.0, fs);       % variável 'la' definida
Nfft  = length(la);
Y     = fft(la);
f     = (0:Nfft-1) * (fs/Nfft);

figure('Name', 'Espectro - Lá 440 Hz (visão rápida)');
plot(f(1:floor(Nfft/2)), abs(Y(1:floor(Nfft/2))));
title('Espectro de Amplitude — Lá 440 Hz');
xlabel('Frequência (Hz)'); ylabel('|Y(f)|');
xlim([0 5000]); grid on;

% 3 Analisando som

fs      = 44100;
freq    = 440;       % Lá A4
duracao = 2.0;       % segundos

% Gera o sinal
y = karplusStrong(freq, duracao, fs);
N = length(y);

Y     = fft(y);
Y_mag = abs(Y) / N;          % amplitude normalizada
Y_mag = Y_mag(1:N/2+1);      % apenas frequências positivas
Y_mag(2:end-1) = 2*Y_mag(2:end-1); % compensar metade negativa
f_axis = (0:N/2) * fs / N;   % eixo de frequência em Hz

figure('Name', 'Análise Espectral — Lá 440 Hz (Karplus-Strong)');

subplot(3,1,1);
plot(f_axis, Y_mag, 'Color', [0.15 0.40 0.75], 'LineWidth', 0.8);
xlim([0 5000]);
xlabel('Frequência (Hz)');
ylabel('Amplitude');
title('Espectro de Amplitude — Lá 440 Hz');
grid on;

hold on;
for k = 1:10
    xline(freq*k, '--r', sprintf('%dº h', k), ...
        'Alpha', 0.5, 'LabelVerticalAlignment', 'bottom', ...
        'FontSize', 8);
end

% 4 Aplicando efeitos

clear; clc;
fs   = 44100;
freq = 440;
dur  = 2.0;

y = karplusStrong(freq, dur, fs);
y = y / max(abs(y));   % garante amplitude em [-1, 1]

% 1 — Raiz quadrada

y_sqrt = sign(y) .* sqrt(abs(y));
y_sqrt = y_sqrt / max(abs(y_sqrt));

% 2

drive = 3.0;                              % ganho de entrada
y_in  = tanh(drive * y);                 % pré-saturação
y_cubic = y_in + (y_in.^3) / 3;
y_cubic = y_cubic / max(abs(y_cubic));

% 3 — Chorus
% Chorus via linha de atraso modulada por LFO

function y_out = chorus(y, fs, rate, depth, mix)
    N       = length(y);
    t       = (0:N-1) / fs;
    delay_s = depth/1000;                      % ms → s
    max_d   = round(delay_s * fs);             % amostras
    buf     = zeros(1, max_d + 1);             % buffer circular
    y_out   = zeros(1, N);
    lfo     = sin(2*pi*rate*t);                % oscilador

    for n = 1:N
        d_var = round(max_d * (0.5 + 0.5*lfo(n)));
        d_var = max(1, min(d_var, max_d));
        idx   = mod(n - d_var - 1, max_d+1) + 1;
        y_wet = buf(idx);
        buf(mod(n-1, max_d+1)+1) = y(n);
        y_out(n) = (1-mix)*y(n) + mix*y_wet;
    end
end

y_chorus = chorus(y, fs, 0.5, 20, 0.5);
y_chorus = y_chorus / max(abs(y_chorus));

% 4 — convolução

function y_out = reverbConv(y, fs, roomSize, decay, mix)
    ir_len  = round(roomSize/1000 * fs);
    ir      = zeros(1, ir_len);
    ir(1)   = 1;

    reflTimes = round([0.03 0.05 0.08 0.12 0.18] * fs);
    reflGains = [0.7 0.5 0.4 0.3 0.2];
    for k = 1:length(reflTimes)
        idx = reflTimes(k);
        if idx <= ir_len
            ir(idx) = reflGains(k);
        end
    end

    t_ir    = (0:ir_len-1) / fs;
    tail    = randn(1, ir_len) .* exp(-t_ir / (roomSize/1000 * decay));
    tail    = tail * 0.3;
    ir      = ir + tail;
    ir      = ir / sum(abs(ir));

    N_conv   = length(y) + length(ir) - 1;
    Y_fft    = fft(y,   N_conv);
    H_fft    = fft(ir,  N_conv);
    y_wet    = real(ifft(Y_fft .* H_fft));
    y_wet    = y_wet(1:length(y));

    y_out    = (1-mix)*y + mix*y_wet;
    y_out    = y_out / max(abs(y_out));
end

y_reverb = reverbConv(y, fs, 300, 0.5, 0.45);


sinais  = {y, y_sqrt, y_cubic, y_chorus, y_reverb};
nomes   = {'Original','Raiz quadrada','Overdrive cúbico','Chorus','Reverb'};
cores   = {[0.2 0.4 0.8],[0.1 0.7 0.4],[0.8 0.2 0.2],[0.7 0.4 0.0],[0.4 0.1 0.7]};

figure('Name','Análise Espectral — Efeitos','Position',[100 100 1100 750]);
for i = 1:5
    s   = sinais{i};
    N   = length(s);
    Y   = fft(s);
    Ym  = abs(Y)/N;
    Ym  = Ym(1:N/2+1);
    Ym(2:end-1) = 2*Ym(2:end-1);
    f   = (0:N/2)*fs/N;

    subplot(5,1,i);
    plot(f, Ym, 'Color', cores{i}, 'LineWidth', 0.9);
    xlim([0 5000]); grid on;
    ylabel('|Y(f)|','FontSize',9);
    title(nomes{i},'FontSize',10);
    if i == 1
        for k = 1:8
            xline(freq*k,'--r','Alpha',0.3);
        end
    end
end
xlabel('Frequência (Hz)');
sgtitle('Espectro de amplitude — comparação de efeitos');
