function [a, Inc_a, n, Inc_n, R2] = Uncertainty(p, rb)

%
% Originall file Incertezze.m V 1.02
%
% 04 Agosto 2011 - Dossi 
%
% sintax: [a, Inc_a, n, Inc_n, R2] = Uncertaninty(p, rb)
%
% rb = a * p^n -> log(rb) = log(a*p^n) = log(a) + n * log(p)
% Y = log(rb); X = log(p); q = log(a); m = n
% Y = m*X + q
%
X = log(p);                                                         % conversione valori di pressione in scala logaritmica
N = length(p);                                                      % lunghezza vettore delle pressioni
Y = log(rb);                                                        % conversione valori di rb in scala logaritmica

delta = N * sum(X.^2)-(sum(X))^2;                                   % denominatore per il calcolo di q e m
m = ( N*sum(X.*Y) - sum(X)*sum(Y) ) / delta;                        % coefficiente angolare della retta Y = mX + q con m = n
n = m;                                                              % dal passaggio sopra
q = ( sum(X.^2)*sum(Y) - sum(X)*sum(X.*Y)) / delta;                 % intercetta della retta Y = mX + q con m = n

Y_eval = m .* X + q;                                                % valori valutati tramite equazione della retta appena calcolata
sig = ( ( sum( ( Y - Y_eval ).^2) ) / (N-2) )^0.5;                  % scarto quadratico medio dei valori reali da quelli della retta

Inc_m = sig * (N/delta)^0.5;                                        % incertezza del coeff "m" (che coincide con quella di "n")
Inc_n = Inc_m;                                                      % dal passaggio sopra
Inc_q = sig * ( sum( X.^2 ) / delta )^0.5;                          % incertezza del coeff "q"

a = exp(q);                                                         % calcolo del valore "a"
a_new_up = a * exp(Inc_q);                                          % calcolo della parte superiore l'incertezza di "a"
a_new_down = a / exp(Inc_q);                                        % calcolo della parte inferiore per l'incertezza di "a"
Inc_a = ( a_new_up - a_new_down) / 2;                               % calcolo di "a"


M_Y = mean(Y);                                                      % calcolo della media di Y
dev_reg = sum ( (Y_eval - M_Y).^2 );                                % calcolo della devianza di regressione
dev_tot = sum ( (Y - M_Y).^2 );                                     % calcolo della devianza totale
R2 = dev_reg / dev_tot;                                             % calcolo del coefficiente R^2

return