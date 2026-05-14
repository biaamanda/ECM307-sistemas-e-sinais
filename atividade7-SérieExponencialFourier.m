%% BOAS PRÁTICAS
% clear;                  %%% Limpando todas as variáveis do workspace
% close all;              %%% Fechando todas as figuras abertas
% clc;                    %%% Limpando a janela de comandos

%%% PARÂMETROS GERAIS

T0 = 10;                %%% Período fundamental do sinal
w0 = 2*pi/T0;           %%% Frequência angular fundamental
N = 10;                 %%% Número de harmônicas positivas e negativas
n_vals = -N:N;          %%% Vetor das harmônicas consideradas na análise
freq = n_vals/T0;       %%% Vetor de frequências em Hz associado às harmônicas

%%% Determinação dos Parâmetros
tempo = 0:1e-3:3*T0;                   %%% Vetor de tempo para exibir três períodos
t_mod = mod(tempo, T0);                %%% Calcula o tempo reduzido dentro de cada período

syms t n            %%% Variáveis simbólicas para integração e coeficientes

%%%%%%%%%%%%%%%%%%%
%%% EXERCÍCIO 1 %%%
%%%%%%%%%%%%%%%%%%%

%%% Sinal g_T0(t)
g = exp(-t_mod); %%% Sinal periódico g_T0(t) = e^(-t), repetido a cada T0

% %%% Plot do sinal
% figure;                                    %%% Cria uma nova figura
% plot(tempo, g, 'LineWidth', 1.5);          %%% Plota o sinal g_T0(t) ao longo de três períodos
% title('Sinal g_{T_0}(t) em 3 períodos');   %%% Define o título do gráfico
% xlabel('Tempo (s)', 'FontWeight', 'bold'); %%% Define o título do eixo x
% ylabel('Amplitude', 'FontWeight', 'bold'); %%% Define o título do eixo y
% grid on;                                   %%% Ativa a malha de fundo do gráfico

%%%%%%%%%%%%%%%%%%%
%%% EXERCÍCIO 2 %%%
%%%%%%%%%%%%%%%%%%%

%%% Definição das variáveis simbólicas
g_simbolico = exp(-t); %%% Define simbolicamente g(t) = e^(-t), 0 < t < T0

%%% Cálculo simbólico da potência de gT0(t)
Pg_simbolico = (1/T0)*int(g_simbolico^2,t, 0, T0);
%%% Calcula simbolicamente a potência média

%%% Cálculo numérico
Pg_num = double(Pg_simbolico) %%% Converte o resultado simbólico em valor numérico

%%%%%%%%%%%%%%%%%%%
%%% EXERCÍCIO 3 %%%
%%%%%%%%%%%%%%%%%%%

%%% Cálculo simbólico de Dn
Dn_g_sym = 1/T0*int(g_simbolico*exp(-1j*n*w0*t), t, 0, T0);
%%% Define simbolicamente os coeficientes Dn de g(t)

%%% Cálculo numérico de Dn
Dn_g = double(subs(Dn_g_sym, n, n_vals)); %%% Avalia numericamente Dn para as harmônicas desejadas
amplitudes_g = abs(Dn_g); %%% Calcula o módulo dos coeficientes complexos

%%% Plotagem
% figure;                                            %%% Cria uma nova figura
% stem(freq, amplitudes_g, 'Color', 'k');            %%% Plota o espectro de amplitude discreto
% title('Espectro de Amplitude de g_{T_0}(t)');      %%% Define o título do gráfico
% xlabel('Frequência (Hz)', 'FontWeight', 'bold');   %%% Define o título do eixo x
% ylabel('Amplitude (V)', 'FontWeight', 'bold');     %%% Define o título do eixo y
% grid on;                                           %%% Ativa a malha de fundo
% axis([-1 1 0 0.1]);                                %%% Define os limites dos eixos

