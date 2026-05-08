syms t n a;
T0_12 = sym(1);

% Valor eficaz de um sinal

%% Exercício 1

V_medio1 = sym(0); % valor médio de Delta_1(t)
V_medio2 = sym(0); % valor médio de Delta_2(t)
Vpico1   = sym(1)/2;% valor de pico de Delta_1(t)
Vrms1    = sqrt(sym(3))/6; % valor eficaz de Delta_1(t)
Vpico2   = sym(1)/2; % valor de pico de Delta_2(t)
Vrms2    = sqrt(sym(3))/6; % valor eficaz de Delta_2(t)
Razao1   = sqrt(sym(3)); % razão Vpico/Vrms de Delta_1(t)
Razao2   = sqrt(sym(3)); % razão Vpico/Vrms de Delta_2(t)

%% Exercício 2
w0 = 2*pi/T0_12;
Dn1_syms = (1/T0_12)*int((t + 0.5)*exp(-1j*n*w0*t), t, -1, 0);% coeficiente Dn da série exponencial de Fourier de Delta_1(t)
Dn2_syms = (1/T0_12)*int((-t + 0.5)*exp(-1j*n*w0*t), t, 0, 1); % coeficiente Dn da série exponencial de Fourier de Delta_2(t)

%% Exercício 3
Dn12_syms = Dn1_syms + Dn2_syms; % soma dos coeficientes Dn1 e Dn2

% Correlação entre sinais

%% Exercício 1
T0_3 = sym(4);
V_medio3 = sym(1); % valor médio de Delta(t)
Vrms3    = (2*sqrt(sym(3)))/3; % valor eficaz de Delta(t)

%% Exercício 2
T0_4 = sym(8);
Vrms4  = (2*sqrt(sym(3)))/3; % valor eficaz de g1(t)
Vpico4 = sym(2); % valor de pico de g1(t)
Razao4 = sqrt(sym(3)); % razão Vpico/Vrms de g1(t)
Vrms5  = (sqrt(sym(2))*sqrt(sym(3)))/3; % valor eficaz de Delta(t-2) no caso de g1(t)
Vrms6  = (sqrt(sym(2))*sqrt(sym(3)))/3; % valor eficaz de Delta(t-6) no caso de g1(t)


%% Exercício 3
T0_5 = sym(6);
Vrms7  = (2*sqrt(sym(3)))/3; % valor eficaz de g2(t)
Razao5 = sqrt(sym(3)); % razão Vpico/Vrms de g2(t)
Vrms8 = (2*sqrt(sym(2)))/3; % valor eficaz de Delta(t-2) no caso de g2(t)
Vrms9 = (2*sqrt(sym(2)))/3; % valor eficaz de Delta(t-6) no caso de g2(t)


%% Exercício 4

corr1_tau0 = sym(0); % correlação entre Delta(t-2) e Delta(t-6) em tau = 0     int(t, 0, T);
corr2_tau0 = sym(4)/3; % correlação entre Delta(t-2) e Delta(t-4) em tau = 0

% Banda ocupada por um sinal

%% Exercício 1
T0 = sym(20);

g = piecewise( ...
    t < 0, 0, ...
    t >= 0 & t < 10, 1 - exp(-a*t), ...
    t >= 10 & t < 20, exp(-a*t + a*10), ...
    t >= 20, 0);

Pg_syms = (1/T0)*int(g^2, t, 0, 20); % potência do sinal g(t) em função de a

%% Exercício 2
a_val = sym(2);

Pg6 = subs(Pg_syms, a, a_val); % potência do sinal g(t) para a = 2

w0 = 2*pi/T0;

Dn6_syms = (1/T0)*int(g*exp(-1j*n*w0*t), t, 0, 20);
Dn6_syms = subs(Dn6_syms, a, a_val); % coeficiente Dn da série exponencial de Fourier de g(t) para a = 2

D06 = (1/T0)*int(g, t, 0, 20);
D06 = subs(D06, a, sym(2));
D06 = simplify(D06); % termo DC de g(t) para a = 2

%% Exercício 3
N95         = sym(3); % menor N para que a potência sintetizada atinja 95% da potência original
f06         = 1/T0; % frequência fundamental do sinal g(t)
Banda95_uni =  N95 * f06; % banda unilateral correspondente a 95% da potência
Banda95_bi  = 2 * Banda95_uni; % largura bilateral do espectro correspondente a 95% da potência

% Derivando e integrando sinais

%% Exercício 1

q = piecewise( ...
    t < -2, 0, ...
    t >= -2 & t < 0, 1, ...
    t >= 0 & t < 2, -1, ...
    t >= 2, 0);

q_m1 = subs(q, t, -1); % valor de q(t) em t = -1
q_1  = subs(q, t, 1); % valor de q(t) em t = 1
q_3  = subs(q, t, 3); % valor de q(t) em t = 3

%% Exercício 2
Dn = (4/(pi^2*n^2)) * (1 - (-1)^n)/2;

D07 = sym(1); % coeficiente Dn de Delta(t) para n = 0
D17 = subs(Dn, n, 1); % coeficiente Dn de Delta(t) para n = 1
D27 = subs(Dn, n, 2); % coeficiente Dn de Delta(t) para n = 2
D37 = subs(Dn, n, 3); % coeficiente Dn de Delta(t) para n = 3

%% Exercício 3
Dnmod17_0 = 1j*0*w0*Dn; % coeficiente modificado j*n*w0*Dn para n = 0
    Dnmod17_1 = sym(2)*1j/pi; % coeficiente modificado j*n*w0*Dn para n = 1
Dnmod17_2 = subs(1j*n*w0*Dn, n, 2); % coeficiente modificado j*n*w0*Dn para n = 2
    Dnmod17_3 = (sym(2)*1j)/(3*pi); % coeficiente modificado j*n*w0*Dn para n = 3

%% Exercício 4
Dnmod18_0 = -0^2*w0^2*Dn; % coeficiente modificado -n^2*w0^2*Dn para n = 0
    Dnmod18_1 = sym(-1); % coeficiente modificado -n^2*w0^2*Dn para n = 1
Dnmod18_2 = subs(-n^2*w0^2*Dn, n, 2); % coeficiente modificado -n^2*w0^2*Dn para n = 2
    Dnmod18_3 = sym(-1); % coeficiente modificado -n^2*w0^2*Dn para n = 3

%% Exercício 5
Dnmod19_syms = piecewise(n == 0, sym(0),-4i*(1 - (-1)^n)/(pi^3*n^3));
Dnmod19_0 = simplify(subs(Dnmod19_syms, n, 0)); % coeficiente modificado Dn/(j*n*w0) para n = 0
Dnmod19_1 = simplify(subs(Dnmod19_syms, n, 1)); % coeficiente modificado Dn/(j*n*w0) para n = 1
Dnmod19_2 = simplify(subs(Dnmod19_syms, n, 2)); % coeficiente modificado Dn/(j*n*w0) para n = 2
Dnmod19_3 = simplify(subs(Dnmod19_syms, n, 3)); % coeficiente modificado Dn/(j*n*w0) para n = 3