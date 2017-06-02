close all; clear all; clc;

% Definition of params and functions
lambda = 1.4;
g_function = @(x) 2*atan(lambda*pi*x/2)/pi;
% Equation is obtained by making differential equations equal to 0.
equation = @(x) -1.1*x + g_function(g_function(x)/1.1);
fplot(equation, [-1,1]);
title('Shape of the Differential Equation when derivates set to 0')
figure
fplot(g_function, [-10,10]);
title('Shape of the G function')

% T matrix is taken as in the lecture
T_matrix = [0 1; 1 0];

% Grid over which to calculate Energy
V1 = linspace(-1, 1);
V2 = linspace(-1, 1);

% Calculation of Energy for different values of V1 and V2 with varying
% lambda
lambda_space = linspace(lambda, 20, 10);

for l=1:length(lambda_space)
    E = zeros(length(V1), length(V2));
    for i=1:length(V1)
        for j=1:length(V2)
            % Energy term
            E_term = -1/2*(T_matrix(1,2)*V1(i)*V2(j)+T_matrix(2,1)*V1(i)*V2(j)) -(1.2)*(4/(lambda_space(l)*pi^2))*(log(cos(V1(i)*pi/2)) + log(cos(V2(j)*pi/2))); 
            E(i,j) = E_term;
        end
    end
    figure;
    % Contour plot
    contour(V1, V2, E, logspace(-1, 2, 5), 'ShowText','on')
    xlabel('V1'); ylabel('V2');
    str=sprintf('Energy contour map with lambda = %d', lambda_space(l));
    title(str);
    hold on;
    g_function = @(x) 2*atan(lambda_space(l)*pi*x/2)/pi;
    equation = @(x) -1.1*x + g_function(g_function(x)/1.1);
    points = fsolve(equation, [-1,-1]);
    plot(points(1,1), points(1,2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
    hold on;
    points = fsolve(equation, [1,1]);
    plot(points(1,1), points(1,2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
end
