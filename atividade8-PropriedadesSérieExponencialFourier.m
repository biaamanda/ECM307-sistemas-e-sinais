syms t n n1 n2 n3

T0 = 8;
w0 = pi/4;

g = piecewise( ...
    t < -2, 0, ...
    -2 <= t & t < 0, t + 2, ...
    0 <= t & t <= 2, -t + 2, ...
    t > 2, 0);

% 1B
% Dn simplificado (usar o simplify)

Dn_t = (1/T0)*(int((t + 2)*exp(-1j*n*w0*t), t, -2, 0) + int((-t + 2)*exp(-1j*n*w0*t), t, 0, 2));
Dn_t = simplify(Dn_t);

% 1C
%% Potencia (usar sym)
Pg_t = (1/T0)*( ...
    int((t + 2)^2, t, -2, 0) + ...
    int((-t + 2)^2, t, 0, 2) );

Pg_t = simplify(Pg_t);

% 2B
N = 10;
tempo = 0:1e-3:3*T0;

%% Dn com os deslocamentos (usar o simplify)
Dn_g = simplify(Dn_t*(exp(-1j*n*w0*2) - exp(-1j*n*w0*6)));

% 2C
%% Potencia do sinal deslocado (usar sym)
g1 = subs(g, t, t-2) - subs(g, t, t-6);
Pg_g = (1/T0)*int(g1^2, t, 0, T0);

% 3A
N = 25/0.25;
T0_1 = 4;
T0_2 = 40;
T0_3 = 400;

w0_1 = (2*pi)/4
w0_2 = (2*pi)/40
w0_3 = (2*pi)/400

%% Numero de harmonicas 1
N1 = 25 *T0_1;
%% Numero de harmonicas 1
N2 = 25*T0_2;
%% Numero de harmonicas 1
N3 = 25*T0_3;

% 3B
%% Dn com T0 = 4s (usar o simplify)
D1 = (1/4)*(int((t + 2)*exp(-1j*n1*w0_1*t), t, -2, 0) + int((-t + 2)*exp(-1j*n1*w0_1*t), t, 0, 2));
D1 = simplify(D1);
D2 = (1/40)*(int((t + 2)*exp(-1j*n2*w0_2*t), t, -2, 0) + int((-t + 2)*exp(-1j*n2*w0_2*t), t, 0, 2));
D2 = simplify(D2);
D3 = (1/400)*(int((t + 2)*exp(-1j*n3*w0_3*t), t, -2, 0) + int((-t + 2)*exp(-1j*n3*w0_3*t), t, 0, 2));
D3 = simplify(D3);


% 3C
%% Dn sintetizado com T0 = 4s
D1_s = D1;
%% Dn sintetizado com T0 = 40s
D2_s = D2;
%% Dn sintetizado com T0 = 400s
D3_s = D3;

% 3D
%% Potência para T0 = 4s: (usar sym) 
Pot_4 = (1/T0_1)*( ...
    int((t + 2)^2, t, -2, 0) + ...
    int((-t + 2)^2, t, 0, 2) );
Pot_4 = simplify(Pot_4);

Pot_40 = (1/T0_2)*( ...
    int((t + 2)^2, t, -2, 0) + ...
    int((-t + 2)^2, t, 0, 2) );
Pot_40 = simplify(Pot_40);

Pot_400 = (1/T0_3)*( ...
    int((t + 2)^2, t, -2, 0) + ...
    int((-t + 2)^2, t, 0, 2) );
Pot_400 = simplify(Pot_400);
% 3E
Pg_4 = 1.333;
Pg_40 = 0.1333;
Pg_400 = 0.01333;