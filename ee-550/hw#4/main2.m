close all; clear all; clc;

lambda = 1.4;
g_function = @(x) 2*atan(lambda*pi*x/2)/pi;
eq1 = @(x) -1.1*x + g_function(g_function(x/1.1));
fplot(eq1, [-1,1]);

syms x
% eq = eq1(x) == 0;
% solx = solve(eq,x, 'ReturnConditions', true);
% S = vpasolve(eq1(x)==0, x, [-1 1]);
x0 = [-1 1];
fzero(eq1, x0)
