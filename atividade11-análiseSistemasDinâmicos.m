RC = 1;
t = -1:0.1:7;
w = sym('w');
s = sym('s');
ts = sym('t');


%% Fourier

%%%%% Sistema - filtro passa baixa

Gw = 1 ./ (1i*w*RC + 1);
Gw = sym(Gw);

%%%%% Transformada da entrada

Xw = pi*dirac(w) + 1./(j*w);
Xw = sym(Xw);

%%%%% Saída em laplace

Yw = Gw.*Xw;

%%%%% Saída no tempo

ytw = simplify(ifourier(Yw, w, ts));

%% Laplace

%%%%% Sistema - filtro passa baixa

Gs = 1/(s*RC + 1);

%%%%% Transformada da entrada

Xs = 1 / s;

%%%%% Saída em laplace

Ys = Gs * Xs;

%%%%% Saída no tempo

yts = ilaplace(Ys, s, ts);;

%% Convolução

yconv = (1 - exp(-ts/RC)) * heaviside(ts);

%% Pontos notáveis

ponto_1 = 1 - exp(-1);
ponto_2 = 1 - exp(-5);