%%%%%%%%%%%%%%%%%%%
%%% EXERCÍCIO 4 %%%
%%%%%%%%%%%%%%%%%%%

%%% Definição das variáveis
    g_original = exp(-t_mod); %%% Gera o sinal periódico original g_T0(t)

%%% Soma de termos da série exponencial de Fourier
aux_g = zeros(size(tempo)); %%% Inicializa o vetor da reconstrução do sinal

for k = 1:length(n_vals)
    aux_g = aux_g + Dn_g(k)*exp(1j*n_vals(k)*w0*tempo);
end
 
g_reconstrucao = real(aux_g);                      %%% Toma a parte real da síntese obtida

%%% Plotagem
% figure;                                                           %%% Cria uma nova figura
% hold on;                                                          %%% Mantém os gráficos na mesma figura
% plot(tempo, g_original, 'k--', 'LineWidth', 1.2);                 %%% Plota o sinal original com linha tracejada
% plot(tempo, g_reconstrucao, 'k', 'LineWidth', 1);                 %%% Plota o sinal reconstruído pela série de Fourier
% title('Reconstrução do sinal g_{T_0}(t)', 'FontWeight', 'bold');  %%% Define o título do gráfico
% xlabel('Tempo (s)', 'FontWeight', 'bold');                        %%% Define o título do eixo x
% ylabel('Amplitude (V)', 'FontWeight', 'bold');                    %%% Define o título do eixo y
% grid on;                                                          %%% Ativa a malha de fundo
% hold off;                                                         %%% Libera a sobreposição dos gráficos

%%%%%%%%%%%%%%%%%%%
%%% EXERCÍCIO 5 %%%
%%%%%%%%%%%%%%%%%%%

%%% Cálculo do Sinal Original
    fT0 = exp(-2*t_mod); %%% Define o sinal periódico f_T0(t) = e^(-2t)

%%% Plotagem
% figure;                                            %%% Cria uma nova figura
% plot(tempo, fT0, 'LineWidth', 2, 'Color', 'k');    %%% Plota o sinal original f_T0(t)
% title('Sinal Original f_{T_0}(t)');                %%% Define o título do gráfico
% xlabel('Tempo (s)', 'FontWeight', 'bold');         %%% Define o título do eixo x
% ylabel('Amplitude (V)', 'FontWeight', 'bold');     %%% Define o título do eixo y
% grid on;                                           %%% Ativa a malha de fundo

%%% Potência de fT0(t)
f_simbolico = exp(-2*t);

%%% Potência
Pf_simbolico = (1/T0)*int(f_simbolico^2, t, 0, T0);
Pf_num = double(Pf_simbolico);



%%% Espectro de Amplitudes
Dn_f_sym = 1/T0*int(f_simbolico*exp(-1j*n*w0*t), t, 0, T0);
Dn_f = double(subs(Dn_f_sym, n, n_vals));
amplitudes_f = abs(Dn_f);

%%% Plotagem
% figure;                                            %%% Cria uma nova figura
% stem(freq, amplitudes_f, 'Color', 'k');            %%% Plota o espectro de amplitude de f_T0(t)
% title('Espectro de Amplitude de f_{T_0}(t)');      %%% Define o título do gráfico
% xlabel('Frequência (Hz)', 'FontWeight', 'bold');   %%% Define o título do eixo x
% ylabel('Amplitude (V)', 'FontWeight', 'bold');     %%% Define o título do eixo y
% grid on;                                           %%% Ativa a malha de fundo
% axis([-1 1 0 0.05]);                               %%% Define os limites dos eixos

%%% Síntese do sinal fT0(t)
aux_f = zeros(size(tempo)); %%% Realiza a soma vetorizada da série exponencial
for k = 1:length(n_vals)
    aux_f = aux_f + Dn_f(k)*exp(1j*n_vals(k)*w0*tempo);
end
f_reconstrucao = real(aux_f); %%% Obtém a parte real da reconstrução

