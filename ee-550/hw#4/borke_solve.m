clear
clc
lambda = 1.4
g_function = @(x) 2*atan(lambda*pi*x/2)/pi;

func1 = @(x) -1.1*x + g_function(g_function(x)/1.1=]






































































































































































); % 0 a e?it olan fonksiyon
l = 0.4; %aral?k ba?lang?c?
u = 0.7; %aral?k sonu

m = (l+u)/2; %mean value
i=1; %for iteration number

while abs(func1(m)) > 0.00001  %acceptable value of error
    if (func1(m) * func1(u)) < 0 %bisection method
        l = m;
        i=i+1;
    else
        u = m;
        i=i+1;
    end
    m = (l + u)/2;
end


err = abs( 0 - func1(m)); %in order to find error

fprintf('corresponding value is %.4f\n',m);