%%% Plotagem
% figure;                                                           %%% Cria uma nova figura
% hold on;                                                          %%% Mantém os gráficos na mesma figura
% plot(tempo, fT0, 'k--', 'LineWidth', 1.2);                        %%% Plota o sinal original f_T0(t)
% plot(tempo, f_reconstrucao, 'k', 'LineWidth', 1);                 %%% Plota o sinal reconstruído
% title('Reconstrução do sinal f_{T_0}(t)', 'FontWeight', 'bold');  %%% Define o título do gráfico
% xlabel('Tempo (s)', 'FontWeight', 'bold');                        %%% Define o título do eixo x
% ylabel('Amplitude (V)', 'FontWeight', 'bold');                    %%% Define o título do eixo y
% grid on;                                                          %%% Ativa a malha de fundo
% hold off;                                                         %%% Libera a sobreposição dos gráficos

%%%%%%%%%%%%%%%%%%%
%%% EXERCÍCIO 6 %%%
%%%%%%%%%%%%%%%%%%%

%%% Construção do sinal hT0(t)
    fT0 = exp(-2*t_mod); %%% Define o sinal f_T0(t)
    gT0 = g_original; %%% Define o sinal g_T0(t)
    hT0 = gT0 + fT0; %%% Define o sinal soma h_T0(t) = f_T0(t) + g_T0(t)
    

%%% Plot do sinal original hT0(t)
% figure;                                                                               %%% Cria uma nova figura
% plot(tempo, hT0, 'LineWidth', 2, 'Color', 'k');                                       %%% Plota o sinal original h_T0(t)
% title('Sinal Original h_{T_0}(t) = f_{T_0}(t) + g_{T_0}(t)', 'FontWeight', 'bold');   %%% Define o título
% xlabel('Tempo (s)', 'FontWeight', 'bold');                                            %%% Define o título do eixo x
% ylabel('Amplitude (V)', 'FontWeight', 'bold');                                        %%% Define o título do eixo y
% grid on;                                                                              %%% Ativa a malha de fundo

%%% Potência de hT0(t)
h_simbolico = exp(-t) + exp(-2*t);
Ph_simbolico = (1/T0)*int(h_simbolico^2, t, 0, T0);%%% Calcula simbolicamente a potência média de h_T0(t)
Ph_num = double(Ph_simbolico); %%% Converte a potência para valor numérico

%%% Espectro de Amplitudes
Dn_h_sym = Dn_f_sym + Dn_g_sym;
Dn_h = Dn_f + Dn_g;
%%% Coeficientes Dn3

amplitudes_h = abs(Dn_h); %%% Calcula o módulo dos coeficientes complexos

%%% Plotagem 1
% figure;                                                                                       %%% Cria uma nova figura
% stem(freq, amplitudes_h, 'Color', 'k');                                                       %%% Plota o espectro de amplitude de h_T0(t)
% title('Espectro de Amplitude de h_{T_0}(t) = f_{T_0}(t) + g_{T_0}(t)', 'FontWeight', 'bold'); %%% Define o título
% xlabel('Frequência (Hz)', 'FontWeight', 'bold');                                              %%% Define o título do eixo x
% ylabel('Amplitude (V)', 'FontWeight', 'bold');                                                %%% Define o título do eixo y
% grid on;                                                                                      %%% Ativa a malha de fundo
% axis([-1 1 0 0.15]);                                                                          %%% Define os limites dos eixos

%%% Síntese do sinal
aux_h = zeros(size(tempo)); %%% Realiza a síntese vetorizada do sinal h_T0(t)
for k = 1:length(n_vals)
    aux_h = aux_h + Dn_h(k)*exp(1j*n_vals(k)*w0*tempo);
end
h_reconstrucao = real(aux_h);%%% Obtém a parte real da reconstrução


%%% Plotagem 2
% figure;                                                                                    %%% Cria uma nova figura
% hold on;                                                                                   %%% Mantém os gráficos na mesma figura
% plot(tempo, hT0, 'k--', 'LineWidth', 1.2);                                                 %%% Plota o sinal original h_T0(t)
% plot(tempo, h_reconstrucao, 'k', 'LineWidth', 1);                                          %%% Plota o sinal reconstruído
% title('Reconstrução do sinal h_{T_0}(t) = f_{T_0}(t) + g_{T_0}(t)', 'FontWeight', 'bold'); %%% Define o título
% xlabel('Tempo (s)', 'FontWeight', 'bold');                                                 %%% Define o título do eixo x
% ylabel('Amplitude (V)', 'FontWeight', 'bold');                                             %%% Define o título do eixo y
% grid on;                                                                                   %%% Ativa a malha de fundo
% hold off;                                                                                  %%% Libera a sobreposição dos gráficos

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CONCLUSÃO
%%% Comparação entre:
%%% 1) cálculo direto de hT0(t)
%%% 2) uso da propriedade de linearidade da Série de Fourier
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Pela linearidade da série de Fourier:
%%% Dn_h = Dn_f + Dn_g
%%% Portanto, o modo mais rápido é somar os coeficientes complexos,
%%% e só depois calcular o módulo, caso se queira o espectro de amplitude.

%%% Soma dos coeficientes complexos
Dn_h_linearidade = Dn_f + Dn_g; %%% Soma os coeficientes complexos de f_T0(t) e g_T0(t)
amplitudes_h_linearidade = abs(Dn_h_linearidade); %%% Calcula o espectro de amplitude a partir da soma 

%%% Plot da soma dos espectros via coeficientes complexos
% figure;                                                                                                   %%% Cria uma nova figura
% stem(freq, amplitudes_h_linearidade, 'Color', 'b');                                                       %%% Plota o espectro obtido por linearidade
% title('Espectro de Amplitude de h_{T_0}(t) pela soma dos coeficientes de Fourier', 'FontWeight', 'bold'); %%% Define o título
% xlabel('Frequência (Hz)', 'FontWeight', 'bold');                                                          %%% Define o título do eixo x
% ylabel('Amplitude (V)', 'FontWeight', 'bold');                                                            %%% Define o título do eixo y
% grid on;                                                                                                  %%% Ativa a malha de fundo
% axis([-1 1 0 0.15]);                                                                                      %%% Define os limites dos eixos

%%% Soma das sínteses individuais
aux_h_linearidade = zeros(size(tempo));  %%% Soma as sínteses individuais dos sinais g_T0(t) e f_T0(t)
for k = 1:length(n_vals)
    aux_h_linearidade = aux_h_linearidade + ...
        Dn_h_linearidade(k)*exp(1j*n_vals(k)*w0*tempo);
end
h_reconstrucao_linearidade = real(aux_h_linearidade); %%% Obtém a parte real da reconstrução pela linearidade

%%% Plot da síntese obtida pela soma das sínteses individuais
% figure;                                                                                       %%% Cria uma nova figura
% hold on;                                                                                      %%% Mantém os gráficos na mesma figura
% plot(tempo, hT0, 'k--', 'LineWidth', 1.2);                                                    %%% Plota o sinal original h_T0(t)
% plot(tempo, h_reconstrucao_linearidade, 'b', 'LineWidth', 1);                                 %%% Plota a síntese obtida pela soma das sínteses
% title('Reconstrução de h_{T_0}(t) pela soma das sínteses individuais', 'FontWeight', 'bold'); %%% Define o título
% xlabel('Tempo (s)', 'FontWeight', 'bold');                                                    %%% Define o título do eixo x
% ylabel('Amplitude (V)', 'FontWeight', 'bold');                                                %%% Define o título do eixo y
% grid on;                                                                                      %%% Ativa a malha de fundo
% hold off;                                                                                     %%% Libera a sobreposição dos gráficos